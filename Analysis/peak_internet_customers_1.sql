select * from rcbill_my.rep_anreport_i;

select periodyear, periodmth, max(activecount)
from rcbill_my.rep_anreport_i
group by periodyear, periodmth
;

select a.* from rcbill_my.rep_anreport_i a 
inner join
(
select periodyear, periodmth, max(activecount) as  activecount
from rcbill_my.rep_anreport_i
group by periodyear, periodmth
) b
on a.periodyear=b.periodyear
and a.periodmth=b.periodmth
and a.activecount=b.activecount
order by 1 desc
;

