#!/usr/bin/expect
# Password change script
# Version 0.01
# Date: 2017/Jan/07
# https://github.com/harivishnup/linux_password_change_script2
##############################################################
# List all servers in servers.txt as follows (without comment)
# server1
# server2
# server3

# set username and passwords below within quotes
set user "tester"
set old_pass "tester"
set new_pass "TheMostSecureNewPassword!"

# Do not edit below
##############################################################
set timeout 10
set f [open "servers.txt"]
set ips [split [read $f] "\n"]
close $f

foreach ip $ips {
    spawn ssh -t -o StrictHostKeychecking=no "$user\@$ip" "passwd"
    expect "password:" {send "$old_pass\r"}
    expect "(current) UNIX password:" {send "$old_pass\r"}
    expect "New password:" {send "$new_pass\r"}
    expect "Retype new password:" {send "$new_pass\r"}
    interact
}