# ARB sitescreener
What is arb, the site parser? arb is a tool written in ruby ​​which, in addition to describing various information about a target site (host, port, etc.), also captures the fingerprint, the xml version and returns it to you as output. It can also find all links related to a site, or the open ports in an ip.

# Getting started

After installing ruby ​​run _Setup.sh_ which will install the necessary dependencies. After that, it will start arb for the first time. for more detailed information, type _`help`_
It will give you the following output:
ARB Sitescreener commands:

```
local        => analyze a localhost's site
fingerprint  => capture the html code and parse an user target of a site
linkshunt    => view the correlated links in a site
portchecker  => check the open port on a target ip
-r           => reset & clear display
help         => help you :kek:
```

# Dependencies:

- The ruby programming language
- The gems 'http', 'sniffer' 'mechanize', 'open-uri' (and socket system gem)
- The framework nokogiri is already integrated into sniffer & mechanize gems

**DISCLAIMER: if the localhost is no detectable, arb give you an error.**

# Credits
By **me**, at first it took me about 15/30 minutes lol.
