# SSRFuck
Fuzz for SSRF in a given URL.
The tool is fuzzing both in common SSRF GET parameters and in HTTP headers.

The tool comes with two predefined wordlists. Feel free to use as is, manipulate or contribute ;)

## Prerequisites
The tool is heavily based on [ffuf](https://github.com/ffuf/ffuf).

## Installation
Just clone the repo

```bash
git clone https://github.com/PushkraJ99/ssrfuck.git
cd ssrfuck
chmod +x ssrfuck.sh
```

## Usage

Just run the script with two arguments:
- The URL to fuzz
- Your burp collaborator URL (without the schema)

Example:
```bash
./ssrfuck.sh -d https://target.com xxxxxxx.burpcollaborator.net
```

Multiple URLs example with Bash one-liner:

```bash
./ssrfuck.sh -l list.txt xxxxxxx.burpcollaborator.net
```

### Found results in your Burp collaborator? Great!
The request information is in the subdomain, for example: `Base-Url-www.hackerone.com.xxxxx.burpcollaborator.net`.
Also, all the logs from ffuf are saved to the ffuf-output directory.

---

## Contribution
Pull requests are most welcome.

## TODO
- Add help/usage in the tool's CLI
- Add some error handling
- Add some options

---

### 🫣 Author 
[![Github](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/rotemreiss)

---

### 🥷🏻 UPGRADED BY :) 
[![Github](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/PushkraJ99)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/pushkaraj-dhuri/)
[![Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/intent/follow?screen_name=PushkraJ99) 
[![Medium](https://img.shields.io/badge/Medium-12100E?style=for-the-badge&logo=medium&logoColor=white)](https://medium.com/@pushkrajdhuri07)

---
### 🤗 JUST 4 FUN
### ✨ Stargazers
[![Stargazers repo roster for @PushkraJ99/NucleiFuzzer](https://reporoster.com/stars/dark/notext/PushkraJ99/ssrfuck)](https://github.com/PushkraJ99/ssrfuck/stargazers)

### ☢️ Forkers 
[![Forkers repo roster for @PushkraJ99/ParamSpider](https://reporoster.com/forks/dark/notext/PushkraJ99/ssrfuck)](https://github.com/PushkraJ99/ssrfuck/network/members)

## 🐍 [Snake4Readme](https://github.com/PushkraJ99/Snake4Readme)

<p align="center">
<img src="https://github.com/PushkraJ99/Snake4Readme/blob/main/Snake4Readme/grid-snake.svg">
</p><br>

[![](https://visitcount.itsvg.in/api?id=PushkraJ99&icon=8&color=12)](https://visitcount.itsvg.in)
<p align="center"> 
  <b> Visitor Count </b><br>
  <img src="https://profile-counter.glitch.me/PushkraJ99/count.svg" />
</p><br>
