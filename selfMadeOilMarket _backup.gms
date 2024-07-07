$include testData.gms
*$include realData.gms


Positive Variable



quantities_sold(supplier, region)
quantities_prod(supplier)         

mu_transCap
mu_massBal

mu_prodCap


price(region)

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
con_supplier_transCap(supplier, region)

con_supplier_massBal(supplier)

con_supplier_prodCap(supplier)

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

maxSupplier_q_sell(supplier, region)..          0 =e= TransportationCosts(supplier, region)
                                                - (MaxConsumption(region) + SlopeDemand(region) * sum(regionB, quantities_sold(supplier, regionB)))
                                                - SlopeDemand(region) *  quantities_sold(supplier, region)
                                                + mu_transCap(supplier, region) * (quantities_sold(supplier, region) - TransportationCap(supplier, region))
                                                + mu_massBal(supplier) * (quantities_sold(supplier, region) - quantities_prod(supplier))
                                                + mu_prodCap(supplier) * (quantities_prod(supplier) - ProductionCap(supplier));


$onText 
maxSupplier_q_sell(supplier, region)..          0 =e=                                              
                                                TransportationCosts(supplier, region)
                                                - (MaxConsumption(region) + SlopeDemand(region) * sum(regionB, quantities_sold(regionB, region)))
                                                - quantities_sold(supplier, region) * SlopeDemand(region)
                                                + mu_transCap(supplier, region) * (quantities_sold(supplier, region) - TransportationCap(supplier, region))
                                                + mu_massBal(supplier) * (quantities_sold(supplier, region) - quantities_prod(supplier))
                                                + mu_prodCap(supplier) * (quantities_prod(supplier) - ProductionCap(supplier));
                                               
profit =    transCost(region)
            - (IntersectionPoint(region) + slope * \sum q_sell(supplier))
            - q_sell * (slope(region))

$offText
                                                
maxSupplier_q_prod(supplier)..                  ProductionCosts(supplier)
                                                - mu_massBal(supplier)
                                                + mu_prodCap(supplier)
                                                =e= 0;

*transCap                                      

con_supplier_transCap(supplier, region)..      TransportationCap(supplier, region) - quantities_sold(supplier,region) =g= 0;

*massBal
con_supplier_massBal(supplier)..               quantities_prod(supplier) - sum((region), quantities_sold(supplier, region)) =g= 0;

*prodCap
con_supplier_prodCap(supplier)..               ProductionCap(supplier) - quantities_prod(supplier)=g= 0;

*overall
*balanceEqu(region)..                            sum((supplier), quantities_sold(supplier, region)) - quantities_demand(region) =e= 0;
price_EQ(region)..                              price(region) =e= MaxConsumption(region) + SlopeDemand(region) * sum(supplier, quantities_sold(supplier, region));
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