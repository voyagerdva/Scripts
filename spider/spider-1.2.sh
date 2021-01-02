#!/usr/bin/expect -f

set passwords {$pass1 $pass2}
set user1 root
set user2 ipchang3r
set file_address [open "./address_list.txt" r]
set COUNT 1

foreach aline [split [read $file_address] "\n"] {
set server [lindex $aline 0]
set address [lindex $aline 1]
log_user 1
set outfile [open ./outfile.txt a]
puts $outfile " Server: $server - $address"

if { [string length $address] > 0 } {
puts "     ----------  round $COUNT  ----------"
puts "Connect to server - $server - $address"
set file_commands [open "./command_list.txt" r]

foreach command_line [split [read $file_commands] "\n"] {
set command $command_line

if { [string length $command] > 0 } {
puts $command_line

spawn ssh -o "StrictHostKeyChecking=no" $user1@$address "$command"
set idx 0
expect {
"*assword*" {send "[lindex $passwords $idx]\r"
incr idx
exp_continue;
}
}

puts $outfile $expect_out(buffer)
sleep 1
}
}
}

puts "     ----------  End of round $COUNT  ----------"

incr COUNT

puts "    ----------------------------  "
#puts " "
#puts " " #
}