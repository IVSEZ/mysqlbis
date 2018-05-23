SELECT
servicecategory,
period,
periodday,
periodmth,
periodyear,
weekday,
mthname,

decommissioned,
reported,
sum(open_s) as open_s,
sum(new_s) as new_s,
sum(newc_s) as newc_s,
sum(renew_s) as renew_s,
sum(closed_s) as closed_s,
sum(closednon_s) as closednon_s,
sum(suspended_s) as suspended_s,
sum(closedcon_s) as closedcon_s,
sum(closedoth_s) as closedoth_s,
sum(totopn_s) as totopn_s,
sum(totcld_s) as totcld_s,
sum(diff_s) as diff_s



FROM rcbill_my.anreport
where 
decommissioned = 'N'
 and
 reported = 'Y'

group by
servicecategory,
period,
periodday,
periodmth,
periodyear,
weekday,
mthname,

decommissioned,
reported

order by
period desc
/*

periodyear,
periodmth,
periodday,
*/
-- ,reported
,servicecategory
;