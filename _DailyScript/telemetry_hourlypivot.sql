
select * from rcbill_my.rep_livetvhourlypivot; -- where sessiondate='2018-08-28';
select * from rcbill_my.rep_livetvhourlystats; -- where resource='SBC';

select *
, year(sessiondate) as SESSIONYR, month(sessiondate) as SESSIONMT, day(sessiondate) as SESSIONDY
, dayname(sessiondate) as SESSIONDAY, monthname(sessiondate) as SESSIONMONTH
from rcbill_my.rep_livetvhourlypivot
-- where monthname(sessiondate) ='August' and resource='SBC'  
;

SELECT 
RESOURCE
, monthname(sessiondate) as SESSIONMONTH
, round(avg(`0`)) as `0` ,	round(avg(`1`)) as `1` ,	round(avg(`2`)) as `2` ,	round(avg(`3`)) as `3` ,	round(avg(`4`)) as `4` ,	round(avg(`5`)) as `5` ,	round(avg(`6`)) as `6` ,	round(avg(`7`)) as `7` ,	round(avg(`8`)) as `8` ,	round(avg(`9`)) as `9` ,	round(avg(`10`)) as `10` ,	round(avg(`11`)) as `11` ,	round(avg(`12`)) as `12` ,	round(avg(`13`)) as `13` ,	round(avg(`14`)) as `14` ,	round(avg(`15`)) as `15` ,	round(avg(`16`)) as `16` ,	round(avg(`17`)) as `17` ,	round(avg(`18`)) as `18` ,	round(avg(`19`)) as `19` ,	round(avg(`20`)) as `20` ,	round(avg(`21`)) as `21` ,	round(avg(`22`)) as `22` ,	round(avg(`23`)) as `23` 
FROM rcbill_my.rep_livetvhourlypivot
-- where 
-- monthname(sessiondate)='August' and resource='SBC' 
GROUP BY 1,2
order by sessiondate, resource
;

SELECT 
RESOURCE
, dayname(sessiondate) as SESSIONDAY
, round(avg(`0`)) as `0` ,	round(avg(`1`)) as `1` ,	round(avg(`2`)) as `2` ,	round(avg(`3`)) as `3` ,	round(avg(`4`)) as `4` ,	round(avg(`5`)) as `5` ,	round(avg(`6`)) as `6` ,	round(avg(`7`)) as `7` ,	round(avg(`8`)) as `8` ,	round(avg(`9`)) as `9` ,	round(avg(`10`)) as `10` ,	round(avg(`11`)) as `11` ,	round(avg(`12`)) as `12` ,	round(avg(`13`)) as `13` ,	round(avg(`14`)) as `14` ,	round(avg(`15`)) as `15` ,	round(avg(`16`)) as `16` ,	round(avg(`17`)) as `17` ,	round(avg(`18`)) as `18` ,	round(avg(`19`)) as `19` ,	round(avg(`20`)) as `20` ,	round(avg(`21`)) as `21` ,	round(avg(`22`)) as `22` ,	round(avg(`23`)) as `23` 
FROM rcbill_my.rep_livetvhourlypivot
GROUP BY 1,2
order by sessiondate, resource
;
