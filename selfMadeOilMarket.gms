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



price(region)

;


Variable
profit(supplier)
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

con_supplier_transCap_low(supplier, region)
con_supplier_transCap_up(supplier, region)

con_supplier_sellCap_low(supplier)
con_supplier_sellCap_up(supplier)

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

maxSupplier_q_sell(supplier)..                  sum(region, quantities_sold(supplier, region)*(TransportationCosts(supplier, region)-price(region)))
                                                - ProductionCosts(supplier) + quantities_prod(supplier)
                                                =e= profit(supplier);
                                                


*transCap                                      
con_supplier_transCap_low(supplier, region)..       quantities_sold(supplier,region) =g= 0;
con_supplier_transCap_up(supplier, region)..        TransportationCap(supplier, region) - quantities_sold(supplier,region) =g= 0;

*sellCap
con_supplier_sellCap_low(supplier)..                sum((region), quantities_sold(supplier, region))=g= 0;
con_supplier_sellCap_up(supplier)..                 quantities_prod(supplier) - sum((region), quantities_sold(supplier, region)) =g= 0;

*prodCap
con_supplier_prodCap_low(supplier)..                quantities_prod(supplier) =g= 0;
con_supplier_prodCap_up(supplier)..                 ProductionCap(supplier) - quantities_prod(supplier)=g= 0;

*overall
*balanceEqu(region)..                               sum((supplier), quantities_sold(supplier, region)) - quantities_demand(region) =e= 0;
price_EQ(region)..                                  price(region) =e= MaxConsumption(region) + (SlopeDemand(region)*sum(supplier, quantities_sold(supplier, region))) ;  
model cournot / all /;

File myinfo /'%emp.info%'/;
put myinfo 'equilibrium';
loop(supplier,
   put / 'min', profit(supplier), 
   loop(region, put quantities_sold(supplier, region));
   put  price(supplier), quantities_prod(supplier), maxSupplier_q_sell(supplier), con_supplier_sellCap_low(supplier), con_supplier_sellCap_up(supplier), con_supplier_prodCap_low(supplier), con_supplier_prodCap_up(supplier)
   loop(region, put con_supplier_transCap_up(supplier, region), con_supplier_transCap_low(supplier, region));
   put price_EQ(supplier)
);
putclose myinfo;

solve cournot using EMP;