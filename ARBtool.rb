#!usr/bin/env ruby
require 'http'
require 'sniffer'
require 'mechanize'
require 'open-uri'
require 'socket'

def help
    puts "\rARB Sitescreener commands:"
    puts "local        => analyze a localhost's site"
    puts "dns          => parse an user target (website)"
    puts "fingerprint  => capture the html code of a site" 
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
puts "DISCLAIMER: if the localhost is no detectable, arb give you an error."
prompt = "\rArb>"

while (input = gets.chomp)
break if input == "exit"
    print prompt && input
    if input == "local"
        puts "\rSelect a port: (default 80)"
        def local
            begin
                port = 80
                localport = gets.chomp
                print localport
                if localport == true
                port = localport
                end
                puts "\rHere the local informations:\n"
                lel = Nokogiri::HTML(open("127.0.0.1:#{port}"))
                print lel
                Sniffer.enable!
                HTTP.get("http://127.0.0.1:#{port}")
                Sniffer.data[0].to_h
                inlines = lel.xpath('//script[not(@src)]')
                inlines.each do |sus|
                    puts "-"*50, sus.text
                end
                raise 'Something Wrong, retry.'
            rescue Errno::ENOENT
                puts "enable to get the localhost"
                return false
            end
        end
        print local
    end
    if input == "dns"
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
                    Sniffer.enable!
                    HTTP.get(url_target)
                    Sniffer.data[0].to_h
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
        def scan_port
            port_input = gets.chomp
            print port_input
            ports = [15,21,22,25,26,80,110,143,200,443,587,993,995,1000,
                    2077,2078,2082,2083,2086,2087,2095,2096,3080,3306       #most used ports
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
                    puts "Port #{numbers} is open"                                          
                else  
                    puts "Port #{numbers} is closed"
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
                wordlist = ["access", "accessgranted", "accessibility", "accessories", "account", "about", "aboutUs", "admin", "administration", "archive", "articles", "backOffice",
                    "blog", "books", "business", "CPAN", "CVS", "CYBERDOCS", "CYBERDOCS25", "CYBERDOCS31", 
                    "ChangeLog", "domputers", "dontact", "dontactUs", "dontent", "dreatives", "default", "download", "Downloads", "downloads", "Education", 
                    "English", "Entertainment", "Events", "Extranet", "FAQ", "Games", "Global", "Graphics", 
                    "HTML", "Health", "Help", "Home", "INSTALL_admin", "Image", "image", 
                    "Images", "images", "Index", "index", "Internet", "internet", "Java", "Legal", "Links", "links", 
                    "Linux", "Log", "log", "Login", "login", "Logs", "logs", "MANIFEST.MF", "META-INF", "Main", "main", "Main_Page", "Media", "media", 
                    "Members", "Menus", "Misc", "Music", "News", "OasDefault", "Office", "PHP", "PDF", "Pages", 
                    "pages", "People", "Press", "Privacy", "Products", "Projects", 
                    "Publications", "RCS", "README", "RSS", "RealMedia", "Research", "Resources", "Scripts", "scripts", "Search", "Security", "Services", 
                    "Servlet", "Servlets", "SiteMap", "SiteServer", "Sites", "sites", "Software", "Sources", 
                    "Sports", "Statistics", "Stats", "Support", "Technology", "Themes", "Travel", "US", "Utilities", "Video", "video", "W3SVC", "W3SVC1", 
                    "W3SVC2", "W3SVC3", "WEB-INF", "Windows", "XML", "_admin", "_images", 
                    "_mem_bin", "_pages", "_vti_aut", "_vti_bin", "_vti_cnf", "_vti_log", "_vti_pvt", "_vti_rpc", "abc", "about", "about-us", "about_us", 
                    "aboutus", "abstract", "academic", "academics", "accountants", "accounting", 
                    "accounts", "achitecture", "action", "actions", "active", "activities", "ad", "adclick", "add", "adlog", "adm", "admin", "admin_",
                    "admin_login", "admin_logon", "adminhelp", "administrat", "administration", 
                    "administrator", "adminlogin", "adminlogon", "adminsql", "admissions", "admon", "ads", "adsl", "adv", "advanced", "advanced_search", 
                    "advertise", "advertisement", "advertising", "adview", "~adm", "~admin", "~administrator", 
                    "~bin", "~ftp", "~guest", "~mail", "~operator", "~root", "~sys", "~sysadm", "~sysadmin", "~test", "~user", "~webmaster", "~www"
                ]
                wordlist.each do |dir|
                    uri = "#{fuzz_option}/#{dir}/"
                    request = HTTP.get(uri)
                    print request.code
                    if request.code == 200
                        puts "\rdirectory open! '#{dir}'"
                    elsif request.code == 404
                        puts "\nscanning..."                       #directory closed
                    end
                end
            rescue HTTP::Request::UnsupportedSchemeError
                puts "\rselect a valid target! (example https://pain.net)"    
            end
        end
        print fuzzer
    end
    if input == "-r"
        Sniffer.reset!
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
