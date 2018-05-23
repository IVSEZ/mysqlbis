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
sum(open) as open_s,
sum(new) as new_s,
sum(newconverted) as newc_s,
sum(renew) as renew_s,
sum(closed) as closed_s,
sum(closednonpayment) as closednon_s,
sum(suspended) as suspended_s,
sum(closedconverted) as closedcon_s,
sum(closedother) as closedoth_s,
sum(totalopened) as totopn_s,
sum(totalclosed) as totcld_s,
sum(difference) as diff_s



FROM rcbill_my.activenumber
where 
decommissioned = 'N'
-- and
-- reported = 'Y'

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