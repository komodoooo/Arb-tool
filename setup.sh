#!/bin/bash
function main {
    {
        gem install bundle 
        cd config
        bundle install || apt install ruby-bundler && bundle install
        cp LICENSE ../LICENSE       #how stupid i am...
        echo "A license copy was generated from $(pwd)" 
        cd ..
        ruby arb.rb
    } || {
        FAIL="""
ERROR :/
\nCommon problems:
\nAre you root?
\nHave you installed ruby and rubygems?
\nIs this script running on the same path of the repo?
"""
        clear
        echo -e $FAIL
    }

}
main;
