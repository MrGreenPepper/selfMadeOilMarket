

Sets

region                   /r1*r2/

alias(region, supplier)
alias(region,regionB)
;





Parameter 
*baseUtility(region)                     /r1  60, r2  60, r3 0/
MaxConsumption(region)                  /r1  100, r2  100/
               
ProductionCosts(supplier)               /r1  8, r2  10/
ProductionCap(supplier)                 /r1  10, r2  0/
SlopeDemand(region)                     /r1 -1, r2 -1/        
;


Parameter Table
TransportationCosts(region, regionB)                       
    r1      r2      
r1  0       1       
r2  1       0      
      
;

Parameter Table
TransportationCap(supplier, regionB)                       
    r1      r2     
r1  50      50     
r2  50      50    

;
