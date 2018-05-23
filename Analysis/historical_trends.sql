-- select * from rcbill_my.rescustomersactivity;

-- set @fieldname = `activenos`;

select periodday as dy, periodmth as mth, sum(`2016`) as `2016`, sum(`2017`) as `2017`
from 
(
select periodday, periodmth, 
case when periodyear = 2016 then activenos end as `2016`,
case when periodyear = 2017 then activenos end as `2017`
from 
rcbill_my.rescustomersactivity
) a
group by 1,2
order by 2,1
;



select wday, newperiodday as dy, newperiodmth as mth, sum(`2016`) as `2016`, sum(`2017`) as `2017`
from 
(
select wday, newperiodday, newperiodmth, 
case when newperiodyear = 2016 then activenos end as `2016`,
case when newperiodyear = 2017 then activenos end as `2017`
from 
rcbill_my.rescustomersactivity


) a
group by 1,2,3
order by 3,2
;


##########################################################################################
-- openednos


select periodday as dy, periodmth as mth, sum(`2016`) as `2016`, sum(`2017`) as `2017`
from 
(
select periodday, periodmth, 
case when periodyear = 2016 then openednos end as `2016`,
case when periodyear = 2017 then openednos end as `2017`
from 
rcbill_my.rescustomersactivity
) a
group by 1,2
order by 2,1
;



select wday, newperiodday as dy, newperiodmth as mth, sum(`2016`) as `2016`, sum(`2017`) as `2017`
from 
(
select wday, newperiodday, newperiodmth, 
case when newperiodyear = 2016 then openednos end as `2016`,
case when newperiodyear = 2017 then openednos end as `2017`
from 
rcbill_my.rescustomersactivity


) a
group by 1,2,3
order by 3,2
;


##########################################################################################
-- closednos


select periodday as dy, periodmth as mth, sum(`2016`) as `2016`, sum(`2017`) as `2017`
from 
(
select periodday, periodmth, 
case when periodyear = 2016 then closednos end as `2016`,
case when periodyear = 2017 then closednos end as `2017`
from 
rcbill_my.rescustomersactivity
) a
group by 1,2
order by 2,1
;



select wday, newperiodday as dy, newperiodmth as mth, sum(`2016`) as `2016`, sum(`2017`) as `2017`
from 
(
select wday, newperiodday, newperiodmth, 
case when newperiodyear = 2016 then closednos end as `2016`,
case when newperiodyear = 2017 then closednos end as `2017`
from 
rcbill_my.rescustomersactivity


) a
group by 1,2,3
order by 3,2
;
