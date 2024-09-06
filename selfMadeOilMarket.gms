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
*some data
profit(supplier)
total_profit
wellfare
totalWellfare
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
*some data
profit_EQ
total_profit_EQ


*competitiive market
wellfareDemand_EQ
totalwellfare_EQ
;                           

*supplier
* profit = -(q_sold * price)
* profit = -price
*(MaxConsumption(region) + SlopeDemand(region) * sum(regionB, quantities_sold(regionB, region)))

maxSupplier_q_sell(supplier, region)..          (-2*SlopeDemand(region)*sum(consumer, quantities_sold(consumer, region))-MaxConsumption(region)+TransportationCosts(supplier, region))
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
price_EQ(region)..                              price(region) =e= MaxConsumption(region) + (SlopeDemand(region) * sum(supplier, quantities_sold(supplier, region)));


*some data
profit_EQ(supplier)..                           profit(supplier) =e= sum(region, quantities_sold(supplier, region) * (price(region) - TransportationCosts(supplier, region))) -  quantities_prod(supplier) * ProductionCosts(supplier);
total_profit_EQ..                               total_profit =e=  sum(supplier, profit(supplier));

*competitiive market
wellfareDemand_EQ(consumer)..                   wellfare(consumer) =e= 0.5 * (MaxConsumption(consumer) - price(consumer)) * sum(supplier, quantities_sold(supplier, consumer));
totalwellfare_EQ..                              totalWellfare =e= sum(consumer, wellfare(consumer)) + sum(supplier, profit(supplier));


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
con_supplier_prodCap.mu_prodCap,


*some data
profit_EQ,
total_profit_EQ
wellfareDemand_EQ,
totalwellfare_EQ
/;
Solve cournot using mcp;
display price.l, quantities_sold.l, profit.l,  total_profit.l, wellfare.l;



*maximize suppliers profit
model maxProducer /

price_EQ,

profit_EQ,
total_profit_EQ
wellfareDemand_EQ,
totalwellfare_EQ

*transCap 
con_supplier_transCap,
*sellCap
con_supplier_massBal,
*prodCap
con_supplier_prodCap
/;


Solve maxProducer using nlp maximizing total_profit;
display price.l, quantities_sold.l,profit.l, total_profit.l, wellfare.l;


*maximize overall wellfare
model maxWellfare /

price_EQ,

profit_EQ,
total_profit_EQ
wellfareDemand_EQ,
totalwellfare_EQ


*transCap 
con_supplier_transCap,
*sellCap
con_supplier_massBal,
*prodCap
con_supplier_prodCap,

/;

Solve maxWellfare using nlp maximizing totalWellfare;
display price.l, quantities_sold.l,profit.l, total_profit.l, wellfare.l;

