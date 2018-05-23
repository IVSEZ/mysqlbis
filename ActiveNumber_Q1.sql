SELECT period, 
-- day(LAST_DAY(period)) as MTHDAYS,
sum(open) as open_s,
periodmth
FROM rcbill_my.activenumber
group by period, periodmth
;