BEGIN	{
    start=0
    end=0
    Flag=0
   StartTime=0
   EndTime=0
   
 

    
}
{
if( $3=="_0_" && $1=="s" && $4=="AGT")
{
if(Flag == 0)
{
StartTime=$2
Flag=1
}


}



if( $3=="_299_" && $1=="r" && $4=="AGT")
{
EndTime=$2


}
   
     if ($1=="s" && $3=="_0_" && $4=="AGT"  ) {
         packet_id=$6
         
         startCount++
         startTime[packet_id]=$2
     }
      if ($1=="r" && $3=="_299_" && $4=="AGT"  ) {
         packet_id=$6
        Throughput+=$8
         
         recieveCount++
         if($2<10){
             endTimeOne[packet_id]=$2
             packetOne++
         }
         if($2<20 && $2>10){
             endTimeTwo[packet_id]=$2
              packetTwo++
         }
         if ($2<30 && $2 >20) {
             endTimeThree[packet_id]=$2
              packetThree++
             
         }
         if ($2<40 && $2 >30) {
             endTimefour[packet_id]=$2
              packetFour++
             
         }
         if ($2<50 && $2 >40) {
             endTimeFive[packet_id]=$2
              packetFive++
             
         }
         if ($2<60 && $2 >50) {
             endTimeSix[packet_id]=$2
              packetSix++
             
         }
         if ($2<70 && $2 >60) {
             endTimeSeven[packet_id]=$2
              packetSeven++
             
         }
         if ($2<80 && $2 >70) {
             endTimeEight[packet_id]=$2
              packetEight++
             
         }
         
     }
   
    

}
END	{
    for (i in endTimeOne ) {
        delayOne+=endTimeOne[i]-startTime[i]
        
    }
     for (i in endTimeTwo ) {
        delayTwo+=endTimeTwo[i]-startTime[i]
        
    }
     for (i in endTimeThree ) {
        delayThree+=endTimeThree[i]-startTime[i]
        
    }
     for (i in endTimefour ) {
        delayFour+=endTimefour[i]-startTime[i]
        
    }
     for (i in endTimeFive ) {
        
        delayFive+=endTimeFive[i]-startTime[i]
        
    }
     for (i in endTimeSix ) {
        delaySix+=endTimeSix[i]-startTime[i]
        
    }
     for (i in endTimeSeven ) {
        delaySeven+=endTimeSeven[i]-startTime[i]
        
    }
     for (i in endTimeEight ) {
        delayEight+=endTimeEight[i]-startTime[i]
        
    }
    if(packetOne >0){
        print "avergae delay in 0 t0 10 time span is " delayOne/packetOne
    }
     if(packetTwo >0){
        print "avergae delay in 10 t0 20 time span is " delayTwo/packetTwo
    }
     if(packetThree >0){
        print "avergae delay in 20 t0 30 time span is " delayThree/packetThree
    }
     if(packetFour >0){
        print "avergae delay in 30 t0 40 time span is " delayFour/packetFour
    }
     if(packetFive >0){
        print "avergae delay in 40 t0 50 time span is " delayFive/packetFive
    }
     if(packetSix >0){
        print "avergae delay in 50 t0 60 time span is " delaySix/packetSix
    }
     if(packetSeven >0){
        print "avergae delay in 60 t0 70 time span is " delaySeven/packetSeven
    }
     if(packetEight >0){
        print "avergae delay in 70 t0 80 time span is " delayEight/packetEight
    }
    print  "total delay is " (delayOne+delayTwo+delayThree+delayFour+delayFive+delaySix+delaySeven+delayEight)/recieveCount
    print "recived count is " recieveCount
    print "in delay count is " packetOne+packetTwo+packetThree+packetFive+packetFour+packetSix+packetSeven+packetEight
    print  "packets sent are " startCount
    print  "throughput is " Throughput
    print "Throughhput by delay is   " Throughput/(EndTime-StartTime)

}


