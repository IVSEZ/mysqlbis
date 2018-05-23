-- OPEN TICKETS 

-- INSTALLATIONS - MAHE
select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and openreason='INSTALLATION' and (StageRegion<>'TECHNICAL - ADDITIONAL SERVICE INSTALLATIONS' and StageRegion<>'PRASLIN - INSTALLATIONS' and OpenRegion<>'PRASLIN TECH - SERVICE') order by opendate ;

-- INSTALLATIONS - PRASLIN
select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and openreason='INSTALLATION' and (StageRegion='PRASLIN - INSTALLATIONS' or OpenRegion='PRASLIN TECH - SERVICE') order by opendate ;

-- RELOCATIONS
select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and openreason='RELOCATION' order by opendate ;

-- SURVEY
select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and openreason='SURVEY' order by opendate ;

-- ADDITIONAL SERVICE INSTALLATIONS
select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and openreason='INSTALLATION' and stageregion='TECHNICAL - ADDITIONAL SERVICE INSTALLATIONS' order by opendate ;



-- CLOSED TICKETS SINCE 1 Jan 2018
drop table if exists rcbill_my.closedIRStickets2018;
create table rcbill_my.closedIRStickets2018 as
-- INSTALLATIONS - MAHE
(
select 'INSTALLATION-MAHE' as `CATEGORY`, 
ReportDate, ticketid, clientcode, contractcode, TicketType, OpenReason, CloseReason, OpenRegion, StageRegion, CloseRegion, opendate, closedate, firstcommentdate, lastcommentdate, firstcomment, lastcomment, tkt_alldays, tkt_workdays
from rcbill_my.clientticketsnapshot_irs 
where 
closedate>='2018-01-01'
and openreason='INSTALLATION' 
and (StageRegion<>'TECHNICAL - ADDITIONAL SERVICE INSTALLATIONS' and StageRegion<>'PRASLIN - INSTALLATIONS' and OpenRegion<>'PRASLIN TECH - SERVICE') 
-- and CloseReason in ('INSTALLATION DONE','ACCOMPLISHED')
order by clientcode, contractcode
)
union
-- INSTALLATIONS - PRASLIN
(
select 'INSTALLATION-PRASLIN' as `CATEGORY`,
ReportDate, ticketid, clientcode, contractcode, TicketType, OpenReason, CloseReason, OpenRegion, StageRegion, CloseRegion, opendate, closedate, firstcommentdate, lastcommentdate, firstcomment, lastcomment, tkt_alldays, tkt_workdays
from rcbill_my.clientticketsnapshot_irs 
where 
-- CloseReason is null 
closedate>='2018-01-01'
and openreason='INSTALLATION' 
and (StageRegion='PRASLIN - INSTALLATIONS' or OpenRegion='PRASLIN TECH - SERVICE') 
-- and CloseReason in ('INSTALLATION DONE','ACCOMPLISHED')
order by clientcode, contractcode
)
union
-- RELOCATIONS
(
select 'RELOCATIONS' as `CATEGORY`,
ReportDate, ticketid, clientcode, contractcode, TicketType, OpenReason, CloseReason, OpenRegion, StageRegion, CloseRegion, opendate, closedate, firstcommentdate, lastcommentdate, firstcomment, lastcomment, tkt_alldays, tkt_workdays
from rcbill_my.clientticketsnapshot_irs 
where 
-- CloseReason is null 
closedate>='2018-01-01'
and openreason='RELOCATION' 
order by clientcode, contractcode
)
union
-- SURVEY
(
select 'SURVEY' as `CATEGORY`,  
ReportDate, ticketid, clientcode, contractcode, TicketType, OpenReason, CloseReason, OpenRegion, StageRegion, CloseRegion, opendate, closedate, firstcommentdate, lastcommentdate, firstcomment, lastcomment, tkt_alldays, tkt_workdays
from rcbill_my.clientticketsnapshot_irs 
where 
-- CloseReason is null 
closedate>='2018-01-01'
and openreason='SURVEY' 
order by opendate 
)
union
-- ADDITIONAL SERVICE INSTALLATIONS
(
select 'INSTALLATION-ADDITIONAL' as `CATEGORY`,  
ReportDate, ticketid, clientcode, contractcode, TicketType, OpenReason, CloseReason, OpenRegion, StageRegion, CloseRegion, opendate, closedate, firstcommentdate, lastcommentdate, firstcomment, lastcomment, tkt_alldays, tkt_workdays
from rcbill_my.clientticketsnapshot_irs 
where 
-- CloseReason is null 
closedate>='2018-01-01'
and openreason='INSTALLATION' 
and stageregion='TECHNICAL - ADDITIONAL SERVICE INSTALLATIONS' 
order by opendate
)
;

select * from rcbill_my.closedIRStickets2018;

select * from rcbill_my.salestoactive where o_clientcode='I.000017212';

select 
a.*,
b.*

from 
rcbill_my.salestoactive a 
left join
rcbill_my.closedIRStickets2018 b
on 
a.o_clientcode=b.clientcode
and 
a.o_contractcode=b.contractcode
where a.o_orderday>='2018-01-01'
order by o_orderdate desc
;



-- =====================================================









-- METRICS

select 
-- month(opendate) as openmonth, month(closedate) as closemonth, 
tickettype, closereason, count(distinct clientcode) as clients, count(distinct contractcode) as contracts, count(ticketid) as tickets
from 
rcbill_my.clientticketsnapshot_irs
where 
closedate>='2018-01-01'
and openreason='INSTALLATION' 
and (StageRegion<>'TECHNICAL - ADDITIONAL SERVICE INSTALLATIONS' and StageRegion<>'PRASLIN - INSTALLATIONS' and OpenRegion<>'PRASLIN TECH - SERVICE') 
-- and CloseReason in ('INSTALLATION DONE','ACCOMPLISHED')
group by 
-- 1,2, 
tickettype, closereason
order by 1 ;


