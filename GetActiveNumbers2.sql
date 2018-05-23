SELECT 


mthname,
periodyear,
servicecategory,
servicetype,
clienttype,
sum(open) as open_s 

FROM rcbill_my.activenumber
where
reported='Y'
and
decommissioned='N' 
and 
periodmth=10
and
periodyear=2016
and 
periodday=31
-- and
-- servicecategory='TV'

group by
mthname,
periodyear,
servicecategory,
servicetype,
clienttype


order by periodmth, periodyear, servicecategory, clienttype, servicetype
;