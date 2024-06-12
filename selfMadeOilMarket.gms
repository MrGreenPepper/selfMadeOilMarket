Sets

consumer                /d1*d2/
supplier                /s1*s2/
;


Parameter
                           
costs(supplier)                     /s1 10, s2 20/
baseUtility(consumer)               /d1 10, d2 20/
maxConsumption                      /d1 100, d2 200/
maxProduction                       /s1 100, s2 200/
;


Variables

quantities_d(consumer)
consumerSurplus(consumer)
Mu_de_low(consumer)
Mu_de_up(consumer)

quantities_s(supplier)
supplierSurplus(supplier)
Mu_su_low(supplier)
Mu_su_up(supplier)

price
;

Mu_de_low.lo(consumer)  = 0;
Mu_de_up.lo(consumer)  = 0;
Mu_su_low.lo(supplier)  = 0;
Mu_su_up.lo(supplier)  = 0;


Equations

*demand
maxConsumer(consumer)
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
maxConsumer(consumer)..                     price - consumerSurplus(consumer) - Mu_de_low(consumer) + Mu_de_up(consumer) =e= 0;
con_consumer_low(consumer)..                quantities_d(consumer) =g= 0;
con_consumer_up(consumer)..                 maxConsumption(consumer) - quantities_d(consumer) =g= 0;

*supplier
maxSupplier(supplier)..                     0 =e= costs(supplier) - price -Mu_su_low(supplier) + Mu_su_up(supplier);
con_supplier_low(supplier)..                quantities_s(supplier) =g= 0;
con_supplier_up(supplier)..                 maxProduction(supplier) - quantities_s(supplier) =g= 0;

*overall
balanceEqu..                                sum((consumer), quantities_d(consumer)) - sum((supplier), quantities_s(supplier)) =e= 0;

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