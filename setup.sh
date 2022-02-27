#!usr/bin/bash
echo "Sometimes some gems are not compatible with the system."
echo "start this file as root"
echo """
                    ___
 ▄▀█ █▀█ █▄▄       / | \   
 █▀█ █▀▄ █▄█ tool |--0--|   
                   \_|_/ Setup
"""
function main {
    {
        gem install bundle
        bundle install
        chmod +x ARBtool.rb
        ruby ARBtool.rb
    } || {
        FAIL="""
ERROR :/
Something wrong uhm...

\nCommon problems:
\nAre you root?
\nHave you installed ruby and rubygems?
\nIs this script running on the same path of the repo?
"""
        echo -e $FAIL
    }
}
main
