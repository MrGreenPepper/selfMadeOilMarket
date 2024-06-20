Sets

region                   /r1*r3/
consumer(region)         /r1*r2/
supplier(region)         /r2*r3/

alias(region,regionB)
;





Parameter 
baseUtility(region)                     /r1  600, r2  60, r3 0/
maxConsumption(region)                  /r1  100, r2  200, r3 100/
               
ProductionCosts(supplier)               /r2  10, r3  15/
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
r2  100     100     100
r3  50      100     150
;

Variable

consumerSurplus(region)
supplierSurplus(supplier)
surplus
;
Positive Variable
transport(region, regionB)
*is supplier here necessary?

quantities_demand(region)
quantities_sold(supplier, region)
quantities_prod(supplier)         



price(region)
;




Equations



*demand
maxConsumer
con_consumer

*supplier
maxSupplier_q_sell
*maxSupplier_q_prod
con_supplier_transCap_low(supplier, region)
con_supplier_transCap_up(supplier, region)
con_supplier_sellCap_low(supplier)
con_supplier_sellCap_up(supplier)
con_supplier_prodCap_low(supplier)
con_supplier_prodCap_up(supplier)

*overall
balanceEqu
surplus_eq
;                           

*demand
maxConsumer(region)..                           quantities_demand(region) * (price(region) - baseUtility(region)) =e= consumerSurplus(region);
con_consumer(region)..                          maxConsumption(region) =g= quantities_demand(region);

*supplier

maxSupplier_q_sell(supplier)..                      sum((region),(TransportationCosts(supplier, region)-price(region))*quantities_sold(supplier,region))
                                                    + ProductionCosts(supplier) * quantities_prod(supplier)
                                                    =e= supplierSurplus(supplier);


*transCap                                      
con_supplier_transCap_up(supplier, region)..        TransportationCap(supplier, region) =g= quantities_sold(supplier,region);
*sellCap
con_supplier_sellCap_up(supplier)..                 quantities_prod(supplier) =g= sum((region), quantities_sold(supplier, region));
*prodCap
con_supplier_prodCap_up(supplier)..                 ProductionCap(supplier) =g= quantities_prod(supplier);

*overall
balanceEqu(region)..                                sum((supplier), quantities_sold(supplier, region)) - quantities_demand(region) =e= 0;
surplus_eq..                                        surplus =e= sum((supplier),supplierSurplus(supplier)) + sum((region),consumerSurplus(region));
$onText
model cournot /
balanceEqu.price,
*demand
maxConsumer.quantities_demand,
con_consumer_low.Mu_de_low,
con_consumer_up.Mu_de_up,
*supplier
maxSupplier_q_sell.quantities_sold,
maxSupplier_q_prod.quantities_prod,
*transCap 
con_supplier_transCap_low.mu_transCap_low,
con_supplier_transCap_up.mu_transCap_up,
*sellCap
con_supplier_sellCap_low.mu_sellCap_low,
con_supplier_sellCap_up.mu_sellCap_up,
*prodCap
con_supplier_prodCap_low.mu_prodCap_low,
con_supplier_prodCap_up.mu_prodCap_up
/;

Solve cournot using mcp;
$offText


model cournot /
surplus_eq,
balanceEqu,
*demand
maxConsumer,
con_consumer,
*supplier
maxSupplier_q_sell
con_supplier_transCap_up,
con_supplier_sellCap_up,
con_supplier_prodCap_up,
/;
File info / '%emp.info%' /;
putclose info / 'modeltype mcp';

solve cournot using EMP minimizing surplus;