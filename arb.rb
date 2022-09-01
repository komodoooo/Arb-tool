#!usr/bin/env ruby
require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'socket'
require 'colorize'
require_relative 'config/version.rb'


def help
    puts """\n
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
exit         => exit\n""".light_magenta
end

def logo
    banner = '''
                  ___
 ▄▀█ █▀█ █▄▄     / | \ 
 █▀█ █▀▄ █▄█    |--0--|
                 \_|_/        By Komodo
'''.cyan[..-5]
    print banner
    puts VERSION.v
end

=begin
Komodo, 5/02/2022
Hi reader of this code, i'm sorry for eventually
shitty codes in arb. It was my first ruby project in 2020
Right now, I update it in randomly moments
=end

print logo
class Commands 
    def headers(target)
        begin
            response = Net::HTTP.get_response(URI(target))
            response.to_hash['set-cookie']                     #get the sexy headers
            puts "Headers:\n #{response.to_hash.inspect.gsub("],","],\n")}".yellow
        rescue Errno::ENOENT, Errno::ECONNREFUSED, SocketError
            puts "\rselect a valid target! (example https://pornhub.com)".red
        end
    end
    def lookup(oscuro)
        urrah = URI("https://ipwhois.app/json/#{oscuro}")
        mlml = Net::HTTP.get(urrah)
        puts "\n"+mlml.gsub(",", ",\n").yellow
    end
    def body(body)
        begin
            puts "\rhere the html code\n"
            body_capture = Net::HTTP.get_response(URI(body))                 
            print "\n#{body_capture.body.yellow}\n"
        rescue Errno::ENOENT, Errno::ECONNREFUSED
            puts "\rselect a valid target! (example https://pornhub.com)".red
        rescue ArgumentError => ah 
            puts "\rERROR: #{ah}".red
        end
    end
    def linkshunt(site)
        begin      
            puts "\rtarget selected: #{site}"
            parse = Nokogiri::HTML(open(site))
            scrape = parse.css("a[href]").map {|element| element["href"]}
            puts "\nCorrelateds link at #{site}:\n".yellow
            scrape.each do |link|
                puts "\r#{link}".yellow
            end
        rescue => eeeeh
            puts "ERROR\n#{eeeeh}\n".red
        end    
    end
    def portscanner(address)  
        ports = [15,20,21,22,23,25,26,51,53,67,58,67,68,69,80,102,110,119,123,
                135,139,143,161,162,200,389,443,465,587,631,989,990,
                993,995,1029,2054,2077,2078,2082,2083,2086,      #most used ports
                2087,2095,2096,3080,3306,3389,8080,8843,8888]      
        #ports = Range.new(1,5000)      Ranges? Nah.
        begin
            for numbers in ports
                Thread.new{
                    socket = Socket.new(:INET, :STREAM)
                    remote_addr = Socket.sockaddr_in(numbers, address)
                    begin
                        socket.connect_nonblock(remote_addr)
                    rescue Errno::EINPROGRESS
                    end
                    sockets = Socket.select(nil, [socket], nil, 1)
                    if sockets
                        puts "\rPort #{numbers} is open".yellow
                    else
                       puts "\rPort #{numbers} is closed".red
                    end
                }.join
            end    
        rescue SocketError => sock_err
            puts "ERROR\n#{sock_err}".red
            puts ""
        end
    end
    def xml_parser(document)
        begin
            Thread.new{
                ehm = Nokogiri::XML(open(document)) do |config|  
                    puts "#{config.strict.noblanks}".yellow[..-5]
                end
                print ehm
                puts "\nAll saved in the file document.xml!"
                document = File.new("document.xml", 'a')
                document.write(ehm)
                document.close()
            }.join
        rescue Errno::ENOENT, Errno::ECONNREFUSED, Nokogiri::XML::SyntaxError, URI::InvalidURIError, OpenURI::HTTPError
            puts "\rselect a valid target! (example https://google.com/sitemap.xml)".red
        end
    end
    def fuzzer(link, wordlist)
        begin
            wordlist = File.open(wordlist)
            ohyes = wordlist.map {|x| x.chomp }
            ohyes.each do |dir|
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
            end
        rescue Errno::ENOENT, Errno::ECONNREFUSED
            puts "\rERROR: Select a valid wordlist! (make sure that file of wordlist is on the same path)".red
        rescue Net::OpenTimeout
            puts "\rERROR: Select a valid target! example: http://pain.net".red
        rescue => eeeh
            puts "ERROR\n#{eeeh}".red
            puts ""
        end
    end
    def sexssl?(oscuro)
        ssl = true
        string = "\n#{oscuro} ssl certificate:"
        begin
            URI.open("https://#{oscuro}")
            puts "#{string} #{ssl}\n\n".yellow[..-5]
        rescue OpenSSL::SSL::SSLError, Errno::EHOSTUNREACH, Errno::ECONNREFUSED
            ssl = false
            puts "#{string} #{ssl}\n\n".yellow[..-5]
        rescue SocketError, NoMethodError => lmao 
            puts "\nSelect a valid target! (example www.google.com)".red[..-5]
            puts lmao
        end
    end
    def svrscan(target)
        r = Net::HTTP.get_response(URI(target))
        r.to_hash["set-cookie"]
        bruh = r.to_hash["server"].inspect.split().first
        server = r.to_hash["server"].inspect.gsub('["',"").gsub('"]',"")
        begin
            a = bruh.match("/(.*)")[1].to_s
            if bruh.include?("Apache") && a.split(".")[1].to_i <= 4 && a.split(".")[2].to_i <= 53
                puts "\n#{server} looks vulnerable, check\n".yellow[..-5]
                puts "https://www.cvedetails.com/vulnerability-list/vendor_id-45/product_id-66/Apache-Http-Server.html\n\n"
            elsif bruh.include?("nginx") && bruh.match("/(.*)")[1].to_s <= "1.20.0"       
                puts "\n#{server} looks vulnerable, check\n".yellow[..-5]
                puts "http://nginx.org/en/security_advisories.html\n\n"
            else
                puts "\n#{server} doesn't seem vulnerable\n".yellow
            end
        rescue NoMethodError 
            puts "\n#{server} doesn't seem vulnerable\n".yellow
        end
    end
end
while true
    print "\rArb>".green[..-5]
    input = gets.chomp
    break if input == "exit"
    exec = Commands.new()
    if input == "headers"
        print "\rUrl: "
        sessoinput = gets.chomp
        exec.headers(sessoinput)
    elsif input == "lookup"
        puts "\rRemember to select a valid target! (example www.twitter.com or 104.244.42.1)".red
        print "\rAddress: ".green
        url_target = gets.chomp
        Thread.new{
            exec.lookup(url_target) do |output|
                print output
                puts "\n"
            end
        }.join
    elsif input == "body"
        print "\rUrl: "
        pazzo = gets.chomp
        exec.body(pazzo)
    elsif input == "linkshunt"
        print "\rUrl: "
        url = gets.chomp
        exec.linkshunt(url)
    elsif input == "portscan"
        puts "(example: www.google.com)"
        print "\rAddress: "
        scan_target = gets.chomp
        exec.portscanner(scan_target)
    elsif input == "xml-parser"
        print "\rUrl: "
        xmlml = gets.chomp
        exec.xml_parser(xmlml)
    elsif input == "fuzzer"
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
            Thread.new{
                exec.fuzzer(fuzz_target, "wordlist.txt")
            }.join
        else 
            exec.fuzzer(fuzz_target, wordlist_option)
        end 
    elsif input == "ssl"
        puts "\rExample: google.com"
        print "\rAddress: "
        ssl_target = gets.chomp
        exec.sexssl?(ssl_target)
    elsif input == "svrscan"
        print "\rUrl: "
        begin
            exec.svrscan(gets.chomp)
        rescue Errno::ECONNREFUSED, SocketError => bruh 
            puts "\nInvalid Target! #{bruh}\n".red
        end
    elsif input == "-r"
        system("clear||cls")
        puts "Clean".cyan
        puts "\n"
    elsif input == "help"
        print help
    elsif input == "banner"
        print logo
    else 
       system(input)
    end
end
