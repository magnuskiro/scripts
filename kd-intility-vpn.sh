#!/usr/bin/expect

####
#   depends on 'expect', `apt install expect`
####

set user "magnus.kiro@klavenessdigital.com"

proc slurp {file} {
    set fh [open $file r]
    set ret [read $fh]
    close $fh
    return $ret
}

# before use ensure that this file contains your AD-pw
set pw [slurp $env(HOME)/kd/vpn.secret]

# prints the pw / for debug
#puts -nonewline $pw 

#spawn openconnect --csd-user=nobody --csd-wrapper=/usr/lib/openconnect/csd-post.sh vpn.intility.no
spawn /opt/cisco/anyconnect/bin/vpn connect vpn.intility.no

expect "Username:"
send "$user\n"
expect "Password:"
send "$pw\n"
expect "Answer: "

interact
