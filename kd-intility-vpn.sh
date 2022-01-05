#!/usr/bin/expect

proc slurp {file} {
    set fh [open $file r]
    set ret [read $fh]
    close $fh
    return $ret
}

set pw [slurp /home/kiro/kd/vpn.secret]

# prints the pw / for debug
puts -nonewline $pw 

#spawn openconnect --csd-user=nobody --csd-wrapper=/usr/lib/openconnect/csd-post.sh vpn.intility.no
spawn /opt/cisco/anyconnect/bin/vpn connect vpn.intility.no

expect "Username:"
send "magnus.kiro@klavenessdigital.com\n"
expect "Password:"
send "$pw\n"
expect "Answer: "

interact
