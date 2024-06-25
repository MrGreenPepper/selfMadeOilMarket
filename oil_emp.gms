*'==================================================================
*'Simple Oil Model
*'
*'Profit maximization of crude oil producers formulated
*'as mixed complementarity problem under perfect competition
*'==================================================================

Sets
n        Nodes in the network and producer
/America, EU, Asia, OPEC, SaudiArabia/

alias (n,nn);

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
America          100             10      10      10      10
EU               10              100     10      10      10
Asia             10              10      100     10      10
OPEC             10              10      10      100     10
SaudiArabia      10              10      10      10      100

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

Positive variables
q_prod(n)                Produced quantity of producer n
q_sales(n,nn)            Sold quantity of producer n to node n
price(nn)                Price of crude oil in node nn
profit(n)
;



Equations
balance                     balance eq
price_EQ                    Price in node n
prodCap_EQ
profit_EQ
;



price_EQ(nn)..              price(nn) =e= INT(nn) + SLP(nn)*sum(n,q_sales(n,nn));
balance..                   sum(n, q_prod(n)) =e= sum((n,nn), q_sales(n, nn));
prodCap_EQ(n)..             sum(nn, q_sales(n,nn)) =g= q_prod(n);
profit_EQ(n)..              sum(nn, (TradeCost(n,nn) - price(nn))*q_sales(n,nn)) + q_prod(n) * c(n) =e= profit(n);

model me / balance, prodCap_EQ, profit_EQ/;


file info / '%emp.info%' /;
put info 'equilibrium';
loop(n,
    put / 'min', profit(n);
    loop(nn, put q_sales(n,nn));
    put / profit_EQ(n), prodCap_EQ(n);
);
put /balance/
putclose;


solve me using emp;