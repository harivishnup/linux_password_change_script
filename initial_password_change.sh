#!/usr/bin/expect
# Initial password or expired password change script
# Version 0.01
# Date: 2016/Dec/23
# https://github.com/harivishnup/linux_password_change_script
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
    spawn ssh -t -o StrictHostKeychecking=no "$user\@$ip" "hostname"
    expect "password:" {send "$old_pass\r"}
    expect "(current) UNIX password:" {send "$old_pass\r"}
    expect "New password:" {send "$new_pass\r"}
    expect "Retype new password:" {send "$new_pass\r"}
    interact
}