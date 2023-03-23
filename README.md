# ARB 
A toolkit written in ruby, since June 2021.

I'm totally aware of how this project is useless but hey... commit farm.

Now i update it randomly moments, it was my first ruby project lol.

# Getting started
Clone the repository

`git clone https://github.com/komodoooo/arb-tool`

Run setup.sh (as admin)

`bash setup.sh`

## Usage

```
-l, --lookup <IP/DOMAIN>: show informations about a host
-p, --portscan <IP/DOMAIN>: check well known open ports on a host
-cs, --check-ssl <IP/DOMAIN>: check SSL certificate
-d, --dnsenum <IP/DOMAIN>: enumerate DNS
-s, --svrscan <URL>: scan possible webserver vulns (Apache/Nginx)
-f, --fuzzer <URL> <WORDLIST>: do directory fuzzing on a site
-lh, --links-hunt <URL>: show related links on a site
-h, --help : This
```

## Dependencies

_`ruby` `rubygems` `gems net-dns, net-http, nokogiri, open-uri, openssl, socket`_

**Tested on many debian machines.**
