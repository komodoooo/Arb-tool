#!usr/bin/bash
echo "Sometimes some gems are not available for download"
gem install bundle
bundle install
chmod +x ARBtool.rb
ruby ARBtool.rb
