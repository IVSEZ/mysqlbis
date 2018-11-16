select * from rcbill_my.salestoactive;
select * from rcbill_my.salestoactivejourney;


select * from rcbill_my.rep_allcust limit 100;

select o_orderday, o_ordermonth, FirstActiveDateForContract, o_region, o_ordertype , inst_workdays, inst_alldays, o_clientcode, o_contractcode, o_clientclass, o_contracttype
, o_servicetype, ac_clientname, ac_clienttype, ac_network
from 
rcbill_my.salestoactive
where inst_workdays is not null
order by o_orderday
;