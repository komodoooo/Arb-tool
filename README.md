# ARB 
#### What is arb? 

ARB tool is a toolkit written in ruby, since 2020.

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
exit         => exit
```

# Dependencies:

- The ruby programming language and rubygem package manager
- The framework nokogiri
- The gems "open-uri", "colorize" (and socket & net-http system gems)

Tested on ubuntu WSL.

# New featuers
1) Added the new ssl command, to verify the ssl certificate
2) Restyled the lookup command: now it works with an API, [this.](https://ipwhois.app)
3) Colors, colors! And more gem compatibility
4) Now arb is **totally** written with object oriented code
5) Restyling of the fuzzer command for default wordlist support
6) Added svrscan command, scan for possible webserver vulns by looking at versions (Apache/Nginx)

Version upgrade (1.8.3 to 2.1.0, latest version. Maybe.)


# Credits

By **me**
