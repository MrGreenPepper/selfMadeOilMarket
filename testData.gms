

Sets

region                   /r1*r2/

alias(region, supplier)
alias(region,regionB)
alias(region,consumer)
;





Parameter 
MaxConsumption(region)                  /r1  100, r2  100/
               
ProductionCosts(supplier)               /r1  10, r2  10/
ProductionCap(supplier)                 /r1  10, r2 1000/
SlopeDemand(region)                     /r1  -1, r2 -1/        
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
r1  50000   5000  
r2  5000    50000    
;
