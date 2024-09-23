*'==================================================================
*'Simple Oil Model
*'
*'==================================================================

*$include Data1.gms


Sets
n        Nodes in the network and producer
/NorthAmerica,EU,Russia,OPEC,FarEast/

s scenarios /s1*s4/

alias (n,nn);

Sets
leader(n) /OPEC/

follower(n) /NorthAmerica, EU, Russia, FarEast/;

Parameters
ProdCap2(n)       Capacity limit of production of producer n
/NorthAmerica 40,EU 20,Russia 45,OPEC 95,FarEast 20/
* Millions barrels per day

INT2(n)           Interception point of the inverse demand function in node n
/NorthAmerica 130,EU 130,Russia 130,OPEC 130,FarEast 130/
;
*Int unit dollar per barrel

Table
SLP2(n,s)           Slope of the inverse demand function in node n

                 s1         s2          s3          s4  
NorthAmerica    -1.04       -1.14      -1.04        -1.14
EU              -1.07       -1.07      -1.18        -1.18
Russia          -1.07       -1.07      -1.07        -1.07
OPEC            -1.09       -1.09      -1.09        -1.09
FarEast         -1.02       -1.02      -1.02        -1.02   

;


Parameters c(n)  Linear cost factor in the cost function of producer n
/NorthAmerica 70,EU 80,Russia 65,OPEC 35,FarEast 85/;
*Int unit dollar per barrel

Table
TradeCap2(n,nn)    Capacity limit of trade from producer
                 NorthAmerica         EU      Russia   OPEC    FarEast
NorthAmerica          100             15      5        10      20
EU                    5              100      5        5       5
Russia                10              15      100      15      20
OPEC                  10              20      20       100     20
FarEast               3               3       3        3      100
;

*1000s barrel per day

Table
TradeCost2(n,nn)   TransportCosts
                 NorthAmerica          EU      Russia    OPEC    FarEast
NorthAmerica      0                    5       5         5       5
EU                5                    0       7         3       3
Russia            5                    7       0         5       5
OPEC              5                    3       5         0       3
FarEast           5                    3       5         3       0
;

*dollars per 1000s barrel

Parameters INT(n), SLP(n,s),TradeCap(n,nn), TradeCost(n,nn), ProdCap(n);
INT(n) = 1*INT2(n);
SLP(n,s) = 1*SLP2(n,s);
TradeCap(n,nn) = 1*TradeCap2(n,nn);
TradeCost(n,nn) = TradeCost2(n,nn)/1 ;
ProdCap(n)= ProdCap2(n)*1;
*everything thousand barrels

Positive variables
q_prod(n,s)                Produced quantity of producer n
q_sales(n,nn,s)            Sold quantity of producer n to node n
lambda(n,s)                Lagrange multiplier of production constraint of producer n
rho(n,nn,s)                Lagrange multiplier of trade constraint of producer n
p(nn,s)                    Price of crude oil in node nn
;

Variable
phi(n,s)                   Lagrange multiplier of mass balance
;

Equations
FOC_q_prod               First order condition (FOC) with respect to q_prod
FOC_q_sales              First order condition (FOC) with respect to q_sales
FOC_q_sales_cournot      Cournot case
FOC_lambda               First order condition (FOC) with respect to lambda (ProdCap)
FOC_rho                  First order condition (FOC) with respect to rho (TradeCap)
FOC_phi                  First order condition (FOC) with respect to phi (mass balance)
price                    Price in node n
;


FOC_q_prod(n,s)..           -(- c(n) - lambda(n,s) + phi(n,s)) =e= 0
;

FOC_q_sales(n,nn,s)..       -(p(nn,s)-TradeCost(n,nn) - rho(n,nn,s) - phi(n,s)) =e= 0
;

FOC_q_sales_cournot(n,nn,s).. -(p(nn,s)+ q_sales(n,nn,s)*SLP(nn,s)-TradeCost(n,nn)- rho(n,nn,s) - phi(n,s)) =e= 0
;

FOC_lambda(n,s)..            ProdCap(n) - q_prod(n,s) =g= 0
;

FOC_rho(n,nn,s)..            TradeCap(n,nn) - q_sales(n,nn,s) =g= 0
;

FOC_phi(n,s)..               q_prod(n,s) - sum(nn,q_sales(n,nn,s)) =e= 0
;

price(nn,s)..                p(nn,s) =e= INT(nn) + SLP(nn,s)*sum(n,q_sales(n,nn,s))
;

Model Oil_MCP_Comp
/
FOC_q_prod.q_prod,
FOC_q_sales.q_sales,
FOC_lambda.lambda,
FOC_rho.rho,
FOC_phi.phi,
price.p
/
;

Model Cournot
/
FOC_q_prod.q_prod,
FOC_q_sales_cournot.q_sales,
FOC_lambda.lambda,
FOC_rho.rho,
FOC_phi.phi,
price.p
/
;


*--------------------------------------  Stackelberg Here  ---------------------------------------------*


Positive variables
qpl(leader,s)               Produced quantity of producer leader n
qsl(leader,nn,s)            Sold quantity of producer leader n to node n
qpf(follower,s)               Produced quantity of producer follower n
qsf(follower,nn,s)            Sold quantity of producer follower n to node n
;


Positive variables
lambdal(leader,s)                Lagrange multiplier of production constraint of producer leader n
rhol(leader,nn,s)             Lagrange multiplier of trade constraint of producer leader n
lambdaf(follower,s)                Lagrange multiplier of production constraint of producer follower n
rhof(follower,nn,s)             Lagrange multiplier of trade constraint of producer follower n
;

Positive Variables
pr(nn,s)                     Price of crude oil in node nn
;


Binary Variables
Blambdal(leader,s)             Binary Variable for Lagrange multiplier of production constraint of producer leader n
Brhol(leader,nn,s)             Binary Variable for Lagrange multiplier of trade constraint of producer leader n
Blambdaf(follower,s)           Binary Variable for Lagrange multiplier of production constraint of producer follower n
Brhof(follower,nn,s)           Binary Variable for Lagrange multiplier of trade constraint of producer follower n
;

Scalars
*big Ms
m1 /1e11/
m2 /1e11/
;

Variables
*dummary variable
TC
phil(leader,s)                 Lagrange multiplier of mass balance
phif(follower,s)               Lagrange multiplier of mass balance
;


Equations
FOC_qpl                    First order condition (FOC) with respect to qpl
FOC_qsl                    First order condition (FOC) with respect to qsl
FOC_qpf                    First order condition (FOC) with respect to qpf
FOC_qsf                    First order condition (FOC) with respect to qsf
FOC_lambdal                First order condition (FOC) with respect to lambda leader (ProdCap)
FOC_rhol                   First order condition (FOC) with respect to rho leader (TradeCap)
FOC_lambdaf                First order condition (FOC) with respect to lambda follower (ProdCap)
FOC_rhof                   First order condition (FOC) with respect to rho follower (TradeCap)

PFOC_lambdal               First order condition (FOC) with respect to lambda leader (ProdCap)
PFOC_rhol                  First order condition (FOC) with respect to rho leader (TradeCap)
PFOC_lambdaf               First order condition (FOC) with respect to lambda follower (ProdCap)
PFOC_rhof                  First order condition (FOC) with respect to rho follower (TradeCap)

DFOC_lambdal               First order condition (FOC) with respect to lambda leader (ProdCap)
DFOC_rhol                  First order condition (FOC) with respect to rho leader (TradeCap)
DFOC_lambdaf               First order condition (FOC) with respect to lambda follower (ProdCap)
DFOC_rhof                  First order condition (FOC) with respect to rho follower (TradeCap)

FOC_phil                  First order condition (FOC) with respect to phi leader (mass balance)
FOC_phif                  First order condition (FOC) with respect to phi follower (mass balance)
pricer                    Price in node n
OF                        objective function
;

*leader's negative profit (note that this is not langarangian)

OF..                            TC =e= sum(s, sum(leader, Prodcap(leader) *lambdal(leader,s))+ sum((leader,nn), TradeCap(leader,nn)*rhol(leader,nn,s)))                         
;

FOC_qpl(leader,s)..              (c(leader) + lambdal(leader,s) - phil(leader,s)) =e= 0
;
FOC_lambdal(leader,s)..          ProdCap(leader)- qpl(leader,s)  =g= 0
;
PFOC_lambdal(leader,s)..         ProdCap(leader) - qpl(leader,s) =l= Blambdal(leader,s)*m1
;
DFOC_lambdal(leader,s)..         lambdal(leader,s) =l= (1-Blambdal(leader,s))*m2
;


FOC_qsl(leader,nn,s)..             (-pr(nn,s) - qsl(leader,nn,s)*SLP(nn,s)+TradeCost(leader,nn)+ rhol(leader,nn,s) + phil(leader,s)) =e= 0
;
FOC_rhol(leader,nn,s)..            TradeCap(leader,nn) - qsl(leader,nn,s) =g= 0
;
PFOC_rhol(leader,nn,s)..           TradeCap(leader,nn) - qsl(leader,nn,s) =l= Brhol(leader,nn,s)*m1
;
DFOC_rhol(leader,nn,s)..           rhol(leader,nn,s) =l= (1-Brhol(leader,nn,s))*m2
;

FOC_qpf(follower,s)..             ( c(follower) + lambdaf(follower,s) - phif(follower,s)) =e= 0
;
FOC_lambdaf(follower,s)..          ProdCap(follower) - qpf(follower,s) =g= 0
;
PFOC_lambdaf(follower,s)..         ProdCap(follower) - qpf(follower,s) =l= Blambdaf(follower,s)*m1
;
DFOC_lambdaf(follower,s)..         lambdaf(follower,s) =l= (1-Blambdaf(follower,s))*m2
;

FOC_qsf(follower,nn,s)..          (-pr(nn,s) - qsf(follower, nn,s)*SLP(nn,s)+TradeCost(follower,nn) + rhof(follower,nn,s) + phif(follower,s)) =e= 0
;
FOC_rhof(follower,nn,s)..          TradeCap(follower,nn) - qsf(follower,nn,s) =g= 0
;
PFOC_rhof(follower,nn,s)..         TradeCap(follower,nn) - qsf(follower,nn,s) =l= Brhof(follower,nn,s)*m1
;
DFOC_rhof(follower,nn,s)..         rhof(follower,nn,s) =l= (1-Brhof(follower,nn,s))*m2
;

FOC_phil(leader,s)..              qpl(leader,s) - sum(nn,qsl(leader,nn,s)) =e= 0
;
FOC_phif(follower,s)..            qpf(follower,s) - sum(nn,qsf(follower,nn,s)) =e= 0
;

pricer(nn,s)..                    pr(nn,s) =e= INT(nn) + SLP(nn,s)*(sum(follower,qsf(follower,nn,s))+sum(leader, qsl(leader,nn,s)))
;

model MARKET_SPLIT_MILP

/ 
FOC_qpl
FOC_qsl
FOC_qpf,               
FOC_qsf,                  
FOC_lambdal,                
FOC_rhol,                  
FOC_lambdaf,               
FOC_rhof,            

PFOC_lambdal,              
PFOC_rhol,                  
PFOC_lambdaf,              
PFOC_rhof,               

DFOC_lambdal,               
DFOC_rhol,               
DFOC_lambdaf,           
DFOC_rhof,                

FOC_phil,                  
FOC_phif,                  
price,
OF                    
/ ;


solve Oil_MCP_Comp using mcp;

parameters  profitcomp(n,s);

profitcomp(n,s) =  c(n)*q_prod.l(n,s) + sum(nn, TradeCost(n, nn)*q_sales.l(n, nn,s) - p.l(nn,s)*q_sales.l(n, nn,s));

display profitcomp, q_prod.l,q_sales.l,p.l;

execute_unload 'results_perf.gdx';

solve Cournot using mcp;

parameters  profitcour(n,s);

profitcour(n,s) =  c(n)*q_prod.l(n,s)+ sum(nn, TradeCost(n, nn)*q_sales.l(n, nn,s) - p.l(nn,s)*q_sales.l(n, nn,s));

display profitcour, q_prod.l,q_sales.l,p.l;
execute_unload 'results_cour.gdx';

solve MARKET_SPLIT_MILP using mip minimizing TC ;

parameters  profitr(n,s);
parameters  profitl(leader,s), profitf(follower,s);

profitl(leader,s) =  c(leader)*qpl.l(leader,s)+ sum(nn, TradeCost(leader, nn)*qsl.l(leader, nn,s) - pr.l(nn,s)*qsl.l(leader, nn,s));
profitf(follower,s) =  c(follower)*qpf.l(follower,s)+ sum(nn, TradeCost(follower, nn)*qsf.l(follower, nn,s) - pr.l(nn,s)*qsf.l(follower, nn,s));

display profitl, profitf;

display  qpl.l,qsl.l,qpf.l,qsf.l, pr.l, TC.l;

execute_unload 'results_stack.gdx';


