# ARB 
#### What is arb? 

ARB tool is a toolkit written in ruby, since June 2021.

Now i update it randomly moments, it was my first ruby project lol.

# Getting started
Clone repository with _`git clone https://github.com/komodoooo/arb-tool`_

Install the latest version of [Ruby](https://www.ruby-lang.org/en/downloads/)

After installing ruby run _`setup.sh`_ as admin, it which will install the necessary dependencies. After that, you can normally execute arb with _`ruby arb.rb`_ for more detailed information, type _`help`_
It will give you the following output:

```
ARB commands:
lookup       => show informations of a target (ip/domain)
portscan     => check open ports on a target (ip/domain)
dnsenum      => enumerate DNS (ip/domain)
ssl          => check SSL certificate (ip/domain)
svrscan      => scan possible vulns of a site's webserver
fuzzer       => do directory fuzzing in a site
linkshunt    => show related links on a site
headers      => return the headers of a site
body         => capture the html code of a site
xml-parser   => parse an xml document of a site
-r           => reset & clear display
banner       => show the banner
help         => help you :kek:
license      => view the license
exit         => exit
```

# Dependencies:

- The ruby programming language and rubygems package manager
- The gems "nokogiri", "open-uri", "colorize" (and net-http, net-dns & socket system gems)

Tested on Ubuntu WSL, Linux Mint, Ubuntu 22.04 LTS, Debian 10.

# New featuers
1) _dnsenum_ command, to enumerate DNS
2) _svrscan_ command, scan for possible webserver vulns by looking at versions (Apache/Nginx)
3) _ssl_ command, to verify the ssl certificate
4) Restyling of the _fuzzer_ command for default wordlist support
5) Restyled the _lookup_ command: now it works with an API, [this](https://ipwhois.app)
6) Added an [external paper](https://www.speedguide.net) to the _portscan_ command
7) Colors, more gem compatibility + now arb is **totally** written with object oriented code + errors fix
 

Version upgrade (1.8.3 to 2.1.2, latest version. Maybe.)


# Credits

By **me**
