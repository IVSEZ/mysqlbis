use rcbill_my;

select * from rcbill_my.anreport where period in (@rundate) and reported='Y' and decommissioned='N' and package='Crimson';


select servicecategory2
-- , servicesubcategory
, package
-- , clientclass
, sum(open_s) as opencontracts, sum(new_s) as newcontracts
, sum(newc_s) as newconverted, sum(renew_s) as renewed, sum(closed_s) as closed, sum(closednon_s) as closednonpayment
, sum(suspended_s) as suspended, sum(closedcon_s) as closedconverted, sum(closedoth_s) as closedother
, sum(totopn_s) as totalopened, sum(totcld_s) as totalclosed, sum(diff_s) as difference

from 
rcbill_my.anreport  where period in (@rundate) and reported='Y' and decommissioned='N' 
-- and servicecategory='Internet'

group by servicecategory2
-- , servicesubcategory
, package
-- , clientclass
with rollup
;


select 
clientclass
, servicecategory2
-- , servicesubcategory
, package

, sum(open_s) as opencontracts, sum(new_s) as newcontracts
, sum(newc_s) as newconverted, sum(renew_s) as renewed, sum(closed_s) as closed, sum(closednon_s) as closednonpayment
, sum(suspended_s) as suspended, sum(closedcon_s) as closedconverted, sum(closedoth_s) as closedother
, sum(totopn_s) as totalopened, sum(totcld_s) as totalclosed, sum(diff_s) as difference

from 
rcbill_my.anreport  where period in (@rundate) and reported='Y' and decommissioned='N' 
-- and servicecategory='Internet'

group by 
 clientclass
,servicecategory2
-- , servicesubcategory
, package
with rollup
;


set @cc='Residential';
set @pk='Extravagance';

select 
period
, rcbill_my.GetWeekdayName(weekday(period)) as weekday 
, clientclass
, servicecategory2
-- , servicesubcategory
, package
-- , sum(open_s) as totalactive
, sum(totopn_s) as totalopened, sum(totcld_s) as totalclosed

from 
rcbill_my.anreport  
where 
-- period in (@rundate) and 
reported='Y' 
and 
decommissioned='N' 
-- and servicecategory='Internet'
and
clientclass=@cc
and
package=@pk
group by 
period, 
clientclass
, servicecategory2
-- , servicesubcategory
, package
;


SET @rundate1='2017-03-24';
SET @rundate2='2017-10-10';

select period
-- , clientclass, servicecategory
, package
, sum(open_s) as opencontracts, sum(new_s) as newcontracts
, sum(newc_s) as newconverted, sum(renew_s) as renewed, sum(closed_s) as closed, sum(closednon_s) as closednonpayment
, sum(suspended_s) as suspended, sum(closedcon_s) as closedconverted, sum(closedoth_s) as closedother
, sum(totopn_s) as totalopened, sum(totcld_s) as totalclosed, sum(diff_s) as difference

from 
rcbill_my.anreport  where 
(period>=@rundate1 and period<=@rundate2) and reported='Y' and decommissioned='N' 
and package='Crimson'
group by 
-- clientclass
-- ,servicecategory2
-- , servicesubcategory
 package
, period
-- with rollup
-- order by period

;
