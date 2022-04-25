# ARB 
What is arb? arb is a tool written in ruby which, in addition to describing various information about a target site (host, open ports, headers, etc.), also captures the fingerprint, the xml version and returns it to you as output. It can also find all links related to a site, or the open ports in an ip and fuzzing a directory in a site.

# Getting started
Clone repository with _`git clone https://github.com/komodoooo/arb-tool`_

Install the latest version of [Ruby](https://www.ruby-lang.org/en/downloads/)

After installing ruby run _`setup.sh`_ as admin, it which will install the necessary dependencies. After that, you can normally execute arb with _`ruby arb.rb`_ for more detailed information, type _`help`_
It will give you the following output:

```
ARB commands:
lookup       => show infos of an user target (ip/domain)
portscan     => check the open port on a target (ip/domain)
ssl          => check the ssl certificate (ip/domain)
headers      => returns the headers of a site
fingerprint  => capture the html code of a site
linkshunt    => view the correlated links in a site
xml-parser   => parse an xml document of a site
fuzzer       => do the directory fuzzing in a site
-r           => reset & clear display
banner       => show the banner
help         => help you :kek:
exit         => exit
```

# Dependencies:

- The ruby programming language and rubygem package manager
- The framework nokogiri
- The gems "open-uri", "colorize" (and socket & net-http system gems)

Tested on ubuntu WSL.

# New featuers
1) Added the new command ssl, for check the ssl certificate
2) Restyled the lookup command: now it's work with an API, [this.](https://ipwhois.app)
3) Colors, colors! And ore compatibiliy with the gems
4) Now arb is **totally** written with object-oriented code
5) Restyled the fuzzer command for default wordlist support

Version upgrade (1.8.3 to 2.0.1, latest version. Maybe.)


# Credits
By **me**
