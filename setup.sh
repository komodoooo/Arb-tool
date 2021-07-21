#!usr/bin/bash
echo "Sometimes some gems are not available for download"
gem install http
gem install sniffer
gem install nokogiri
gem install open-url
chmod +x ARBtool.rb
ruby ARBtool.rb
