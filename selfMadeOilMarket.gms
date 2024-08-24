$include testData.gms
*$include realData.gms

Positive Variable



quantities_sold(supplier, region)
quantities_prod(supplier)         

mu_transCap

mu_prodCap

price(region)

;


Variable
mu_massBal
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
con_supplier_transCap
con_supplier_massBal
con_supplier_prodCap
*overall
*balanceEqu
price_EQ
;                           

*supplier
* profit = -(q_sold * price)
* profit = -price
*(MaxConsumption(region) + SlopeDemand(region) * sum(regionB, quantities_sold(regionB, region)))

maxSupplier_q_sell(supplier, region)..          (TransportationCosts(supplier, region) - price(region))
                                                + mu_transCap(supplier, region)
                                                + mu_massBal(supplier) =e= 0;
                                               

                                                
maxSupplier_q_prod(supplier)..                  ProductionCosts(supplier)
                                                - mu_massBal(supplier)
                                                + mu_prodCap(supplier)
                                                =e= 0;

*transCap                                      

con_supplier_transCap(supplier, region)..      TransportationCap(supplier, region) - quantities_sold(supplier,region) =g= 0;

*massBal
con_supplier_massBal(supplier)..               quantities_prod(supplier) - sum((region), quantities_sold(supplier, region)) =e= 0;

*prodCap
con_supplier_prodCap(supplier)..               ProductionCap(supplier) - quantities_prod(supplier)=g= 0;

*overall
*balanceEqu(region)..                            sum((supplier), quantities_sold(supplier, region)) - quantities_demand(region) =e= 0;
price_EQ(region)..                              price(region) =e= MaxConsumption(region) + (SlopeDemand(region) * sum(supplier, quantities_sold(supplier, region)));
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
con_supplier_transCap.mu_transCap,
*sellCap
con_supplier_massBal.mu_massBal,
*prodCap
con_supplier_prodCap.mu_prodCap

/;
Solve cournot using mcp;
display price.l, quantities_sold.l;