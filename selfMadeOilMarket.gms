Sets

region                   /r1*r3/
consumer(region)         /r1*r2/
supplier(region)         /r2*r3/

alias(region,regionB)
;





Parameter 
baseUtility(region)                     /r1  30, r2  30/
maxConsumption(region)                  /r1  100, r2  200/
               
ProductionCosts(supplier)               /r2  10, r3  20/
ProductionCap(supplier)                 /r2  1000, r3 200/             
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
r2  1       0       100
r3  50      100     0
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
quantities_prod(supplier)         
supplierSurplus(supplier)
mu_transCap_low
mu_transCap_up
mu_sellCap_low
mu_sellCap_up
mu_prodCap_low
mu_prodCap_up

price(region)
;

Mu_de_low.lo(region)  = 0;
Mu_de_up.lo(region)  = 0;

mu_transCap_low.lo(supplier, region)  = 0;
mu_transCap_up.lo(supplier, region)  = 0;
mu_sellCap_low.lo(supplier)  = 0;
mu_sellCap_up.lo(supplier)  = 0;
mu_prodCap_low.lo(supplier)  = 0;
mu_prodCap_up.lo(supplier)  = 0;


Equations



*demand
maxConsumer
con_consumer_low
con_consumer_up

*supplier
maxSupplier_q_sell
maxSupplier_q_prod
con_supplier_transCap_low(supplier, region)
con_supplier_transCap_up(supplier, region)
con_supplier_sellCap_low(supplier)
con_supplier_sellCap_up(supplier)
con_supplier_prodCap_low(supplier)
con_supplier_prodCap_up(supplier)

*overall
balanceEqu
;                           

*demand
maxConsumer(region)..                           price(region) - baseUtility(region) - Mu_de_low(region) + Mu_de_up(region) =e= 0;
con_consumer_low(region)..                      quantities_demand(region) =g= 0;
con_consumer_up(region)..                       maxConsumption(region) - quantities_demand(region) =g= 0;

*supplier
*sums are questionable here, especially with the mu_transCap_low/up
maxSupplier_q_sell(supplier)..                  sum((region),TransportationCosts(supplier, region)-price(region)
                                                - mu_transCap_low(supplier, region)
                                                + mu_transCap_up(supplier, region)
                                                - mu_sellCap_low(supplier)
                                                + mu_sellCap_up(supplier))
                                                =e= 0;
maxSupplier_q_prod(supplier)..                  ProductionCosts(supplier)
                                                -mu_sellCap_up(supplier)
                                                -mu_prodCap_low(supplier)
                                                +mu_prodCap_up(supplier)
                                                =e= 0;
                                                
con_supplier_transCap_low(supplier, region)..      -quantities_sold(supplier,region) =g= 0;
con_supplier_transCap_up(supplier, region)..       quantities_sold(supplier,region) - TransportationCap(supplier, region) =g= 0;
con_supplier_sellCap_low(supplier)..               - sum((region), quantities_sold(supplier, region)) =g= 0;
con_supplier_sellCap_up(supplier)..                sum((region), quantities_sold(supplier, region)) - quantities_prod(supplier) =g= 0;
con_supplier_prodCap_low(supplier)..               - quantities_prod(supplier) =g= 0;
con_supplier_prodCap_up(supplier)..                (quantities_prod(supplier) - ProductionCap(supplier)) =g= 0;
*overall
balanceEqu(region)..                            sum((supplier), quantities_sold(supplier, region)) - quantities_demand(region) =e= 0;

model cournot /
balanceEqu.price,

maxConsumer.quantities_demand,
con_consumer_low.Mu_de_low,
con_consumer_up.Mu_de_up,

maxSupplier_q_sell.price,
maxSupplier_q_prod.quantities_prod,
con_supplier_transCap_low.mu_transCap_low,
con_supplier_transCap_up.mu_transCap_up,
con_supplier_sellCap_low.mu_sellCap_low,
con_supplier_sellCap_up.mu_sellCap_up,
con_supplier_prodCap_low.mu_prodCap_low,
con_supplier_prodCap_up.mu_prodCap_up
/;

Solve cournot using mcp;