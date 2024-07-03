Sets

region                   /r1*r3/
;

alias(region,consumer, supplier);

Sets
leader (region)  /r1/

follower (region)  /r2, r3/
;


Parameter 
baseUtility(consumer)                     /r1  45, r2  55, r3 65/
maxConsumption(consumer)                  /r1  800, r2 400, r3 100/
               
ProductionCap(supplier)                 /r1  1000, r2 200, r3 200/             



INT(consumer) Interception point of the inverse demand function in node nn
/r1 130, r2 130, r3 140/

SLP(consumer)          Slope of the inverse demand function in node nn
/r1 -1, r2 -1, r3 -1/

prod_cost(supplier)             Linear cost factor in the cost function of producer n
/ r1 30, r2 80, r3 65/

cost(supplier, consumer) total cost for per unit of oil

;


Parameter Table
TransportationCosts(supplier, consumer)                       
    r1      r2      r3
r1  0       1       2
r2  1       0       1
r3  2       1       0
;


Parameter Table
TransportationCap(supplier, consumer)                       
    r1      r2      r3
r2  60      70      20
r3  50      10     10

;