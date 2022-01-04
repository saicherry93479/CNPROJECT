

#Phy/WirelessPhy set bandwidth_ 1000000        ;#Data Rate
#initialize the variables
set val(chan)           Channel/WirelessChannel    ;#Channel Type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model

set val(netif)          Phy/WirelessPhy            ;# network interface type #WAVELAN DSSS 2.4GHz

set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type


set val(ifqlen)         5                         ;# max packet in ifq
set val(nn)             50                          ;# number of mobilenodes

set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model

set val(rp)             DSDV                       ;# routing protocol
set val(x)  1000   ;# in metres
set val(y)  1000   ;# in metres

#Adhoc OnDemand Distance Vector

#creation of Simulator
set ns [new Simulator]

$ns color 0 red


set bandwidth [ open pojectSampleDSDVBF.xg w]

set throughput [ open pojectSampleDSDVTF.xg w]

#creation of Trace and namfile 
set tracefile [open projectSampleDSDVF.tr w]
$ns trace-all $tracefile

#Creation of Network Animation file
set namfile [open projectSampleDSDVF.nam w]
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


for { set x 0} { $x < 50} { incr x } {
set n_($x) [$ns node]
}


#set n0 [$ns node]
#set n1 [$ns node]
#set n2 [$ns node]

for { set x 0} { $x < 50} { incr x } {
$n_($x) random-motion 0
}


#$n0 random-motion 0
#$n1 random-motion 0
#$n2 random-motion 0

for { set x 0} { $x <50} { incr x } {
$ns initial_node_pos $n_($x) 50
}



#$ns initial_node_pos $n0 20
#$ns initial_node_pos $n1 20
#$ns initial_node_pos $n2  20

#initial coordinates of the nodes 


#$n0 set X_ 0.0
#$n0 set Y_ 0.0
#$n0 set Z_ 0.0



#$ns at 1.0 "$n0 start"
#$ns at 1.0 "$n1 start"
#$ns at 1.0 "$n2 start"

for { set x 0} { $x <50} { incr x } {


$n_($x) radius 50.0


}


#$n0 radius 500.0
#$n1 radius 50.0
#$n2 radius 500.0


#Dont mention any values above than 500 because in this example, we use X and Y as 500,500

#mobility of the nodes
#At what Time? Which node? Where to? at What Speed?

#$ns at 1.0 "$n2 setdest 350.0 400.0 100.0"

$n_(0) set X_ 10
$n_(0) set Y_ 10
$n_(0) set Z_ 0.0

$n_(49) set X_ 990
$n_(49) set Y_ 800
$n_(49) set Z_ 0.0

set x_f 150
set y_f 120
set s_n 1
for { set x 1} { $x <10} { incr x } {

set y_c [expr ($x*$y_f)%1000]




for { set y 0} { $y <6} { incr y } {

set x_($s_n) [expr ($x_f*$y)%1000+1]
set y_($s_n) [expr $y_c]


puts "x_($s_n) is $x_($s_n) and y_($s_n) is $y_($s_n)" 
incr s_n
}

}

for { set x 1} { $x <49} { incr x} {

$n_($x) set X_ $x_($x)

$n_($x) set Y_ $y_($x)
$n_($x) set Z_ 0.0


}

$ns at 1.0 "$n_(0) setdest 10.0 999.0 40.0"
$ns at 1.0 "$n_(49) setdest 100.0 900.0 40.0"


$ns at 1.0 "$n_(1) setdest 400.0 500.0 40.0"
$ns at 20.0 "$n_(1) setdest 509.0 600.0 40.0"

$ns at 49.0 "$n_(0) setdest 500.0 609.0 40.0"
$ns at 49.0 "$n_(49) setdest 100.0 100.0 40.0"

puts "in another"

set time1 1.0


for {set x 49} {$x>1} {incr x -1 } {
    set flag 1
    for {set i 2} {$i<$x} {incr i} {
        set y [expr $x % $i]
        if {$y == 0}  {
          
            set flag 0
            break   
        }
    }

    if {$flag ==1} {
        puts "prime is $x "
        set i $x
        set c 1
        set p $x

	while {$i<49} {

	$ns at $time1 "$n_($i) setdest [expr (500-$x_($i)+1)%1000+1] [expr (100-$y_($i))%1000+1] 20.0"
        $ns at [expr 20-$time1] "$n_($i) setdest [expr (1000+$x_($i)+300+1)%1000+1] [expr (1000+$y_($i)+300+1)%1000+1] 50.0"
        $ns at [expr 30-$time1] "$n_($i) setdest [expr (300+$x_($i)+1)%1000] [expr (1000+$y_($i))%1000+1] 50.0"
        $ns at [expr 35-$time1] "$n_($i) setdest [expr (500+$x_($i)+1)%1000] [expr (1000+$y_($i))%1000] 10.0"
        incr c
        puts "c is $c"
	set i [expr $p*$c]
        puts "i inside $i"
        

}
#set time1 [expr $time1+4]
    }
}







#creation of agents
set tcp [new Agent/UDP]
$tcp set fid_ 0
set sink [new Agent/LossMonitor]
$ns attach-agent $n_(0) $tcp
$ns attach-agent $n_(49) $sink
$ns connect $tcp $sink
set ftp [new Application/Traffic/CBR]
$ftp set packetSize_ 1000
#$ftp set interval_ 0.001
$ftp attach-agent $tcp
$ns at 1.0 "$ftp start"

$ns at 0.0 "$n_(0) label node0"
$ns at 0.0 "$n_(49) label node1"
$ns at 80.0 "finish"

proc finish {} {
 global ns tracefile namfile bandwidth throughput
 $ns flush-trace
 close $tracefile
 close $namfile

 exec nam projectSampleDSDVF.nam &
 exec xgraph pojectSampleDSDVBF.xg &
 exec xgraph pojectSampleDSDVTF.xg & 
 exit 0
}



$ns at 1.05 "record $throughput $bandwidth $sink"



proc record { throughput bandwidth  sink } {


set ns [Simulator instance]
set time 0.5
set now [$ns now]
set bw [$sink set bytes_]
puts $bandwidth "$now [expr $bw]"
puts $throughput "$now [expr $bw/$time*8/10000000]"


$ns at [expr $now+$time] "record  $throughput $bandwidth $sink"




}





puts "Starting Simulation"
$ns run




#for { set x 5} { $x <6} { incr x } {
#input_Protocol_pramerters 20 $x 2.0 $x
#}


