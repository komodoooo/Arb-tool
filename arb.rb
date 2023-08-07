#!/usr/bin/env ruby
require 'net/dns'
require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'socket'

HELP = <<EOF
\n-l, --lookup <IP/DOMAIN>: show informations about a host
-ps, --port-scan <IP/DOMAIN>: check well known open ports on a host
-cs, --check-ssl <IP/DOMAIN>: check SSL certificate
-d, --dnsenum <IP/DOMAIN>: enumerate DNS
-s, --svrscan <URL>: scan possible webserver vulns (Apache/Nginx)
-f, --fuzzer <URL> <WORDLIST>: do directory fuzzing on a site
-lh, --links-hunt <URL>: show related links on a site
-px, --proxy-gen : scrape proxies from 3 different sources (http/ssl/socks4)
-h, --help : This\n\n
EOF

BANNER = <<EOF
\n                  ___
 ▄▀█ █▀█ █▄▄     / | \\ 
 █▀█ █▀▄ █▄█    |--0--|
                 \\_|_/      By Komodo
      v2.1.5        

EOF

=begin

Komodo, 5/02/2022
Hi reader of this code, i'm sorry for eventually
shitty codes in arb. It was my first ruby project in 2021
Right now, I update it in randomly moments

=end

class Commands
    def lookup(oscuro)
        urrah = URI("https://ipwhois.app/json/#{oscuro}")
        mlml = Net::HTTP.get(urrah).gsub('"', "'")
        return "\n#{mlml.gsub("',", "',\n")}\n\n" 
    end
    def linkshunt(site)      
        parse = Nokogiri::HTML(URI.open(site))
        scrape = (parse.css("[href]").map{|element|element["href"]}+
                parse.css("[src]").map{|element|element["src"]})
        scrape.each do |link|
            Thread.new{puts "\r#{link}"}.join
        end
    end
    def portscanner(address)  
        ports = [15,20,21,22,23,25,51,53,67,68,80,123,135,139,143,161,162,
                199,220,389,443,445,465,546,547,587,647,847,989,990,993,995,
                1029,1098,1099,1194,2082,2083,2087,2095,2096,2638,
                3306,3389,5900,8080,8888]
        #ports = Range.new(1,9999)      Ranges? Nah.
        for port in ports
            begin
            Thread.new{
                socket = Socket.new(:INET, :STREAM)
                remote_addr = Socket.sockaddr_in(port, address)
                begin
                    socket.connect_nonblock(remote_addr)
                rescue Errno::EINPROGRESS
                    nil
                end
                sockets = Socket.select(nil, [socket], nil, 0.5)
                if sockets
                    puts "\rPort #{port} is open \nhttps://www.speedguide.net/port.php?port=#{port}"
                else
                    puts "\rPort #{port} is closed"
                end
            }.join()
            rescue Interrupt
                print "\n"
                break
            end
        end
    end
    def fuzzer(link, wordlist)
        wordlist = File.open(wordlist)
        ohyes = wordlist.map {|x| x.chomp }
        link.delete_suffix!("/") unless link[-1..-1] != "/"
        ohyes.each do |dir|
            Thread.new{
                uriiii = URI("#{link}/#{dir}/")
                requestt = Net::HTTP.get_response(uriiii)
                if requestt.code == '200'
                    puts "\ndirectory open! '#{dir}'"
                    log = File.new("valid.log", "a")
                    log.write(dir+"\n")
                    log.close()
                    puts "saved on valid.log file"
                else
                    puts "\nscanning...#{requestt.code}"
                end
            }.join
        end
    end
    def sexssl?(oscuro)
        @ssl, @ctx = true, OpenSSL::SSL::SSLContext.new()
        string, desc = "\n#{oscuro} SSL certificate:", ""
        begin
            URI.open("https://#{oscuro}")
            desc+="#{OpenSSL::SSL::SSLSocket.new(TCPSocket.new(oscuro, 443),@ctx).connect.peer_cert.issuer()}"
        rescue OpenSSL::SSL::SSLError, Errno::EHOSTUNREACH, Errno::ECONNREFUSED
            @ssl = false
        end
        return "#{string} #{@ssl}\n#{desc}\n\n"
    end
    def svrscan(target)
        r = Net::HTTP.get_response(URI(target))
        r.to_hash["set-cookie"]
        bruh = r.to_hash["server"].inspect.split().first
        server = r.to_hash["server"].inspect.gsub('["',"").gsub('"]',"")
        begin
            @vn = bruh.match("/(.*)")[1].to_s
            if bruh.include?("Apache") && @vn.split(".")[1].to_i <= 4 && @vn.split(".")[2].to_i <= 55
                return "\n#{server} looks vulnerable, check\n"+
                "https://www.cvedetails.com/vulnerability-list/vendor_id-45/product_id-66/Apache-Http-Server.html\n\n"
            elsif bruh.include?("nginx") && @vn <= "1.23.1"       
                return "\n#{server} looks vulnerable, check\nhttp://nginx.org/en/security_advisories.html\n\n"
            else
                return "\n#{server} doesn't seem vulnerable\nTry to search it on google: https://google.com/search?q=#{server}+vulnerabilities\n"
            end
        rescue NoMethodError 
            return "\n#{server} doesn't seem vulnerable\n"
        end
    end
    def dnsenum(domain)
        begin
            Addrinfo.getaddrinfo(domain,nil)
        rescue SocketError
            raise Net::DNS::Resolver::Error
        end
        dlambda=->(d){Net::DNS::Resolver.start(d,Net::DNS::A)}
        begin
            return dlambda.call(domain) 
        rescue Net::DNS::Names::ExpandError, TypeError
            return dlambda.call("www."+domain)
        end
    end
    def proxygen(url, filename, cn=true)
        rlambda=->(e){e="\r#{e}".split("</td>")[0].split("<td>")[1]}
        parse=Nokogiri::HTML(URI.open(url))
        apx='//*[@id="list"]/div/div[2]/div/table/tbody/tr[%d]/td[%d]'
        log=File.new(filename,"a")
        1..70.times do |uwu|
            xaddr=parse.xpath(apx%[uwu+1,1])
            xport=parse.xpath(apx%[uwu+1,2])
            if parse.xpath(apx%[uwu+1,7]).to_s[15]=="n"||cn==false
                puts s="#{rlambda.call(xaddr)}:#{rlambda.call(xport)}"
                log.write(s+"\n")
            else next
            end
        end
        log.close()
    end
end

begin
    print BANNER
    exec = Commands.new()
    case ARGV[0]
    when "-l","--lookup"
        puts exec.lookup(ARGV[1])
    when "-lh","--links-hunt"
        puts exec.linkshunt(ARGV[1]),"\n"
    when "-ps","--port-scan"
        exec.portscanner(ARGV[1])
    when "-f","--fuzzer"
        ft, wordlist = ARGV[1], ARGV[2]
        if wordlist == nil
            puts "\rNo wordlist selected, loading default wordlist..."
            wordlist = Net::HTTP.get(URI("https://raw.githubusercontent.com/komodoooo/dirfuzzer/main/wordlist.txt"))
            writereq = File.new("wordlist.txt", "a")
            writereq.write(wordlist)
            writereq.close()
            puts "\nCreated file wordlist.txt!"
            exec.fuzzer(ft, "wordlist.txt")
        else 
            exec.fuzzer(ft, wordlist)
        end 
    when "-cs","--check-ssl"
        puts exec.sexssl?(ARGV[1])
    when "-s","--svrscan"
        puts exec.svrscan(ARGV[1]), "\n"
    when "-d","--dnsenum"
        puts exec.dnsenum(ARGV[1]),"\n"
    when "-px", "--proxy-gen"
        phsrc = [["proxy-http.log","proxy-ssl.log","proxy-socks4.log"],
        ["https://free-proxy-list.net/","https://sslproxies.org/","https://socks-proxy.net/"]]
        (phsrc.length+1).times do |kk|
            puts exec.proxygen(phsrc[1][kk], phsrc[0][kk], (false if kk>0))
        end 
        print "all saved on #{phsrc[0].join(", ")} files\nyou can check proxies at https://hidemy.name/en/proxy-checker/\n\n"
    when "-h","--help"
        print HELP
    else
        print HELP
        raise "Error: Invalid choice\n\n"
    end
rescue => err
    abort(err.to_s+"\n\n")
end
