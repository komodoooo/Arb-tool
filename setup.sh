#!usr/bin/bash
echo "Sometimes some gems are not available for download"
chmod +x ARBtool.rb
gem install 'http'
gem install 'sniffer'
ruby ARBtool.rb
