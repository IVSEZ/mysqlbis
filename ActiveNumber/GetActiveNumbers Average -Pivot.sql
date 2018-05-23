use rcbill_my;

drop table if exists rcbill_my.activenumberavg;

create table rcbill_my.activenumberavg as
(

SELECT 
-- periodday, 
servicecategory, 
servicesubcategory,
baseservice,
service,
GetServiceCategory2(service) as servicecategory2, 
getcleanstring(servicetypeold) as package,
servicetype,
reported,
decommissioned,
periodmth,
mthname,
periodyear,
clientclass,
clienttype,
region,
sum(open) as open_s,
(sum(open) / day(LAST_DAY(period)) ) as open_a,

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

sum(totalopened) as totopn_s,
(sum(totalopened) / day(LAST_DAY(period)) ) as totopn_a,

sum(totalclosed) as totcld_s,
(sum(totalclosed) / day(LAST_DAY(period)) ) as totcld_a,

sum(difference) as diff_s,
(sum(difference) / day(LAST_DAY(period)) ) as diff_a



 FROM rcbill_my.activenumber
 -- where period not in ('2017-07-03','2017-07-02','2017-07-01')
--  where (mthname <> 'July' and periodyear <> '2017')
-- and
-- reported = 'Y' and decommissioned = 'N'
group by
-- periodday, servicecategory, servicesubcategory,
reported,
decommissioned,
servicecategory,
servicesubcategory,
baseservice,
service,
GetServiceCategory2(service),
package,
servicetype,
periodmth,
mthname,
periodyear,
clientclass,
clienttype,
region

order by
periodyear,
periodmth
)
;


CREATE INDEX IDXanavg1
ON rcbill_my.activenumberavg (periodmth);

CREATE INDEX IDXanavg2
ON rcbill_my.activenumberavg (servicetype);

CREATE INDEX IDXanavg3
ON rcbill_my.activenumberavg (reported);

-- DROP INDEX `IDXanavg3` ON rcbill_my.activenumberavg ;

select * from rcbill_my.activenumberavg;
select * from rcbill_my.activenumberavg where reported='Y' and decommissioned='N';


-- order by ;