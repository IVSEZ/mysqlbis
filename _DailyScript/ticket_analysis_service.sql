set @od='2018-01-01';

select * from rcbill_my.clientticketsnapshot_f where CloseReason is not null and date(opendate)>=@od;

select * from rcbill_my.clientticketjourney
where ticketid in 
(

select ticketid from rcbill_my.clientticketsnapshot_f where CloseReason is not null and date(opendate)>=@od

)

order by ticketid, OPENDATE
;

select * from rcbill_my.clientticketjourney
where ticketid in 
(

select ticketid from rcbill_my.clientticketsnapshot_f where CloseReason is not null and date(opendate)>=@od

)
-- and (upper(comment) like '%ATTENDED%' or UPPER(comment) like '%ATTENDED' or UPPER(comment) like 'ATTENDED%') and (upper(comment) not like '%NOT ATTENDED%' or upper(comment) not like '%NOT ATTENDED' or upper(comment) not like 'NOT ATTENDED%')
and (upper(comment) like '%ATTENDED%') and (upper(comment) not like '%NOT ATTENDED%')
order by ticketid, OPENDATE
;

select * from rcbill_my.clientticketjourney
where 1=1 
/*
ticketid in 
(

select ticketid from rcbill_my.clientticketsnapshot_f where CloseReason is not null and date(opendate)>=@od

)
*/
and (upper(comment) like '%ATTENDED%') and (upper(comment) not like '%NOT ATTENDED%')
and date(opendate)>=@od
order by ticketid, OPENDATE
;

select a.* 
, datediff(a.lastcommentdate,a.firstcommentdate) as tkt_ad
, (5 * (DATEDIFF(a.lastcommentdate,a.firstcommentdate) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(a.firstcommentdate) + WEEKDAY(a.lastcommentdate) + 1, 1)) as tkt_wd

from rcbill_my.clientticketsnapshot_f a where ticketid in 
(
select ticketid from rcbill_my.clientticketjourney where (upper(comment) not like '%NOT ATTENDED%') and (upper(comment) like '%ATTENDED%') and date(opendate)>=@od
)
order by ticketid
;


select a.* , 
, datediff(b.lastcommentdate,b.firstcommentdate) as tkt_ad
, (5 * (DATEDIFF(b.lastcommentdate,b.firstcommentdate) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(a.firstcommentdate) + WEEKDAY(a.lastcommentdate) + 1, 1)) as tkt_wd



from 
rcbill_my.clientticketsnapshot_f a 
inner join
(
select * from rcbill_my.clientticketjourney where (upper(comment) not like '%NOT ATTENDED%') and (upper(comment) like '%ATTENDED%') and date(opendate)>=@od
) b 
on a.ticketid=b.ticketid
order by ticketid
;