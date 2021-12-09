# ARB sitescreener
What is arb, the site parser? arb is a tool written in ruby ​​which, in addition to describing various information about a target site (host, port, headers, etc.), also captures the fingerprint, the xml version and returns it to you as output. It can also find all links related to a site, or the open ports in an ip and fuzzing a directory in a site.

# Getting started

After installing ruby ​​run _Setup.sh_ which will install the necessary dependencies. After that, it will start arb for the first time. for more detailed information, type _`help`_
It will give you the following output:
ARB Sitescreener commands:

```
headers      => returns the headers of a site
site         => parse an user target (website)
fingerprint  => capture the html code of a site
linkshunt    => view the correlated links in a site
portchecker  => check the open port on a target ip
xml-version  => show the xml version of a site
fuzzer       => do the directory fuzzing in a site
-r           => reset & clear display
help         => help you :kek:
```

# Dependencies:

- The ruby programming language
- The gems 'mechanize', 'open-uri' (and socket & net-http system gems)
- The framework nokogiri is already integrated into sniffer & mechanize gems

Only avaible on Linux, |Tested on a linux subsystem.|

# New featuers
1) More compatibiliy with the gems
2) More faster with Threads
3) Version upgrade (1.6.8 to 1.7.2)

# Credits
By **me**
