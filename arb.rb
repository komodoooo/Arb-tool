#!usr/bin/env ruby
require 'net/dns'
require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'colorize'
require 'socket'

HELP = """
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
exit         => exit\n\n""".light_magenta

BANNER = '''
                  ___
 ▄▀█ █▀█ █▄▄     / | \ 
 █▀█ █▀▄ █▄█    |--0--|
                 \_|_/        By Komodo

                 '''.cyan[..-5]
print BANNER

begin 
    require_relative 'config/version.rb'
    puts VERSION.show
rescue LoadError
    nil
end

=begin
Komodo, 5/02/2022
Hi reader of this code, i'm sorry for eventually
shitty codes in arb. It was my first ruby project in 2021
Right now, I update it in randomly moments
=end

class Commands 
    def headers(target)
        begin
            response = Net::HTTP.get_response(URI(target))
            response.to_hash['set-cookie']                    
            puts "Headers:\n #{response.to_hash.inspect.gsub("],","],\n")}".yellow
        rescue => err
            puts "\rselect a valid target! (example https://pornhub.com)\n#{err}".red
        end
    end
    def lookup(oscuro)
        urrah = URI("https://ipwhois.app/json/#{oscuro}")
        mlml = Net::HTTP.get(urrah)
        puts "\n#{mlml.gsub(",", ",\n")}\n".yellow
    end
    def body(body)
        @bname = body.split("/")[2]
        begin
            puts "\rhere the html code\n"
            body_capture = Net::HTTP.get_response(URI(body))                 
            print "\n#{body_capture.body.yellow}\n\n"
            bsource = File.new("#{@bname}.html", 'a')
            bsource.write(body_capture.body)
            bsource.close()
            puts "\rAll saved on #{@bname}.html!\n".yellow
        rescue => err
            puts "\rselect a valid target! (example https://pornhub.com)\n#{err}".red
        end
    end
    def linkshunt(site)
        begin      
            puts "\rtarget selected: #{site}"
            parse = Nokogiri::HTML(open(site))
            scrape = parse.css("a[href]").map {|element| element["href"]}
            puts "\nCorrelateds link at #{site}:\n".yellow
            scrape.each do |link|
                Thread.new{puts "\r#{link}".yellow}.join
            end
        rescue => err
            puts "\rselect a valid target! (example https://pornhub.com)\n#{err}".red
        end    
    end
    def portscanner(address)  
        puts "\rPress Ctrl+C to interrupt\r".yellow
        ports = [15,20,21,22,23,25,51,53,67,68,80,123,135,139,143,161,162,
                199,220,389,443,445,465,546,547,587,647,847,989,990,993,995,
                1029,1098,1099,1194,2082,2083,2087,2095,2096,2638,
                3306,3389,5900,8080,8888]
        #ports = Range.new(1,9999)      Ranges? Nah.
        begin
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
                        puts "\rPort #{port} is open \nhttps://www.speedguide.net/port.php?port=#{port}".yellow
                    else
                        puts "\rPort #{port} is closed".red
                    end
                }.join()
                rescue Interrupt
                    #raise "interrupted"
                    puts "\rInterrupted, press enter to continue.\n".yellow
                    break
                end
            end    
        rescue SocketError => err
            puts "Select a velid target! (example www.google.com)\n#{err}".red
        end
    end
    def xml_parser(document)
        begin
            ehm = Nokogiri::XML(open(document)) do |config|  
                puts "#{config.strict.noblanks}".yellow[..-5]
            end
            print ehm
            puts "\nAll saved in the file document.xml!\n"
            document = File.new("document.xml", 'a')
            document.write(ehm)
            document.close()
        rescue => err
            puts "\rselect a valid target! (example https://google.com/sitemap.xml)\n#{err}".red
        end
    end
    def fuzzer(link, wordlist)
        begin
            wordlist = File.open(wordlist)
            ohyes = wordlist.map {|x| x.chomp }
            link.delete_suffix!("/") unless link[-1..-1] != "/"
            ohyes.each do |dir|
                Thread.new{
                    uriiii = URI("#{link}/#{dir}/")
                    requestt = Net::HTTP.get_response(uriiii)
                    if requestt.code == '200'
                        puts "\ndirectory open! '#{dir}'".yellow
                        log = File.new("valid.log", "a")
                        log.write(dir+"\n")
                        log.close()
                        puts "saved on file valid.log!".yellow
                    else
                        puts "\nscanning...#{requestt.code}".cyan                    #directory closed
                    end
                }.join
            end
        rescue Errno::ENOENT, Errno::ECONNREFUSED
            puts "\rERROR: Select a valid wordlist! (make sure that file of wordlist is on the same path)".red
        rescue Net::OpenTimeout
            puts "\rERROR: Select a valid target! example: http://pain.net".red
        rescue => eeeh
            puts "\rERROR:#{eeeh}\n".red
        end
    end
    def sexssl?(oscuro)
        @ssl = true
        string = "\n#{oscuro} ssl certificate:"
        begin
            URI.open("https://#{oscuro}")
            puts "#{string} #{@ssl}\n\n".yellow[..-5]
        rescue OpenSSL::SSL::SSLError, Errno::EHOSTUNREACH, Errno::ECONNREFUSED
            @ssl = false
            puts "#{string} #{@ssl}\n\n".yellow[..-5]
        rescue => err
            puts "\nSelect a valid target! (example www.google.com)\n#{err}".red[..-5]
        end
    end
    def svrscan(target)
        r = Net::HTTP.get_response(URI(target))
        r.to_hash["set-cookie"]
        bruh = r.to_hash["server"].inspect.split().first
        server = r.to_hash["server"].inspect.gsub('["',"").gsub('"]',"")
        begin
            @vn = bruh.match("/(.*)")[1].to_s
            if bruh.include?("Apache") && @vn.split(".")[1].to_i <= 4 && @vn.split(".")[2].to_i <= 53
                puts "\n#{server} looks vulnerable, check\n".yellow[..-5]
                puts "https://www.cvedetails.com/vulnerability-list/vendor_id-45/product_id-66/Apache-Http-Server.html\n\n"
            elsif bruh.include?("nginx") && @vn <= "1.23.1"       
                puts "\n#{server} looks vulnerable, check\n".yellow[..-5]
                puts "http://nginx.org/en/security_advisories.html\n\n"
            else
                puts "\n#{server} doesn't seem vulnerable\nTry to search it on google: https://google.com/search?q=#{server}+vulnerabilities\n".yellow
            end
        rescue NoMethodError 
            puts "\n#{server} doesn't seem vulnerable\n".yellow
        end
    end
    def dnsenum(domain)
        begin
            puts " ".yellow[..-5],
            Net::DNS::Resolver.start(domain, Net::DNS::ANY).answer()
        rescue => eh 
            puts "\nSelect a valid target! (example sex.com)\n#{eh}".red[..-5]
        end
    end
end

while true
    print "\rArb>".green[..-5]
    input = gets.chomp
    raise "Exited" and break unless input != "exit"
    exec = Commands.new()
    case input
    when "headers"
        print "\rUrl: "
        exec.headers(gets.chomp)
    when "lookup"
        puts "\rRemember to select a valid target! (example www.twitter.com or 104.244.42.1)".red
        print "\rAddress: ".green
        exec.lookup(gets.chomp)
    when "body"
        print "\rUrl: "
        exec.body(gets.chomp)
    when "linkshunt"
        print "\rUrl: "
        exec.linkshunt(gets.chomp)
        puts "\n"
    when "portscan"
        puts "(example: www.google.com)"
        print "\rAddress: "
        exec.portscanner(gets.chomp)
    when "xml-parser"
        print "\rUrl: "
        exec.xml_parser(gets.chomp)
    when "fuzzer"
        print "\rUrl: "
        fuzz_target = gets.chomp
        print "\r(type default for use the default wordlist)\nselect a wordlist: "
        wordlist_option = gets.chomp
        if wordlist_option == "default"
            Thread.new{
                wordlist = Net::HTTP.get(URI("https://raw.githubusercontent.com/komodoooo/dirfuzzer/main/wordlist.txt"))
                writereq = File.new("wordlist.txt", "a")
                writereq.write(wordlist)
                writereq.close()
            }.join
            puts "\nCreated file wordlist.txt!".yellow
            Thread.new{exec.fuzzer(fuzz_target, "wordlist.txt")}.join
        else 
            exec.fuzzer(fuzz_target, wordlist_option)
        end 
    when "ssl"
        puts "\rExample: google.com"
        print "\rAddress: "
        exec.sexssl?(gets.chomp)
    when "svrscan"
        print "\rUrl: "
        begin
            exec.svrscan(gets.chomp)
        rescue => err 
            puts "\nSelect a valid target! (example http://pain.net)\n#{err}".red[..-5]
        end
    when "dnsenum"
        puts "\rExample: sex.com"
        print "\rDomain: "
        exec.dnsenum(gets.chomp)
    when "-r"
        system("clear||cls")
        puts "Clean".cyan
        puts "\n"
    when "help"
        print HELP
    when "banner"
        print BANNER
    when "license"
        begin 
            puts "\n#{File.read("config/LICENSE")}\n".yellow
        rescue => err
            puts "\rERROR: #{err}\n".red[..-5]
        end
    else 
       system(input)
    end
end
