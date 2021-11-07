#!usr/bin/bash
echo "Sometimes some gems are not compatible with the system."
echo "start this file as root"
echo """
                    ___
 ▄▀█ █▀█ █▄▄       / | \   
 █▀█ █▀▄ █▄█ tool |--0--|   
                   \_|_/ Setup
"""
gem install bundle
bundle install
chmod +x ARBtool.rb
ruby ARBtool.rb
