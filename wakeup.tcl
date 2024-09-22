### Script extended upon an initial prototype authored by Jónatan Þór Jónasson

if {$argc != 3} {
       puts "Please ensure that all variables are included"
       puts "Syntax:"
       puts "tftp://<ip_address>/WakeUp.tcl Broadcast_Address Target_MacAddr VRF_Name"
   } else {
       set broadcastAddr [lindex $argv 0]
       set macAddr [lindex $argv 1]
       set vrfTable [lindex $argv 2]
       puts "\n\n======== Wake on Lan Script ========\n\n"
       puts "Selected Broadcast Address: $broadcastAddr"
       puts "Selected Mac Address: $macAddr"
       puts "Selected VRF Table: $vrfTable"
   }

proc WakeOnLan {broadcastAddr macAddr vrfTable} {
     set net [binary format H* [join [split $macAddr -:] ""]]
     set pkt [binary format c* {0xff 0xff 0xff 0xff 0xff 0xff}]

     for {set i 0} {$i < 16} {incr i} {
        append pkt $net
     }

     # Open UDP and Send the Magic Paket.
     set udpSock [udp_open]
     fconfigure $udpSock -translation binary \
          -broadcast 1 \
          -remote [list $broadcastAddr 4580] \
          -vrf $vrfTable
     puts $udpSock $pkt
     flush $udpSock;
     close $udpSock
}
set i 0
while {$i < 10} {
    incr i
    WakeOnLan $broadcastAddr $macAddr $vrfTable
    puts  -nonewline "!"
}
