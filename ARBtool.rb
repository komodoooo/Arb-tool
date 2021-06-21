#!usr/bin/env ruby

require 'http'
require 'sniffer'


def help
    puts " ARB Sitescreener commands:"
    puts "-local   => sniff the local traffic"
    puts "-dns     => sniff a user target"
    puts "-R       => reset"
    puts "help     => help :kek:"
end
puts "Welcome to arb! The site analyzer!"
puts "DISCLAIMER: if the localhost is no detectable, arb give you an error."
prompt = "Arb>_"
while (input = gets.chomp)
break if input == "exit"
    print prompt && input
    if input == "-local"
        def local
            Sniffer.enable!
            HTTP.get('http://localhost')
            Sniffer.data[0].to_h
            raise 'Something Wrong, retry.'
        end
        print local
    end
    if input == "-dns"
        puts "Select a valid target:"
        def target
            input_target = gets.chomp
            puts input_target
            Sniffer.enable!
            HTTP.get(input_target)
            Sniffer.data[0].to_h
        end
        print target
    end
    if input == "-R"
        Sniffer.reset!
        print "Resetted"
    else
        print "" 
    end
    if input == "help"
        print help
    end
system(input)
print prompt
end
