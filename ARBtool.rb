#!usr/bin/env ruby
require 'http'
require 'net/http'
require 'mechanize'
require 'open-uri'
require 'socket'

def help
    puts "\rARB Sitescreener commands:"
    puts "headers      => returns the headers of a site"
    puts "site         => parse an user target (website)"
    puts "fingerprint  => capture the html body of a site"
    puts "linkshunt    => view the correlated links in a site"
    puts "portchecker  => check the open port on a target ip"
    puts "xml-version  => show the xml version of a site"
    puts "fuzzer       => do the directory fuzzing in a site"
    puts "-r           => reset & clear display"
    puts "help         => help you :kek:\r"
end

def logo
    banner = '''
                  ___
 ▄▀█ █▀█ █▄▄     / | \
 █▀█ █▀▄ █▄█    |--0--|
                 \_|_/        By LoJacopS
'''
    print banner
    puts "v1.6.8"
    puts "\n"
    print Time.now
    puts "\n"
end
print logo

puts "Welcome to arb! The site analyzer!"

prompt = "\rArb>"

while (input = gets.chomp)
break if input == "exit"
    print prompt && input
    if input == "headers"
        begin
            puts "\rTarget:"
            sessoinput = gets.chomp
            urii = URI("#{sessoinput}")
            response = Net::HTTP.get_response(urii)
            response['Set-Cookie']                      #get the sexy headers
            response.get_fields('set-cookie') 
            response.to_hash['set-cookie']    
            puts "Headers:\n #{response.to_hash.inspect}"
        rescue Errno::ENOENT
            puts "\rselect a valid target! (example https://pornhub.com)"
        end
    end
    if input == "site"
        puts "\rSelect a valid target:"
        class Spidercute
            def target
                begin
                    url_target = gets.chomp
                    puts url_target
                    if url_target == nil
                        puts "Not a valid target"
                        return
                    end
                    body = Nokogiri::HTML(open(url_target))
                    puts "\rHere the site informations:\n"
                    urll = URI("#{url_target}")
                    respone = Net::HTTP.get_response(urll)
                    respone['Set-Cookie']            
                    respone.get_fields('set-cookie') 
                    respone.to_hash['set-cookie']    
                    print respone.to_hash.inspect

                    inline = body.xpath('//script[not(@src)]')
                    inline.each do |script|
                        puts "-"*50, script.text
                    end
                rescue Errno::ENOENT
                    puts "\rselect a valid target! (example https://pornhub.com)"
                end
            end
        end
        crawling = Spidercute.new
        crawling.target do |output|
            print output
            puts "\n"
        end
    end
    if input == "fingerprint"
        puts "\rinsert a site target:"
        html_code = gets.chomp
        print html_code
        puts "\rhere the html code\n"
        capture = open(html_code)
        work = Nokogiri::HTML(capture)  #sorry for the variables, but to make it work, just the function is not enough
        print work
    end
    if input == "linkshunt"
        def owo
            amogus = Mechanize.new
            puts "\rinsert a link:"
            url = gets.chomp
            print url
            puts "\rtarget selected: #{url}"
            amogus.get(url).links.each do |link|
                puts "correlated links at #{url} = #{link.uri}"
            end
        end
        print owo
    end
    if input == "portchecker"
        puts "\rtype an ip to check the ports open on:"
        puts "(example: www.google.com)"
        def scan_port
            port_input = gets.chomp
            print port_input
            ports = [15,21,22,25,26,80,110,143,200,443,587,
                    993,995,1000,2077,2078,2082,2083,2086,      #most used ports
                    2087,2095,2096,3080,3306
                ]
            for numbers in ports
                socket = Socket.new(:INET, :STREAM)
                remote_addr = Socket.sockaddr_in(numbers, port_input)
                begin
                    socket.connect_nonblock(remote_addr)
                rescue Errno::EINPROGRESS
                end
                time = 1
                sockets = Socket.select(nil, [socket], nil, time)
                if sockets
                    puts "\rPort #{numbers} is open"
                else
                    puts "\rPort #{numbers} is closed"
                end
            end
        end
        print scan_port
    end
    if input == "xml-version"
        def xml_v
            begin
                puts "\nsite with xml:"
                version = gets.chomp
                print version
                e = open(version)
                puts "\rHere the xml version:"
                Nokogiri::XML(e)
            rescue Errno::ENOENT
                puts "\rselect a valid target! (example https://google.com)"
            end
        end
        print xml_v
    end
    if input == "fuzzer"
        def fuzzer
            begin
                puts "\rlink: "
                fuzz_option = gets.chomp
                print fuzz_option
                puts "\rselect a wordlist:"
                wordlist_option = gets.chomp
                print wordlist_option
                wordlist = File.open(wordlist_option)
                ohyes = wordlist.map {|x| x.chomp }
                ohyes.each do |dir|
                    uri = "#{fuzz_option}/#{dir}/"
                    request = HTTP.get(uri)
                    print request.code
                    if request.code == 200
                        puts "\rdirectory open! '#{dir}'"
                        log = File.new("Valid-dir.log", 'a')
                        log.write(dir+"\n")
                        log.close
                        puts "saved on file Valid-dir.log!"
                    elsif request.code == 404
                        puts "\nscanning..."                       #directory closed
                    end
                end
            rescue Errno::ENOENT
                puts "\rERROR: Select a valid wordlist"
            rescue HTTP::ConnectionError
                puts "\rERROR: Select a valid link"
            end
        end
        print fuzzer
    end
    if input == "-r"
        system('clear')
        puts "Resetted!"
        puts "\n"
    end
    if input == "help"
        print help
    elsif input == "banner"
        print logo
        commands = ['local', 'dns', '-r', 'help', 'linkshunt','fingerprint','portchecker',"fuzzer"]
    else input != commands
        puts "\r"
    end
system(input)
print prompt
end
