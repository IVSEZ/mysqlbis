
select period, network, servicecategory, count(distinct clientcode) as client, count(distinct contractcode) as contracts, sum(activecount) as activecount
from 
rcbill_my.customercontractactivity 
where 
period in ('2017-09-30','2017-10-31','2017-11-30','2017-12-31','2018-01-31','2018-02-28','2018-03-31','2018-04-30','2018-04-30')
group by 
period, network, servicecategory
order by period, servicecategory
;

