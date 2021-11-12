
show index from rcbill_my.rep_tkt_irs_level1;
show index from rcbill_my.rep_tkt_irs_level2;
show index from rcbill_my.rep_tkt_irs_level3;

SELECT * FROM rcbill_my.rep_tkt_irs_level1 order by OPEN_D desc;
SELECT * FROM rcbill_my.rep_tkt_f_level1 order by OPEN_D desc;

SELECT * FROM rcbill_my.rep_tkt_irs_level2 order by OPEN_D desc;
SELECT * FROM rcbill_my.rep_tkt_f_level2 order by OPEN_D desc;

-- select open_d, openreason, count(TICKETID) as tickets, count(distinct CLIENTCODE) as clients from rcbill_my.rep_tkt_irs_level3 group by 1,2 order by 1 desc;

SELECT * FROM rcbill_my.rep_tkt_irs_level3 where open_d='2021-11-10' order by OPENDATE desc;
SELECT * FROM rcbill_my.rep_tkt_f_level3 where open_d='2021-11-10'  order by OPENDATE desc;

select * from rcbill_my.clientticketsnapshot_irs where ticketid=1023258;
select * from rcbill_my.clientticketsnapshot_f where ticketid=1023258;
select * from rcbill_my.clientticketjourney where ticketid=1008776;

	select a.*, b.comment
    -- , b.techuserid
    , b.upddate as commentdate,b.userid as commentuserid
	from 
	rcbill.rcb_tickets a 
	inner join 
	rcbill.rcb_ticketcomments b 
	on 
	a.ID=b.TICKETID
	where 
    -- a.id in (861767,861768)
    -- date(OPENDATE)>'2016-12-31'
    a.ID=1022044
	order by a.id, b.UPDDATE
    ;

select * from rcbill.rcb_tclients;
(select kod from rcb_tclients where id in (736480));

select a.id as ticketid, a.opendate

, (select name from rcb_tickettechusers where id in (a.openuserid)) as openuser
, (select OPENREASONNAME from rcb_ticketopenreasons where torid in (a.OPENREASONID)) as openreason

, (select name from rcb_tickettechdepts where id in (a.TECHDEPTID)) as opentechdept
, (select name from rcb_tickettechregions where id in (a.TECHREGIONID)) as opentechregion
, (select name from rcb_tickettechregions where id in (a.STAGETECHREGIONID)) as stagetechregion
, a.CLOSEDATE
, (select name from rcb_tickettechusers where id in (a.CLOSEUSERID)) as closeuser
, (select CLOSEREASONNAME from rcb_ticketclosereasons where TCRID in (a.CLOSEREASONID)) as closereason
, (select name from rcb_tickettechdepts where id in (a.CLOSETECHDEPTID)) as closetechdept
, (select name from rcb_tickettechregions where id in (a.CLOSETECHREGIONID)) as closetechregion
, (select firm from rcb_tclients where id in (a.CLID)) as clientname
, (select kod from rcb_tclients where id in (a.CLID)) as clientcode
, (select kod from rcb_contracts where id in (a.CID)) as contractcode
, (select name from rcb_ticketseverities where id in (a.SEVERITYID)) as ticketseverity
, (select name from rcb_tickettechservices where id in (a.SERVICEID)) as service
, (select name from rcb_tickettypes where id in (a.TYPEID)) as tickettype

, a.state as ticketstate
, a.visitcount 
, a.worktime

,a.comment, a.commentdate, a.commentuserid
-- , a.techuserid
, (select name from rcb_tickettechusers where RCBUSERID in (a.commentuserid)) as commentuser
from 
(
	select a.*, b.comment
    -- , b.techuserid
    , b.upddate as commentdate,b.userid as commentuserid
	from 
	rcbill.rcb_tickets a 
	inner join 
	rcbill.rcb_ticketcomments b 
	on 
	a.ID=b.TICKETID
	where 
    -- a.id in (861767,861768)
    a.ID=1022044
    -- date(OPENDATE)>'2016-12-31'
	order by a.id, b.UPDDATE
) a
order by ticketid, commentdate
;




SELECT * FROM rcbill_my.rep_tkt_irs_level3 
WHERE 0=0
and open_D='2021-08-09'
and district='POINTE LARUE'
;

SELECT * FROM rcbill_my.rep_tkt_f_level3 
WHERE 0=0
and open_D='2021-08-18'
and island='MAHE'
-- and district='POINTE LARUE'
and openreason='SPECIAL SERVICE REQUEST'
;

SELECT * FROM rcbill_my.rep_tkt_f_level2 
WHERE 0=0
and open_D='2021-08-17'
and island='MAHE'
-- and district='POINTE LARUE'
and openreason='NO ACCESS TO INTERNET'
;

-- select *  from rcbill_my.clientticket_cmmtjourney where ticketid=1014346;
-- select * from rcbill_my.clientticket_assgnjourney where ticketid=1014346;

