select count(*) from rcbill_my.customercontractactivity;

select * from rcbill_my.customercontractactivity limit 100;


select period, periodday, periodmth, periodyear, clientcode, clientname,clientclass, contractcode, servicecategory2, servicesubcategory,package,price,activecount
from rcbill_my.customercontractactivity
where clientclass in ('Residential','Corporate Bulk', 'Corporate Bundle','Corporate Lite','Standing Order')
and reported='Y'
and periodmth=9
and PERIODYEAR=2017
;

select distinct clientclass,clienttype from 
rcbill_my.customercontractactivity;


select period, periodday, periodmth, periodyear, clientcode, clientname,clientclass, contractcode, servicecategory2, servicesubcategory,package,price,activecount,(price/30) as dailyrevenue
from rcbill_my.customercontractactivity
where 
clientclass in ('Residential','Corporate Bulk', 'Corporate Bundle','Corporate Lite','Standing Order')
and reported='Y'
 and periodmth=9
 and PERIODYEAR=2017
-- and clientcode='I.000000485'

;

select period, periodday, periodmth, periodyear, clientclass, servicecategory2, servicesubcategory,package, sum(price) as price, sum(activecount) as activecount, sum((price/30)) as dailyrevenue
from rcbill_my.customercontractactivity
where 
clientclass in ('Residential','Corporate Bulk', 'Corporate Bundle','Corporate Lite','Standing Order')
and reported='Y'
 and periodmth=9
 and PERIODYEAR=2017
group by period, periodday, periodmth, periodyear, clientclass, servicecategory2, servicesubcategory,package;

select period, periodday, periodmth, periodyear, clientcode, clientname,clientclass, contractcode, servicecategory2, servicesubcategory,package,price,activecount,(price/30) as dailyrevenue
from rcbill_my.customercontractactivity
where 
clientclass in ('Residential','Corporate Bulk', 'Corporate Bundle','Corporate Lite','Standing Order')
and
servicecategory2='Internet - Capped' and servicesubcategory='GPON' and package='10GB' and reported='Y'
 and periodmth=9
 and PERIODYEAR=2017
 ;



select * from rcbill_my.customercontractactivity where clientcode='I.000011750';

select * from rcbill_my.dailyactivenumber where clientcode='I.000011750' and PREVIOUSSERVICETYPE is not null;

select * from rcbill_my.customercontractactivity where periodday=15 and periodmth=8 and PERIODYEAR=2017 and reported='Y';

select clientclass, servicecategory2, package, count(*) from 
rcbill_my.customercontractactivity where periodday=15 and periodmth=8 and PERIODYEAR=2017 and reported='Y' and servicecategory='Internet'
group by clientclass, servicecategory2, package;


select clientclass, servicecategory2, package, count(*) from 
rcbill_my.customercontractactivity where periodday=15 and periodmth=9 and PERIODYEAR=2017 and reported='Y' and servicecategory='Internet'
group by clientclass, servicecategory2, package;


select period, periodday, periodmth, periodyear, clientname, clientcode, contractcode, clientclass, servicecategory2, package
from 
rcbill_my.customercontractactivity where (periodday =15 and periodmth in (8,9) and PERIODYEAR=2017 and reported='Y' and servicecategory='Internet')
order by clientcode, contractcode, periodmth
;
