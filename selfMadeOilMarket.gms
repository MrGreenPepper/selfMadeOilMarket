Sets

consumer                /d1*d2/
supplier                /s1*s2/
region                  /r1*r2/
;





Parameter Table
baseUtility(region, consumer)
    d1      d2
r1  20      0
r2  0       30
;

Parameter Table
maxConsumption(region, consumer)
    d1      d2
r1 100      0
r2  0       200
;
*take care if one player has multiple maxConsumption nodes
*to give that player also a base utility in the same spots!!!!

Parameter Table                   
costs(region, supplier)                     
    s1      s2
r1  10      0
r2  0       20
;

Parameter Table
maxProduction(region, supplier)                       
    s1      s2
r1  100     0
r2  0       200
;

Parameter Table
transportationCosts(region, region)                       
    r1      r2
r1  0       1
r2  1       0
;

Variables
quantities_d(region, consumer)
consumerSurplus(region, consumer)
Mu_de_low(region, consumer)
Mu_de_up(region, consumer)

quantities_s(region, supplier)
supplierSurplus(region, supplier)
Mu_su_low(region, supplier)
Mu_su_up(region, supplier)

price(region)
;

Mu_de_low.lo(region, consumer)  = 0;
Mu_de_up.lo(region, consumer)  = 0;
Mu_su_low.lo(region, supplier)  = 0;
Mu_su_up.lo(region, supplier)  = 0;


Equations

*demand
maxConsumer
con_consumer_low
con_consumer_up

*supplier
maxSupplier
con_supplier_low
con_supplier_up

*overall
balanceEqu
;


*demand
maxConsumer(region, consumer)..             price(region) - baseUtility(region, consumer) - Mu_de_low(region, consumer) + Mu_de_up(region, consumer) =e= 0;
con_consumer_low(region, consumer)..        quantities_d(region, consumer) =g= 0;
con_consumer_up(region, consumer)..         maxConsumption(region, consumer) - quantities_d(region, consumer) =g= 0;

*supplier
maxSupplier(region, supplier)..             costs(region, supplier) - price(region) - Mu_su_low(region, supplier) + Mu_su_up(region, supplier) =e= 0;
con_supplier_low(region, supplier)..        quantities_s(region, supplier) =g= 0;
con_supplier_up(region, supplier)..         maxProduction(region, supplier) - quantities_s(region, supplier) =g= 0;

*overall
balanceEqu(region)..                                sum((consumer), quantities_d(region, consumer)) - sum((supplier), quantities_s(region, supplier)) =e= 0;

model cournot /
balanceEqu.price,

maxConsumer.quantities_d,
con_consumer_low.Mu_de_low,
con_consumer_up.Mu_de_up,

maxSupplier.quantities_s,
con_supplier_low.Mu_su_low,
con_supplier_up.Mu_su_up
/;

Solve cournot using mcp;