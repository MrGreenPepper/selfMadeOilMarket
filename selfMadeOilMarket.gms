$include testData.gms
*$include realData.gms


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

mu_transCap_low
mu_transCap_up

mu_sellCap

mu_prodCap_low
mu_prodCap_up

price(region)

;

Mu_de_low.lo(region)  = 0;
Mu_de_up.lo(region)  = 0;

mu_transCap_low.lo(supplier, region)  = 0;
mu_transCap_up.lo(supplier, region)  = 0;

mu_prodCap_low.lo(supplier)  = 0;
mu_prodCap_up.lo(supplier)  = 0;


Variable
mu_sellCap

;
Equations


*demand
$onText
maxConsumer
con_consumer_low
con_consumer_up
$offText

*supplier
maxSupplier_q_sell
maxSupplier_q_prod
con_supplier_transCap_low(supplier, region)
con_supplier_transCap_up(supplier, region)

con_supplier_sellCap(supplier)

con_supplier_prodCap_low(supplier)
con_supplier_prodCap_up(supplier)

*overall
*balanceEqu
price_EQ
;                           

*demand
$onText
maxConsumer(region)..                           price(region) - baseUtility(region) + Mu_de_low(region) - Mu_de_up(region) =e= 0;
con_consumer_low(region)..                      quantities_demand(region) =g= 0;
con_consumer_up(region)..                       MaxConsumption(region) - quantities_demand(region) =g= 0;
$offText
*supplier

maxSupplier_q_sell(supplier, region)..          (TransportationCosts(supplier, region)-price(region))
                                                + mu_transCap_low(supplier, region)
                                                - mu_transCap_up(supplier, region)
                                                + mu_sellCap(supplier)
                                                =e= 0;
                                                
maxSupplier_q_prod(supplier)..                  ProductionCosts(supplier)
                                                -mu_sellCap(supplier)
                                                +mu_prodCap_low(supplier)
                                                -mu_prodCap_up(supplier)
                                                =e= 0;

*transCap                                      
con_supplier_transCap_low(supplier, region)..     quantities_sold(supplier,region) =g= 0;
con_supplier_transCap_up(supplier, region)..      TransportationCap(supplier, region) - quantities_sold(supplier,region) =g= 0;

*sellCap
con_supplier_sellCap(supplier)..                    quantities_prod(supplier) - sum((region), quantities_sold(supplier, region)) =g= 0;

*prodCap
con_supplier_prodCap_low(supplier)..              quantities_prod(supplier) =g= 0;
con_supplier_prodCap_up(supplier)..               ProductionCap(supplier) - quantities_prod(supplier)=g= 0;

*overall
*balanceEqu(region)..                            sum((supplier), quantities_sold(supplier, region)) - quantities_demand(region) =e= 0;
price_EQ(region)..                              price(region) =e= (SlopeDemand(region)*sum(supplier, quantities_sold(supplier, region))) / MaxConsumption(region);  
model cournot /
*balanceEqu.price,
price_EQ.price,
*demand
$onText
maxConsumer.quantities_demand,
con_consumer_low.Mu_de_low,
con_consumer_up.Mu_de_up,
$offText
*supplier
maxSupplier_q_sell.quantities_sold,
maxSupplier_q_prod.quantities_prod,
*transCap 
con_supplier_transCap_low.mu_transCap_low,
con_supplier_transCap_up.mu_transCap_up,
*sellCap

con_supplier_sellCap.mu_sellCap,
*prodCap
con_supplier_prodCap_low.mu_prodCap_low,
con_supplier_prodCap_up.mu_prodCap_up
/;

Solve cournot using mcp;