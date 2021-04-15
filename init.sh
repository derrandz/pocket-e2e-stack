#!/usr/bin/expect

set ppkfilepath $argv; # Grab the first command line parameter
set timeout -1

spawn sh -c cp /tmp/*.json /home/app/.pocket/config/
spawn sh -c echo $ppkfilepath
spawn pocket accounts import-armored $ppkfilepath
sleep 2
send -- "$env(POCKET_CORE_PASSPHRASE)\n"
send -- "$env(POCKET_CORE_PASSPHRASE)\n"
expect eof
spawn sh -c "echo \"done with import armored\"";

spawn sh -c "pocket accounts set-validator `pocket accounts list | cut -d' ' -f2- `"
sleep 5
send -- "$env(POCKET_CORE_PASSPHRASE)\n"
expect eof
spawn sh -c "echo \"done with set-validator\""
spawn sh -c pocket start --keybase=false --mainnet --datadir=/home/app/.pocket/