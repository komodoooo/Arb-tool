#!usr/bin/env ruby
require 'net/http'
require 'mechanize'
require 'open-uri'
require 'socket'
require 'colorize'


def help
    puts """\r
ARB commands:
headers      => returns the headers of a site
lookup       => parse an user target (ip/domain)
fingerprint  => capture the html code of a site
linkshunt    => view the correlated links in a site
portscan     => check the open port on a target (ip/domain)
xml-version  => show the xml version of a site
fuzzer       => do the directory fuzzing in a site
-r           => reset & clear display
help         => help you :kek:\r""".cyan
end

def logo
    banner = '''
                  ___
 ▄▀█ █▀█ █▄▄     / | \
 █▀█ █▀▄ █▄█    |--0--|
                 \_|_/        By LoJacopS
'''.cyan[..-5]
    print banner
    puts "v1.7.5"
    puts "\n"
    print Time.now
    puts "\n"
end

=begin

Komodo, 5/02/2022

Hi reader of this code, i'm sorry for eventually
shitty codes in arb. It was my first ruby project in 2020...
Right now, I update it in randomly moments

=end

print logo
puts "Welcome to arb!"

prompt = "\rArb>".green[..-5]

while (input = gets.chomp)
break if input == "exit"
    print prompt && input
    if input == "headers"
        Thread.new{
            begin
                puts "\rTarget:"
                sessoinput = gets.chomp
                urii = URI("#{sessoinput}")
                response = Net::HTTP.get_response(urii) 
                response.to_hash['set-cookie']                      #get the sexy headers
                puts "Headers:\n #{response.to_hash.inspect}".yellow
            rescue Errno::ENOENT, Errno::ECONNREFUSED
                puts "\rselect a valid target! (example https://pornhub.com)".red
            end
        }.join
    end
    if input == "lookup"
        class Spidercute
            def target
                puts "\rRemember to select a valid target! (example www.twitter.com)".red
                puts "\rSelect a valid target:".green
                url_target = gets.chomp
                begin   
                    urrah = URI("https://ipwhois.app/json/#{url_target}")
                    mlml = Net::HTTP.get(urrah)
                    puts "\n"
                    puts mlml.gsub(",", ",\n").yellow
                rescue Errno::ENOENT, Errno::ECONNREFUSED
                    puts "\rselect a valid target! (example www.twitter.com)".red
                end
            end
        end
        Thread.new{
            crawling = Spidercute.new
            crawling.target do |output|
                print output
                puts "\n"
            end
        }.join
    end
    if input == "fingerprint"
        begin
            puts "\rinsert a site target:"
            html_code = gets.chomp
            puts "\rhere the html code\n"
            capture = open(html_code)
            work = Nokogiri::HTML(capture)  #sorry for the variables, but to make it work, just the function is not enough
            print "#{work}".yellow
        rescue Errno::ENOENT, Errno::ECONNREFUSED
            puts "\rselect a valid target! (example https://pornhub.com)".red
        end
    end
    if input == "linkshunt"
        def owo
            Thread.new{
                begin
                    amogus = Mechanize.new
                    puts "\rinsert a link:"
                    url = gets.chomp
                    puts "\rtarget selected: #{url}"
                    amogus.get(url).links.each do |link|
                        puts "correlated links at #{url} = #{link.uri}".yellow
                    end
                rescue => eeeeh
                    puts "ERROR\n#{eeeeh}".red
                    puts ""
                end
            }.join
        end
        print owo
    end
    if input == "portscan"
        puts "\rtype an ip to check the ports open on:"
        puts "(example: www.google.com)"
        def scan_port
            port_input = gets.chomp
            ports = [15,21,22,23,25,26,50,51,53,67,58,69,80,110,119,123,
                    135,139,143,161,162,200,389,443,587,989,990,
                    993,995,1000,2077,2078,2082,2083,2086,      #most used ports
                    2087,2095,2096,3080,3306,3389
                ]      
            #ports = Range.new(1,5000)      Ranges? Nah.
            begin
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
                        puts "\rPort #{numbers} is open".yellow
                    else
                        puts "\rPort #{numbers} is closed".red
                    end
                end
            rescue SocketError => sock_err
                puts "ERROR\n#{sock_err}".red
                puts ""
            end
        end
        print scan_port
    end
    if input == "xml-version"
        def xml_v(version)
            begin
                e = open(version)
                puts "\rHere the xml version:"
                print "#{Nokogiri::XML(e)}".yellow
            rescue Errno::ENOENT, Errno::ECONNREFUSED
                puts "\rselect a valid target! (example https://google.com)".red
            rescue => eeh
                puts "ERROR:\n#{eeh}".red
                puts ""
            end
        end
        puts "\nsite with xml:"
        versionn = gets.chomp
        print xml_v(versionn)
    end
    if input == "fuzzer"
        def fuzzer(link, wordlist)
            begin
                Thread.new{
                    wordlist = File.open(wordlist)
                    ohyes = wordlist.map {|x| x.chomp }
                    ohyes.each do |dir|
                        uriiii = URI("#{link}/#{dir}/")
                        requestt = Net::HTTP.get_response(uriiii)
                        if requestt.code == '200'
                            puts "\rdirectory open! '#{dir}'".yellow
                            log = File.new("Valid-dir.log", 'a')
                            log.write(dir+"\n")
                            log.close
                            puts "saved on file Valid-dir.log!"
                        else
                            puts "\nscanning...#{requestt.code}".cyan                    #directory closed
                        end
                    end
                }.join
            rescue Errno::ENOENT, Errno::ECONNREFUSED
                puts "\rERROR: Select a valid wordlist".red
            rescue Net::OpenTimeout
                puts "\rERROR: Select a valid link".red
            rescue => eeeh
                puts "ERROR\n#{eeeh}".red
                puts ""
            end
        end
        puts "\rlink: "
        fuzz_option = gets.chomp
        puts "\rselect a wordlist: (wordlist.txt for use the default wordlist)"
        wordlist_option = gets.chomp
        print fuzzer(fuzz_option, wordlist_option)
    end
    if input == "-r"
        system('clear')
        puts "Resetted!".cyan
        puts "\n"
    end
    if input == "help"
        print help
    elsif input == "banner"
        print logo
        commands = ['headers', 'lookup', '-r', 'help', 'linkshunt','fingerprint','portscan',"fuzzer"]
    else input != commands
        puts "\r"
    end
system(input)
print prompt
end
