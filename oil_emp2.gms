Set

region                  /r1*r2/
alias(region, regionB)
;


Parameter
Price                   /r1 200, r2 400, r3 300/
ProdCap                 /r1 1300, r2 100, r3 300/
MaxUtility              /r1 800, r2 800, r3 800/                  
demand_q(region)        /r1 1200, r2 200/   
;

Variables
profit(region)
*demand_q(region)
;

Positive Variable
prod_q(region)
sold_q(region, regionB)
;

Equations
profit_EQ
prodCap_EQ
sellCap_EQ
*demand_EQ
balance_EQ(region)
;


profit_EQ(region)..             profit(region) =e= sum(regionB, Price(regionB) * sold_q(region, regionB));

prodCap_EQ(region)..            prod_q(region) =l= ProdCap(region);
*demand_EQ(region)..             demand_q(region) =e= MaxUtility(region) - Price(region);


balance_EQ(region)..            sum(regionB, sold_q(regionB, region)) =l= demand_q(region);
sellCap_EQ(region)..            sum(regionB, sold_q(region, regionB)) =l= ProdCap(region);




Model cournot /profit_EQ, prodCap_EQ, sellCap_EQ, balance_EQ/;


file info / '%emp.info%' /;
put info 'equilibrium' /;

*put 'implicit demand_q demand_EQ' /;
*put 'VIsol balance_EQ ' /;

$onText
loop(region,
    put / 'implicit demand_q(region) demand_EQ(region)';
);
 put / 'VIsol balance_EQ ';
$offText
*put 'implicit demand_q demand_EQ' /; 
loop(region,
    put 'max', profit(region), prod_q(region);
    loop(regionB,
            put sold_q(regionB, region)/; 
    );
    put profit_EQ(region), ProdCap_EQ(region), sellCap_EQ(region), balance_EQ(region)/;
);
putclose info;


solve cournot using emp;