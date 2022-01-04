

#Phy/WirelessPhy set bandwidth_ 1000000        ;#Data Rate
#initialize the variables
set val(chan)           Channel/WirelessChannel    ;#Channel Type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model

set val(netif)          Phy/WirelessPhy            ;# network interface type #WAVELAN DSSS 2.4GHz

set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type


set val(ifqlen)         5                         ;# max packet in ifq
set val(nn)             3                          ;# number of mobilenodes

set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model

set val(rp)             AODV                       ;# routing protocol
set val(x)  1000   ;# in metres
set val(y)  1000   ;# in metres

#Adhoc OnDemand Distance Vector

#creation of Simulator
set ns [new Simulator]

$ns color 0 red


set tracefile [open AODV.tr w]
$ns trace-all $tracefile 
set namfile [open AODV.nam w]
$ns namtrace-all-wireless $namfile $val(x) $val(y)


#create topography
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

#GOD Creation - General Operations Director
create-god $val(nn)

set channel1 [new $val(chan)]


#configure the node
$ns node-config -adhocRouting $val(rp) \
  -llType $val(ll) \
  -macType $val(mac) \
  -ifqType $val(ifq) \
  -ifqLen $val(ifqlen) \
  -antType $val(ant) \
  -propType $val(prop) \
  -phyType $val(netif) \
  -topoInstance $topo \
  -agentTrace ON \
  -macTrace ON \
  -routerTrace ON \
  -movementTrace ON \
  -channel $channel1 

set node0 [$ns node]
set node1 [$ns node]
set node2 [$ns node]





$node0 random-motion 0
$node1 random-motion 0
$node2 random-motion 0




$ns initial_node_pos $node0 60
$ns initial_node_pos $node1 60
$ns initial_node_pos $node2 60







$node0 radius 50.0
$node1 radius 50.0
$node2 radius 50.0







$node0 set X_ 100
$node0 set Y_ 100
$node0 set Z_ 0.0
$ns at 1.0 "$node0 setdest 100.0 100.0 0.0"
$node1 set X_ 150
$node1 set Y_ 100
$node1 set Z_ 0.0
$ns at 1.0 "$node1 setdest 150.0 100.0 0.0"

$node2 set X_ 200
$node2 set Y_ 100
$node2 set Z_ 0.0
$ns at 1.0 "$node2 setdest 200.0 100.0 0.0"

# $ns at 1.0 "$n) setdest 10.0 999.0 40.0"
# $ns at 1.0 "$n_(19) setdest 100.0 900.0 40.0"


# $ns at 1.0 "$n_(1) setdest 400.0 500.0 40.0"
# $ns at 20.0 "$n_(1) setdest 10.0 600.0 40.0"

# $ns at 19.0 "$n_(0) setdest 500.0 609.0 40.0"
# $ns at 19.0 "$n_(19) setdest 100.0 100.0 40.0"

puts "in another"


#creation of agents
set tcp [new Agent/UDP]  
$tcp set fid_ 0
set sink [new Agent/LossMonitor]
$ns attach-agent $node0 $tcp
$ns attach-agent $node2 $sink
$ns connect $tcp $sink
set ftp [new Application/Traffic/CBR]
$ftp set packetSize_ 1000
#$ftp set interval_ 0.001
$ftp attach-agent $tcp
$ns at 1.0 "$ftp start"

$ns at 0.0 "$node0 label node0"
$ns at 0.0 "$node2 label node1"
$ns at 2.0 "finish"

proc finish {} {
 global ns namfile tracefile
 $ns flush-trace
 close $tracefile
 close $namfile

 exec nam AODV.nam &

 exit 0
}








puts "Starting Simulation"
$ns run




#for { set x 5} { $x <6} { incr x } {
#input_Protocol_pramerters 20 $x 2.0 $x
#}


