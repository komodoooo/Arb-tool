# ARB 
A toolkit written in ruby, since June 2021.

I'm totally aware of how this project is useless but hey... commit farm.

Now i update it randomly moments, it was my first ruby project lol.

# Getting started
Clone the repository

`git clone https://github.com/komodoooo/arb-tool`

Run setup.sh (with sudo privileges)

`chmod +x setup.sh && bash setup.sh`

if you cannot install the gem "bundle" try the package `ruby-bundler` in your OS package manager

## Usage

```
-l, --lookup <IP/DOMAIN>: show informations about a host
-ps, --port-scan <IP/DOMAIN>: check well known open ports on a host
-cs, --check-ssl <IP/DOMAIN>: check SSL certificate
-d, --dnsenum <IP/DOMAIN>: enumerate DNS
-s, --svrscan <URL>: scan possible webserver vulns (Apache/Nginx)
-f, --fuzzer <URL> <WORDLIST>: do directory fuzzing on a site
-lh, --links-hunt <URL>: show related links on a site
-px, --proxy-gen : scrape proxies from 3 different sources (http/ssl/socks4)
-h, --help : This
```

## Dependencies
Ruby & Rubygems, see the [Gemfile](https://github.com/komodoooo/Arb-tool/blob/main/config/Gemfile)

Version compatibility: _`2.7<=3.0`+_

**Tested on arch and debian based machines**
