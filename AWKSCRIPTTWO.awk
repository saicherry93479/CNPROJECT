BEGIN	{
     jitterLast=0
    
}
{
    if ($1=="r" && $3=="_299_" && $4=="AGT"  ) {
         packet_id=$6
         
         recieveCount++
        recievedTime[packet_id]=$2
     }
     if ($1=="s" && $3=="_0_" && $4=="AGT"  ) {
         packet_id=$6
         
         
        startTime[packet_id]=$2
     }

}
END	{
    print  "recieve count is " recieveCount
    j=0
    for(i in recievedTime){
       jitter[j]=recievedTime[i]-startTime[i] #this is latency
       j++

    }
    print "j is " j
    print "recieved count is " recieveCount
    print "at j " jitter[j]
    for(i=0;i<j-1;i++ ){
        jitterLast+=abs(jitter[i]-jitter[i+1])
    }
    print  "jitterlast is " jitterLast
    print  "jitter is " jitterLast/(recieveCount-1)

   
    
}
function  abs(value) {
    if (value<0) {
        value=0-value
        
    }
    return value
    
}
