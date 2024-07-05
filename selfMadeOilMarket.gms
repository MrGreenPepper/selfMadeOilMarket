*$include testData.gms
*$include realData.gms


Sets

region                   /r1*r3/
consumer(region)         /r1*r2/
supplier(region)         /r1*r3/

alias(region,regionB)
;





Parameter 
*baseUtility(region)                     /r1  60, r2  60, r3 0/
IntersectionPoint(region)                  /r1  100, r2  150, r3 200/
               
ProductionCosts(supplier)               /r1  8, r2  10, r3  15/
ProductionCap(supplier)                 /r1  50, r2  100, r3 200/
SlopeDemand(region)                     /r1 -1, r2 -1, r3 -1/         
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
r1  1000     100     100
r2  100     1000     100
r3  100      100     1000
;


Positive Variables
transport(region, regionB)
*is supplier here necessary?
Variables
quantities_demand(region)
consumerSurplus(region)
Mu_de_low(region)
Mu_de_up(region)

quantities_sold(supplier, region)
quantities_prod(supplier)         

mu_transCap
mu_prodCap(supplier)


price(region)

;
Variables

mu_massBal(supplier)
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
con_consumer_up(region)..                       IntersectionPoint(region) - quantities_demand(region) =g= 0;
$offText
*supplier
maxSupplier_q_prod(supplier)..                  ProductionCosts(supplier)
                                                +mu_prodCap(supplier)   
                                                -mu_massBal(supplier)
                                                =e= 0;
                                                
maxSupplier_q_sell(supplier, region)..          TransportationCosts(supplier, region)
                                                - IntersectionPoint(region) - 2 * quantities_sold(supplier, region) * SlopeDemand(region)
                                                + mu_transCap(supplier, region)
                                                + mu_massBal(supplier)
                                                =e= 0;

*transCap                                      
con_supplier_transCap(supplier, region)..        TransportationCap(supplier, region) - quantities_sold(supplier,region) =g= 0;

*prodCap
con_supplier_prodCap(supplier)..                 ProductionCap(supplier) - quantities_prod(supplier) =g= 0;

*massBal
con_supplier_massBal(supplier)..                 quantities_prod(supplier) - sum((region), quantities_sold(supplier, region)) =g= 0;


*overall
*balanceEqu(region)..                               sum((supplier), quantities_sold(supplier, region)) - quantities_demand(region) =e= 0;
price_EQ(region)..                                  price(region) =e= IntersectionPoint(region) + (SlopeDemand(region)*sum(supplier, quantities_sold(supplier, region))) ;  
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
*massBal
con_supplier_massBal.mu_massBal,
*prodCap
con_supplier_prodCap.mu_prodCap,

/;

Solve cournot using mcp;