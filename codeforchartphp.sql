use rcbill_my;

select mthname as Month, 
-- periodyear, 
(sum(open) / day(LAST_DAY(period)) ) as open_a
from rcbill_my.activenumber
where 
decommissioned = 'N'
and
reported = 'Y'
group by
mthname,
periodyear
order by periodyear, periodmth;


select period
, periodday
, periodmth
, periodyear
, sum(open) as activecount 
, servicecategory
, servicesubcategory
, clientclass
, clienttype
, region
from activenumber 
where reported='Y' and decommissioned='N'
-- and period='2017-02-21'
-- and clienttype='Residential'
group by period, periodday, periodmth, periodyear, servicecategory, servicesubcategory, clientclass, clienttype, region
order by period, periodday, periodmth, periodyear, servicecategory, servicesubcategory, clientclass, clienttype, region
;


select period, periodday, periodmth, periodyear, sum(open) as activecount  
from 
activenumber
where reported='Y' and decommissioned='N'
group by 
period, periodday, periodmth, periodyear
order by period, periodday, periodmth, periodyear
;

select period, periodday, periodmth, periodyear, servicecategory, sum(open) as activecount  
from 
activenumber
where reported='Y' and decommissioned='N'
and servicecategory='Internet'
group by period, periodday, periodmth, periodyear, servicecategory
order by period, periodday, periodmth, periodyear, servicecategory
;


select period, periodday, periodmth, periodyear, sum(open) as activecount  
from 
activenumber
where reported='Y' and decommissioned='N'
and servicecategory='Internet'
group by period, periodday, periodmth, periodyear
order by period, periodday, periodmth, periodyear
;


select period, periodday, periodmth, periodyear, servicecategory, sum(open) as activecount  
from 
activenumber
where reported='Y' and decommissioned='N'
and servicecategory='TV'
group by 
period, periodday, periodmth, periodyear, servicecategory
order by period, periodday, periodmth, periodyear, servicecategory
;


select period, periodday, periodmth, periodyear, servicecategory, sum(open) as activecount  
from 
activenumber
where reported='Y' and decommissioned='N'
and servicecategory='Voice'
group by 
period, periodday, periodmth, periodyear, servicecategory
order by period, periodday, periodmth, periodyear, servicecategory
;

use rcbill_my;

select * from activenumber limit 100;

SET @sql = NULL;
set @startdate = '2017-01-01';
set @enddate = '2017-01-01';
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'sum(CASE WHEN month(period) = ',
      month(period),
      ' THEN open else 0 END) AS `open_count',
      monthname(period), '`'
    )
  ) INTO @sql
FROM activenumber
where period >= @startdate
 and period <= @enddate;

SET @sql 
  = CONCAT('SELECT servicetype, ', @sql, ' 
            from activenumber
            where period >= ''',  @startdate, ''' 
               and period <= ''', @enddate, ''' 
            group by servicetype');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


select servicetype,
  sum(case when day(period) = 1 then open else 0 end) opencount_Jan,
  sum(case when day(period) = 2 then open else 0 end) opencount_Feb,
  sum(case when day(period) = 3 then open else 0 end) opencount_Mar
from activenumber
where period >= '2017-01-01'
  and period <= '2017-01-03'
group by servicetype;



SELECT 
mthname,
periodyear,
servicecategory, 
-- servicesubcategory,
baseservice,
servicetype,
-- reported,
-- decommissioned,

clientclass,
clienttype,
region,
sum(open) as open_s,
(sum(open) / day(LAST_DAY(period)) ) as open_a,

/*
sum(new) as new_s,
(sum(new) / day(LAST_DAY(period)) ) as new_a,

sum(newconverted) as newc_s,
(sum(newconverted) / day(LAST_DAY(period)) ) as newc_a,

sum(renew) as renew_s,
(sum(renew) / day(LAST_DAY(period)) ) as renew_a,

sum(closed) as closed_s,
(sum(closed) / day(LAST_DAY(period)) ) as closed_a,

sum(closednonpayment) as closednon_s,
(sum(closednonpayment) / day(LAST_DAY(period)) ) as closednon_a,

sum(suspended) as suspended_s,
(sum(suspended) / day(LAST_DAY(period)) ) as suspended_a,

sum(closedconverted) as closedcon_s,
(sum(closedconverted) / day(LAST_DAY(period)) ) as closedcon_a,

sum(closedother) as closedoth_s,
(sum(closedother) / day(LAST_DAY(period)) ) as closedoth_a,
*/
sum(totalopened) as totopn_s,
(sum(totalopened) / day(LAST_DAY(period)) ) as totopn_a,

sum(totalclosed) as totcld_s,
(sum(totalclosed) / day(LAST_DAY(period)) ) as totcld_a

/*
sum(difference) as diff_s,
(sum(difference) / day(LAST_DAY(period)) ) as diff_a

*/

 FROM rcbill_my.activenumber
 where mthname <> 'February' and periodyear <> '2017'
-- where reported = 'Y' and decommissioned = 'N'
 and
 reported = 'Y' and decommissioned = 'N'
-- mthname = 'October' and periodyear='2016'
group by
-- periodday, servicecategory, servicesubcategory,
-- reported,
-- decommissioned,
servicecategory,
baseservice,
servicetype,
mthname,
periodyear,
clientclass,
clienttype,
region

order by
periodyear,
periodmth

;

-- TV

SELECT 
mthname,
periodyear,
servicecategory, 
baseservice,
servicetype,
clientclass,
clienttype,
region,
-- sum(open) as open_s,
(sum(open) / day(LAST_DAY(period)) ) as open_a


 FROM rcbill_my.activenumber
 where (mthname <> 'February' and periodyear <> '2017')
 and
 reported = 'Y' and decommissioned = 'N'
 and
 servicecategory='TV'
-- mthname = 'October' and periodyear='2016'
group by
mthname,
periodyear,
servicecategory,
baseservice,
servicetype,

clientclass,
clienttype,
region

order by
periodyear,
periodmth
;

SELECT 
mthname,
periodmth,
periodyear,
servicecategory, 
-- baseservice,
servicetype,
-- clientclass,
 clienttype,
-- region,
-- sum(open) as open_s,
(sum(open) / day(LAST_DAY(period)) ) as open_a


 FROM rcbill_my.activenumber
 where (mthname <> 'February' and periodyear <> '2017')
 and
 reported = 'Y' and decommissioned = 'N'
 and
 servicecategory='TV'
-- mthname = 'October' and periodyear='2016'
group by
mthname,
periodmth,
periodyear,
servicecategory,
-- baseservice,
servicetype,

-- clientclass,
 clienttype
-- region

order by
periodyear,
periodmth
;
