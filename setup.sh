#!/bin/bash

function dperr {
    apt install ruby-bundler 2>/dev/null
    pacman -S ruby-bundler 2>/dev/null
    main;
}
function main {
    trap dperr ERR
    gem install bundle 
    cd config
    bundle install
}
main;
cd ..
chmod +x+w arb.rb && cp arb.rb /bin/arb
echo "arb.rb has been moved to /bin and can now be used as a system command."
