#!/bin/bash
function main {
    gem install bundle 
    cd config
    bundle install
}
main;
cd ..
chmod +x arb.rb && cp arb.rb /bin/arb
echo "arb.rb has been moved to /bin and can now be used as a system command."
