#!usr/bin/env ruby
require 'http'
require 'sniffer'
require 'nokogiri'
require 'open-uri'

def help
    puts "\rARB Sitescreener commands:"
    puts "local   => parse the localhost"
    puts "dns     => parse an user target"
    puts "-r      => reset & clear display"
    puts "help    => help you :kek:"
end

def logo
    banner = '''
                  ___
 ▄▀█ █▀█ █▄▄     / | \   
 █▀█ █▀▄ █▄█    |--0--|   
                 \_|_/        By LoJacopS
'''
    print banner
    puts "v1.4.2"
    puts "\n"
    print Time.now
    puts "\n"
end

print logo
puts "Welcome to arb! The site analyzer!"
puts "DISCLAIMER: if the localhost is no detectable, arb give you an error."
prompt = "\rArb>"

while (input = gets.chomp)
break if input == "exit"
    print prompt && input
    if input == "local"
        puts "\rSelect a port: (default 80)"
        def local
            port = 80
            localport = gets.chomp
            print localport
            if localport == true
                port = localport
            end
            puts "\rHere the local informations:\n"
            Sniffer.enable!
            lel = Nokogiri::HTML(open("127.0.0.1:#{port}"))
            inlines = lel.xpath('//script[not(@src)]')
            inlines.each do |sus|
                puts "-"*50, sus.text
            end
            HTTP.get("http://127.0.0.1:#{port}")
            Sniffer.data[0].to_h
            Nokogiri::XML(open("127.0.0.1:#{port}"))
            raise 'Something Wrong, retry.'
        end
        print local
    end
    if input == "dns"
        puts "\rSelect a valid target:"
        class Spidercute
            def target
                url_target = gets.chomp
                puts url_target
                if url_target == nil
                    puts "Not a valid target"
                    return
                end
                body = Nokogiri::HTML(open(url_target))
                puts "\rHere html code:\n"
                print body
                puts "\rHere the site informations:\n"
                Sniffer.enable!
                HTTP.get(url_target)
                Sniffer.data[0].to_h
                inline = body.xpath('//script[not(@src)]')
                inline.each do |script|
                    puts "-"*50, script.text
                end
                uwu = Nokogiri::XML(open(url_target))
                print uwu
            end
        end
        crawling = Spidercute.new
        crawling.target do |output|
            print output
            puts "\n"
        end
    end
    if input == "-r"
        Sniffer.reset!
        system('clear')
        print "Resetted!"
        puts "\n"
    else
        print "" 
    end
    if input == "help"
        print help
        commands = ['local', 'dns', '-r', 'help']
    else input != commands
        puts "\rArb: Command not found."
    end

system(input)
print prompt
end
