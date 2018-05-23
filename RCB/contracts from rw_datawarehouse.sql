select * from rcbill.rcb_casa limit 1000;

select count(*) from rcbill.clientcontracts;

select * from rcbill.clientcontracts limit 1000;

select vpnr_servicetype, count(*), month(con_contractdate), year(con_contractdate) from rcbill.clientcontracts where S_SERVICENAME in ('SUBSCRIPTION CAPPED GNET','SUBSCRIPTION CAPPED INTERNET') 
-- and ( month(con_contractdate) = 3 and year(con_contractdate) = 2017)
and ( year(con_contractdate) = 2017)
group by vpnr_servicetype, month(con_contractdate), year(con_contractdate)
-- with rollup
limit 1000;
