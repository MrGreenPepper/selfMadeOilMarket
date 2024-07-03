


$include testData_stckl.gms
*$include realData_stckl.gms



*total cost per unit of oil
cost(supplier, consumer) = prod_cost(supplier)   + TransportationCosts(supplier, consumer);


Variable

mminus_profit_leader profit of the leader
p(consumer) regional marginal price
mminus_profit_follower(follower)
;


Positive Variables
d(consumer) demand
qf(follower, consumer) quantity sold by follower 
ql(leader, consumer) quantity sold by leader
q_sold(consumer) sum of qty sold by leader and consumer
;

Positive Variables
*duals
d_min(consumer)
d_max(consumer)
qf_min(follower, consumer)
qf_max(follower, consumer)
ql_min(leader, consumer)
ql_max(leader, consumer)
;

Binary Variables
u_d_min(consumer)
u_d_max(consumer)
u_qf_min(follower, consumer)
u_qf_max(follower, consumer)
u_ql_min(leader, consumer)
u_ql_max(leader, consumer)
;

Scalars
*big Ms
m1_d_min /1e4/
m1_d_max /1e4/
m1_qf_min /1e4/
m1_qf_max /1e4/
m1_ql_min /1e4/
m1_ql_max /1e4/
m2_d_min /1e5/
m2_d_max/1e5/
m2_qf_min /1e5/
m2_qf_max /1e5/
m2_ql_min /1e5/
m2_ql_max /1e5/
;




Equations
*objective function
of
*upper level contraints
production_cap_l(leader)
production_cap_f(follower)


*langarangian equilibrium equations for followers and consumer
leaderEqu(leader, consumer)
followerEqu(follower, consumer)
consumerEqu(consumer)

*overall
price(consumer)
balanceEqu(consumer)

*constrains, 3 variables, 6 duals, 6 complimentarity constraints, 12 linear contraints
eq1_d_min(consumer)
eq1_d_max(consumer)
eq1_qf_min(follower, consumer)
eq1_qf_max(follower, consumer)
eq1_ql_min(leader, consumer)
eq1_ql_max(leader, consumer)
eq2_d_min(consumer)
eq2_d_max(consumer)
eq2_qf_min(follower, consumer)
eq2_qf_max(follower, consumer)
eq2_ql_min(leader, consumer)
eq2_ql_max(leader, consumer)

*profit follower
*profit_follower(follower)
;                           


*overall balance
balanceEqu(consumer)..                d(consumer)-sum(leader,ql(leader, consumer)) - sum(follower, qf(follower, consumer))=e=0;
price(consumer)..           p(consumer) =e=  INT(consumer)+SLP(consumer)*d(consumer);

*leader's negative profit (note that this is not langarangain)

of..      mminus_profit_leader =e= sum((leader, consumer), cost(leader, consumer)*ql(leader, consumer) - p(consumer)*ql(leader, consumer));

*upper level contraints
production_cap_l(leader).. sum(consumer, ql(leader, consumer))=l= ProductionCap(leader);
production_cap_f(follower).. sum(consumer, qf(follower, consumer))=l= ProductionCap(follower);


*langarangian equlibrium constraints
leaderEqu(leader, consumer).. cost(leader, consumer) - p (consumer) -ql_min(leader, consumer)+ql_max(leader, consumer)=e=0;
followerEqu(follower, consumer).. cost(follower, consumer) - p (consumer) -qf_min(follower, consumer)+qf_max(follower, consumer)=e=0;
consumerEqu(consumer).. p(consumer)-baseUtility(consumer)+d_max(consumer)- d_min(consumer)=e=0;

*now the constraints
*primals
eq1_d_min(consumer).. d(consumer) =l= u_d_min(consumer)*m1_d_min;
eq1_d_max(consumer)..maxConsumption(consumer) - d(consumer) =l= u_d_max(consumer)*m1_d_max;
eq1_qf_min(follower, consumer)..qf(follower, consumer) =l= u_qf_min(follower,consumer)*m1_qf_min;
eq1_qf_max(follower, consumer)..TransportationCap(follower, consumer)-qf(follower, consumer)=l=u_qf_max(follower, consumer)*m1_qf_max;
eq1_ql_min(leader, consumer)..ql(leader, consumer) =l= u_ql_min(leader,consumer)*m1_qf_min;
eq1_ql_max(leader, consumer)..TransportationCap(leader, consumer)-ql(leader, consumer)=l=u_ql_max(leader, consumer)*m1_ql_max;
*duals
eq2_d_min(consumer).. d_min(consumer) =l= (1-u_d_min(consumer))*m2_d_min;
eq2_d_max(consumer)..d_max(consumer)=l= (1-u_d_max(consumer))*m2_d_max;
eq2_qf_min(follower, consumer)..qf_min(follower, consumer) =l=(1-u_qf_min(follower, consumer))*m2_qf_min;
eq2_qf_max(follower, consumer)..qf_max(follower, consumer)=l=(1-u_qf_max(follower, consumer))*m2_qf_max;
eq2_ql_min(leader, consumer)..ql_min(leader, consumer) =l=(1-u_ql_min(leader, consumer))*m2_ql_min;
eq2_ql_max(leader, consumer)..ql_max(leader, consumer)=l=(1-u_ql_max(leader, consumer))*m2_ql_max;


*calculate profit of follower
*profit_follower(follower)..  mminus_profit_follower(follower)=e= sum((consumer), cost(follower, consumer)*qf(follower, consumer) - p(consumer)*qf(follower, consumer));




Model stckl /all/
;

solve stckl using minlp minimising mminus_profit_leader ;



display p.l, ql.l, qf.l, d.l










