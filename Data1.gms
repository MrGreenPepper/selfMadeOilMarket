$ontext

prodcap
19,25
3,75
11,7
33,87
3,9691


North America
EU
Russia
OPEC
Far East



Parameter 
baseUtility(consumer)                     /NorthAmerica 10,EU 10,Russia 10,OPEC 10,FarEast 10/
maxConsumption(consumer)                  /NorthAmerica 20,EU 20,Russia 20,OPEC 20,FarEast 20/
               
ProductionCap(supplier)                 /NorthAmerica 19.25,EU 3.75,Russia 11.7,OPEC 33.87,FarEast 3.9691/             


INT(consumer) Interception point of the inverse demand function in node nn
/NorthAmerica 190556,EU 221038,Russia 244440,OPEC 237660,FarEast 277584/

SLP(consumer)          Slope of the inverse demand function in node nn
/NorthAmerica -0.00008,EU -0.00016,Russia -0.00005,OPEC -0.00002,FarEast -0.00014/

prod_cost(supplier)             Linear cost factor in the cost function of producer n
/ NorthAmerica 22.85,EU 29.09,Russia 19.21,OPEC 9.39,FarEast 29.9/

cost(supplier, consumer) total cost for per unit of oil

;

$offtext


Sets
n        Nodes in the network and producer
/NorthAmerica,EU,Russia,OPEC,FarEast/

s scenarios /s1*s3/

alias (n,nn);

Sets
leader(n) /OPEC/

follower(n) /NorthAmerica, EU, Russia, FarEast/;

Parameters
ProdCap(n)       Capacity limit of production of producer n
/NorthAmerica 40,EU 20,Russia 45,OPEC 95,FarEast 20/

INT(n)           Interception point of the inverse demand function in node n
/NorthAmerica 130,EU 130,Russia 130,OPEC 130,FarEast 130/
;

Table
SLP(n,s)           Slope of the inverse demand function in node n

                 s1         s2          s3          s4  
NorthAmerica    -1.04       -1.14      -1.04        -1.14
EU              -1.07       -1.07      -1.18        -1.18
Russia          -1.07       -1.07      -1.07        -1.07
OPEC            -1.09       -1.09      -1.09        -1.09
FarEast         -1.02       -1.02      -1.02        -1.02   

;

Parameters c(n)  Linear cost factor in the cost function of producer n
/NorthAmerica 70,EU 80,Russia 65,OPEC 35,FarEast 85/;

Table
TradeCap(n,nn)    Capacity limit of trade from producer
                 NorthAmerica         EU      Russia  OPEC    FarEast
NorthAmerica          100             10      10      10      10
EU                    10              100     10      10      10
Russia                10              10      100     10      10
OPEC                  10              10      10      100     10
FarEast               10              10      10      10      100
;

Table
TradeCost(n,nn)   TransportCosts
                 NorthAmerica          EU      Russia    OPEC    FarEast
NorthAmerica      0                    5       5         5       5
EU                5                    0       7         3       3
Russia            5                    7       0         5       5
OPEC              5                    3       5         0       3
FarEast           5                    3       5         3       0

;


$ontext





Sets
n        Nodes in the network and producer
/NorthAmerica,EU,Russia,OPEC,FarEast/

alias (n,nn);

Sets
leader(n) /OPEC/
follower(n) /NorthAmerica, EU, Russia, FarEast/;

Parameters
ProdCap(n)       Capacity limit of production of producer n
/NorthAmerica 1925,EU 375,Russia 1170,OPEC 3387,FarEast 397/

INT(n)           Interception point of the inverse demand function in node n
/NorthAmerica 190.556,EU 190.556,Russia 190.556,OPEC 190.556,FarEast 190.556/

SLP(n)           Slope of the inverse demand function in node n
/NorthAmerica -1.466, EU -1.7, Russia -1.726, OPEC -1.828, FarEast -2.137/

c(n)             Linear cost factor in the cost function of producer n
/NorthAmerica 22.85,EU 29.09,Russia 19.21,OPEC 9.39,FarEast 29.9/;

Table
TradeCap(n,nn)    Capacity limit of trade from producer
                 NorthAmerica         EU      Russia  OPEC    FarEast
NorthAmerica          100             10      10      10      10
EU                    10              100     10      10      10
Russia                10              10      100     10      10
OPEC                  10              10      10      100     10
FarEast               10              10      10      10      100


;

Table
TradeCost(n,nn)   TransportCosts
                 NorthAmerica          EU      Russia    OPEC    FarEast
NorthAmerica      0                    5       5         5       5
EU                5                    0       7         3       3
Russia            5                    7       0         5       5
OPEC              5                    3       5         0       3
FarEast           5                    3       5         3       0

;


----------------------------------


working fine but stackelberg cournot results same
Sets
n        Nodes in the network and producer
/NorthAmerica,EU,Russia,OPEC,FarEast/

alias (n,nn);

Sets
leader(n) /OPEC/
follower(n) /NorthAmerica, EU, Russia, FarEast/;

Parameters
ProdCap(n)       Capacity limit of production of producer n
/NorthAmerica 1925,EU 375,Russia 1170,OPEC 6387,FarEast 397/

INT(n)           Interception point of the inverse demand function in node n
/NorthAmerica 190.556,EU 221.038,Russia 244.440,OPEC 237.660,FarEast 277.840/

SLP(n)           Slope of the inverse demand function in node n
/NorthAmerica -1.466, EU -1.7, Russia -1.726, OPEC -1.828, FarEast -2.137/

c(n)             Linear cost factor in the cost function of producer n
/NorthAmerica 22.85,EU 29.09,Russia 19.21,OPEC 9.39,FarEast 29.9/;

Table
TradeCap(n,nn)    Capacity limit of trade from producer
                 NorthAmerica         EU      Russia  OPEC    FarEast
NorthAmerica          100             10      10      10      10
EU                    10              100     10      10      10
Russia                10              10      100     10      10
OPEC                  10              10      10      100     10
FarEast               10              10      10      10      100


;

Table
TradeCost(n,nn)   TransportCosts
                 NorthAmerica          EU      Russia    OPEC    FarEast
NorthAmerica      0                    5       5         5       5
EU                5                    0       7         3       3
Russia            5                    7       0         5       5
OPEC              5                    3       5         0       3
FarEast           5                    3       5         3       0

;

-----------------

Table
TradeCap(n,nn)    Capacity limit of trade from producer
                 NorthAmerica         EU      Russia    OPEC    FarEast
NorthAmerica          100             100     100      100      100
EU                    10             100     100      100      100
Russia                10             100     100      100      100
OPEC                  10             100     100      100      100
FarEast               10             100     100      100      100

Table
TradeCap(n,nn)    Capacity limit of trade from producer
                 NorthAmerica         EU      Russia  OPEC    FarEast
NorthAmerica          100             100     10      10      10
EU                    10              100     10      10      10
Russia                10              10      100     10      10
OPEC                  10              10      10      100     10
FarEast               10              10      10      10      100

;

Table
TradeCap(n,nn)    Capacity limit of trade from producer
                 NorthAmerica         EU      Russia  OPEC    FarEast
NorthAmerica          100             10      50      50      50
EU                    50              100     50      50      50
Russia                50              50      100     50      50
OPEC                  50              50      50      100     50
FarEast               50              50      50      50      100
;
TradeCost(n,nn)   TransportCosts
                 NorthAmerica          EU      Russia    OPEC    FarEast
NorthAmerica      0                    0.5     0.5       0.5       0.5
EU                0.5                  0       0.7       0.3       0.3
Russia            0.5                  0.7     0         0.5       0.5
OPEC              0.5                  0.3     0.5       0         0.3
FarEast           0.5                  0.3     0.5       0.3       0



;
---------------------


Sets
n        Nodes in the network and producer
/America, EU, Asia, OPEC, SaudiArabia/

alias (n,nn);

Sets
leader(n) /SaudiArabia/
follower(n) /America, EU, Asia, SaudiArabia/;

Parameters
ProdCap(n)       Capacity limit of production of producer n
/America 40,EU 20,Asia 35,OPEC 50,SaudiArabia 55/

INT(n)           Interception point of the inverse demand function in node n
/America 130, EU 130, Asia 130, OPEC 130, SaudiArabia 130/

SLP(n)           Slope of the inverse demand function in node n
/America -1, EU -1, Asia -1, OPEC -1, SaudiArabia -1/

c(n)             Linear cost factor in the cost function of producer n
/America 70, EU 80, Asia 65, OPEC 40, SaudiArabia 35/

Table
TradeCap(n,nn)    Capacity limit of trade from producer
                   America         EU      Asia    OPEC    SaudiArabia
America            100             10      10      10      10
EU                 10              100     10      10      10
Asia               10              10      100     10      10
OPEC               10              10      10      100     10
SaudiArabia        10              10      10      10      100

;

Table
TradeCost(n,nn)   TransportCosts
                 America          EU      Asia    OPEC    SaudiArabia
America          0                5       5       5       5
EU               5                0       7       3       3
Asia             5                7       0       5       5
OPEC             5                3       5       0       3
SaudiArabia      5                3       5       3       0

;

$offtext
*----------------------------------------------- data back-up------------------------------------------------*
$ontext

Orginal perfect competion


Objective Function (negative profit)      -q_sales(n,nn)*p(nn)+q_sales(n,nn)*TradeCost(n,nn) + c(n)* q_prod 

s.t. constraints,


production cap        ProdCap(n) - q_prod(n) =g= 0
;

trade cap         TradeCap(n,nn) - q_sales(n,nn) =g= 0
;

mass balance        q_prod(n) - sum(nn,q_sales(n,nn)) =e= 0
                                    
and,  q_prod(n), q_sales(n,nn) =g= 0;

Resulting Langrangian function

L_p = -q_sales(n,nn)*p(nn)+q_sales(n,nn)*TradeCost(n,nn) + c(n)* q_prod + lambda(n)(ProdCap(n) - q_prod(n)) +rho (n,nn)*(TradeCap(n,nn) - q_sales(n,nn)) + phi(n)*(q_prod(n) - sum(nn,q_sales(n,nn)) )

where,  lambda(n), rho (n,nn) =g= 0; and phi(n) free


------------------stackelberg---------------------------------

write something about stackelberg model, how upper level and lower level formulization of problem works

Objective Function (negative profit of the leader)                        Min  Pi_l =e= sum(leader, c(leader)*qpl(leader)+ sum(nn, TradeCost(leader, nn)*qsl(leader, nn) - p(nn)*qsl(leader, nn)));

s.t. constraints,

Leader's production, sales and mass balance constraits

ProdCap(leader)- qpl(leader)  =g= 0

TradeCap(leader,nn) - qsl(leader,nn) =g= 0

qpl(leader) - sum(nn,qsl(leader,nn)) =e= 0
 


s.t. (lower level problem)


 Negative profit of all the players Min Pi = -q_sales(n,nn)*p(nn)+q_sales(n,nn)*TradeCost(n,nn) + c(n)* q_prod 
 
s.t. lower level constraints

Follower's production, sales and mass balance constraits

ProdCap(follower)- qpl(follower)  =g= 0

TradeCap(follower,nn) - qsl(follower,nn) =g= 0

qpl(follower) - sum(nn,qsl(follower,nn)) =e= 0
 

Equilibrium equaivalent (first order conditions) of player's profit is given as below,


Equilibrium constraints pertaining to lower level problem

(c(leader) + lambdal(leader) - phil(leader)) =e= 0

(-pr(nn) - qsl(leader,nn)*SLP(nn)+TradeCost(leader,nn)+ rhol(leader,nn) + phil(leader)) =e= 0

 ( c(follower) + lambdaf(follower) - phif(follower)) =e= 0
 
 (-pr(nn) - qsf(follower, nn)*SLP(nn)+TradeCost(follower,nn) + rhof(follower,nn) + phif(follower)) =e= 0
 

The main task is to linearize non linear objective functtion so that it can be solved by linear prorblem solvers, which have better computational efficiency than non linear one.

If we write dual equaivalent of upper level problem we get,

Max lambdal* ProdCap(leader) + rhol* TradeCap(leader, ll)

Now, strong duality duality therorem suggest that at the point of obtimality solution by primal and dual objective function will be same,
so

-P(nn)*Qsl = lambdal* ProdCap(leader) + rhol* TradeCap(leader, ll) - q_sales(n,nn)*TradeCost(n,nn) - c(n)* q_prod

making this replacement in objective function we get,

Pi_l =e= sum(leader, c(leader)*qpl(leader)+ sum((nn), TradeCost(leader, nn)*qsl(leader, nn)))
                                + sum(leader, Prodcap(leader)*lambdal(leader) - c(leader)*qpl(leader))
                                + sum((leader,nn), TradeCap(leader,nn)*rhol(leader,nn) - TradeCost(leader,nn)*qsl(leader,nn))


Now the we intruduce binary variables to chance MCP to MIP,which results in following additional constraints, (name all the following equations using alpha numeric combination, same number different alphabets
like 11.a, ll.b. ll.c etc)

PFOC_lambdal(leader)..         ProdCap(leader) - qpl(leader) =l= Blambdal(leader)*m1
;
DFOC_lambdal(leader)..         lambdal(leader) =l= (1-Blambdal(leader))*m2

PFOC_rhol(leader,nn)..           TradeCap(leader,nn) - qsl(leader,nn) =l= Brhol(leader,nn)*m1
;
DFOC_rhol(leader,nn)..           rhol(leader,nn) =l= (1-Brhol(leader,nn))*m2
;
PFOC_lambdaf(follower)..         ProdCap(follower) - qpf(follower) =l= Blambdaf(follower)*m1
;
DFOC_lambdaf(follower)..         lambdaf(follower) =l= (1-Blambdaf(follower))*m2
;

PFOC_rhof(follower,nn)..         TradeCap(follower,nn) - qsf(follower,nn) =l= Brhof(follower,nn)*m1
;
DFOC_rhof(follower,nn)..         rhof(follower,nn) =l= (1-Brhof(follower,nn))*m2
;


$offtext

