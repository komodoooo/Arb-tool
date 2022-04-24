# ARB 
What is arb? arb is a tool written in ruby which, in addition to describing various information about a target site (host, open ports, headers, etc.), also captures the fingerprint, the xml version and returns it to you as output. It can also find all links related to a site, or the open ports in an ip and fuzzing a directory in a site.

# Getting started
After installing ruby run _setup.sh_ which will install the necessary dependencies. After that, it will start arb for the first time. for more detailed information, type _`help`_
It will give you the following output:
ARB Sitescreener commands:

```
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
3) More compatibiliy with the gems
4) More faster with Threads
5) Colors, colors!

Version upgrade (1.7.5 to 1.8.3)


# Credits
By **me**
