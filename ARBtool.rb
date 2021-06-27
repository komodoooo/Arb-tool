#!usr/bin/env ruby

require 'http'
require 'sniffer'


def help
    puts "\rARB Sitescreener commands:"
    puts "local   => sniff the local traffic"
    puts "dns     => sniff a user target"
    puts "-r      => reset & clear display"
    puts "help    => help you :kek:"
end

puts "Welcome to arb! The site analyzer!"
puts "DISCLAIMER: if the localhost is no detectable, arb give you an error."
prompt = "Arb>"
while (input = gets.chomp)
break if input == "exit"
    print prompt && input
    if input == "local"
        def local
            Sniffer.enable!
            HTTP.get('http://localhost')
            Sniffer.data[0].to_h
            raise 'Something Wrong, retry.'
        end
        print local
    end
    if input == "dns"
        puts "\rSelect a valid target:"
        def target
            input_target = gets.chomp
            puts input_target
            Sniffer.enable!
            HTTP.get(input_target)
            Sniffer.data[0].to_h
        end
        target.each do |output|
            print output
            puts "\n"
        end
    end
    if input == "-r"
            Sniffer.reset!
            system("clear")
            print "Resetted!"
            puts "\n"
    else
        print "" 
    end
    if input == "help"
        print help
    end

system(input)
print prompt
end
