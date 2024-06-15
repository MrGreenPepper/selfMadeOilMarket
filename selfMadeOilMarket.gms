Sets

region                   /r1*r3/
consumer(region)         /r1*r2/
supplier(region)         /r2*r3/

alias(region,regionB)
;





Parameter 
baseUtility(region)                     /r1  30, r2  30/
maxConsumption(region)                  /r1  100, r2  200/
               
costs(region)                           /r2  10, r3  20/
ProductionCap(region)                   /r2  1000, r3 200/             
;


Parameter Table
transportationCosts(region, regionB)                       
    r1      r2      r3
r1  0       1       2
r2  1       0       1
r3  2       1       0
;

Positive Variable
transport(region, regionB)
*is supplier here necessary?
Variables
quantities_demand(region)
consumerSurplus(region)
Mu_de_low(region)
Mu_de_up(region)

quantities_sold(supplier, region)       
supplierSurplus(supplier)
Mu_soll_low(supplier, region)
Mu_sell_up(supplier, region)
Mu_production_low(supplier)
Mu_production_up(supplier)
Mu_transport_low(supplier)
Mu_transport_up(supplier
price(region)
;

Mu_de_low.lo(region)  = 0;
Mu_de_up.lo(region)  = 0;

Mu_trading.lo(supplier, region) = 0;
Mu_sell.lo(supplier, region)  = 0;
Mu_production.lo(supplier)  = 0;
Mu_production_up.lo(supplier)  = 0;

Equations

*transport
transportE_constraint_sum
transportE_constraint_max
transportE

*demand
maxConsumer
con_consumer_low
con_consumer_up

*supplier
maxSelling
maxProduction
con_sell_low
con_sell_up

*overall
balanceEqu
;

*transport
*transportE_constraint_sum..                 transport(region,regionB)           
*transportE_constraint_max..
*transportE..                                

*demand
maxConsumer(region)..                           price(region) - baseUtility(region) - Mu_de_low(region) + Mu_de_up(region) =e= 0;
con_consumer_low(region)..                      quantities_demand(region) =g= 0;
con_consumer_up(region)..                       maxConsumption(region) - quantities_demand(region) =g= 0;

*supplier
*first derivation to selling
maxSelling(supplier, region)..                  transportationCosts(supplier, region) - price(region) + Mu_trading(supplier, region) + Mu_sell(supplier, region) =e= 0;
*first derivation to production
maxProduction(supplier, region)..               costs(region) - Mu_trading(supplier, region) + Mu_production(supplier) =e= 0;


con_sell_low(supplier, region)..                quantities_sold(supplier, region) =g= 0;
con_sell_up(supplier)..                         ProductionCap(supplier) - sum((region), quantities_sold(supplier, region)) =g= 0;

*overall
balanceEqu(region)..                            sum((supplier), quantities_sold(supplier, region)) - quantities_demand(region) =e= 0;

model cournot /
balanceEqu.price,

maxConsumer.quantities_demand,
con_consumer_low.Mu_de_low,
con_consumer_up.Mu_de_up,

maxSupplier.quantities_sold,
con_supplier_low.Mu_sell,
con_sell_up.Mu_sell_up
/;

Solve cournot using mcp;