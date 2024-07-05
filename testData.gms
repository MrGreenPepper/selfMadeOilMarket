

Sets

region                   /r1*r3/
consumer(region)         /r1*r2/
supplier(region)         /r1*r3/

alias(region,regionB)
;





Parameter 
*baseUtility(region)                     /r1  60, r2  60, r3 0/
MaxConsumption(region)                  /r1  100, r2  150, r3 200/
               
ProductionCosts(supplier)               /r1  8, r2  10, r3  15/
ProductionCap(supplier)                 /r1  150, r2  150, r3 200/
SlopeDemand(region)                     /r1 -1, r2 -1, r3 -1/         
;


Parameter Table
TransportationCosts(region, regionB)                       
    r1      r2      r3
r1  0       1       2
r2  1       0       1
r3  2       1       0
;

Parameter Table
TransportationCap(supplier, regionB)                       
    r1      r2      r3
r1  50     50     50
r2  50     50     50
r3  50     50     50
;
