#!usr/bin/bash
echo "Sometimes some gems are not available for download"
apt-get install ruby
apt-get install rubygems
gem install http
gem install sniffer
gem install mechanize
gem install open-uri
gem install rex-sslscan
chmod +x ARBtool.rb
ruby ARBtool.rb
