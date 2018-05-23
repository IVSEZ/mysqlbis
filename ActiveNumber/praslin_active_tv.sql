select 

period, clientid, contractid, clientcode, contractcode, 
contractdate,
contractstartdate,
contractenddate,
clientname,SERVICECATEGORY,SERVICETYPE,price, clientclass, clienttype, activecount, DEVICESCOUNT

-- *
 from rcbill_my.dailyactivenumber
where
region='Praslin'
and period='2017-06-29'
and reported='Y'
and servicecategory='TV'
-- and clienttype='Residential'

order by clientname
;


select 

period, clientname, clientcode, count(CONTRACTCODE) as contract_count

-- *
 from rcbill_my.dailyactivenumber
where
region='Praslin'
and period='2017-06-25'
and reported='Y'
and servicecategory='TV'
and clienttype='Residential'

group by period, clientname, clientcode
order by 4 desc
;


select distinct servicetype, price
from 
rcbill_my.dailyactivenumber
where
-- region='Praslin'
 period='2017-06-25'
and reported='Y'
-- and servicecategory='TV'
-- and clienttype='Residential'
and price<>0
group by servicetype, price
;

select sum(activecount) as activecount, sum(devicescount) as devicecount
from 
rcbill_my.dailyactivenumber
where
period='2017-06-29'
and
reported='Y' 
and 
region='Praslin'
;