Sets

region                    /NorthAmerica,EU,Russia,OPEC,FarEast/
;

alias(region,consumer, supplier);

Sets
leader (region)  /OPEC/

follower (region)  /NorthAmerica,EU,Russia,FarEast/
;


Parameter 
baseUtility(consumer)                     /NorthAmerica 10,EU 10,Russia 10,OPEC 10,FarEast 10/
maxConsumption(consumer)                  /NorthAmerica 20,EU 20,Russia 20,OPEC 20,FarEast 20/
               
ProductionCap(supplier)                 /NorthAmerica 19.25,EU 3.75,Russia 11.7,OPEC 33.87,FarEast 3.9691/             



INT(consumer) Interception point of the inverse demand function in node nn
/NorthAmerica 0.190556,EU 2.21038,Russia 0.24444,OPEC 0.23766,FarEast 2.77584/

SLP(consumer)          Slope of the inverse demand function in node nn
/NorthAmerica -0.00008,EU -0.00016,Russia -0.00005,OPEC -0.00002,FarEast -0.00014/

prod_cost(supplier)             Linear cost factor in the cost function of producer n
/ NorthAmerica 22.85,EU 29.09,Russia 19.21,OPEC 9.39,FarEast 29.9/

cost(supplier, consumer) total cost for per unit of oil

;



Parameter Table
TransportationCosts(supplier, consumer)                       

                    NorthAmerica    EU      Russia  OPEC    FarEast
NorthAmerica         0              91.63   91.63   126.48  126.48
EU                   91.63          0       7.33    57.17   152.46
Russia               91.63          7.33    0       57.17   152.46
OPEC                 126.48         57.17   57.17   0       95.29
FarEast              126.48         152.46  152.46  95.29   0

;


Parameter Table
TransportationCap(supplier, consumer)                       
                    NorthAmerica    EU      Russia  OPEC    FarEast
NorthAmerica         35             35      35      35      35 
EU                   35             35      35      35      35
Russia               35             35      35      35      35
OPEC                 35             35      35      35      35
FarEast              35             35      35      35      35

;