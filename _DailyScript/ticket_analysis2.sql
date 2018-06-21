
set @startdate='2018-01-01';

set @clientcode='I.000014096';

select * from rcbill_my.clientticketsnapshot_f;

select * from rcbill_my.clientticketsnapshot_f where clientcode=@clientcode;

select ticketid, openreason, count(*) from rcbill_my.clientticketsnapshot_f where clientcode=@clientcode
group by ticketid, openreason
;


-- select date(opendate) as OPEN_DATE from rcbill_my.clientticketjourney;


-- select * from rcbill_my.clientticketjourney where date(OPENDATE)>=@startdate;

-- 


/*
select * from rcbill.rcb_tickets where id in (865626);
select *,(select RCBUSERID from rcbill.rcb_tickettechusers where id=techuserid) as RCBUSERID from rcbill.rcb_ticketassignments where ticketid in (865626) order by id;
select * from rcbill.rcb_ticketcomments where ticketid in (865626) order by id;

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
    a.id in (865626)
    and 
    date(a.OPENDATE)>'2016-12-31'
	order by a.id, b.UPDDATE
    ;
    
    
    select a.*
    , c.ID AS ASSGN_ID
    , c.TECHLEVELID AS ASSGN_TECHLEVELID
    , c.TECHDEPTID AS ASSGN_TECHDEPTID
    , c.TECHREGIONID AS ASSGN_TECHREGIONID
    , c.TECHGROUPID AS ASSGN_TECHGROUPID
    , c.TECHUSERID AS ASSGN_TECHUSERID
    , c.OPENDATE AS ASSGN_OPENDATE
    , c.CLOSEDATE AS ASSGN_CLOSEDATE
    , c.CLOSEREASONID AS ASSGN_CLOSEREASONID
    , c.USERID AS ASSGN_USERID
    , c.WORKTIME AS ASSGN_WORKTIME
    , c.UPDDATE AS ASSGN_UPDDATE
    , b.comment
    -- , b.techuserid
    , b.upddate as commentdate,b.userid as commentuserid
	from 
	rcbill.rcb_tickets a 
	inner join 
    rcbill.rcb_ticketassignments c
    on 
    a.ID=c.TICKETID
    inner join
	rcbill.rcb_ticketcomments b 
	on 
	a.ID=b.TICKETID
	where 
    a.id in (865626)
    and 
    date(a.OPENDATE)>'2016-12-31'
	order by a.id, b.UPDDATE
    ;
    

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

, (select name from rcb_tickettechdepts where id in (a.ASSGN_TECHDEPTID)) as assgntechdept
, (select name from rcb_tickettechregions where id in (a.ASSGN_TECHREGIONID)) as assgntechregion
, (select name from rcb_tickettechlevels where ID in (a.ASSGN_TECHLEVELID)) as assgntechlevel
, (select name from rcb_tickettechusers where id in (a.ASSGN_TECHUSERID)) as assgntechuser
, a.ASSGN_OPENDATE 
, a.ASSGN_CLOSEDATE
, (select CLOSEREASONNAME from rcb_ticketclosereasons where TCRID in (a.ASSGN_CLOSEREASONID)) as assgnclosereason
, (select name from rcb_tickettechusers where RCBUSERID in (a.ASSGN_USERID)) as assgnuser
, a.ASSGN_UPDDATE

, a.comment, a.commentdate, a.commentuserid
, (select name from rcb_tickettechusers where RCBUSERID in (a.commentuserid)) as commentuser
from 
(
   select a.*
    , c.ID AS ASSGN_ID
    , c.TECHLEVELID AS ASSGN_TECHLEVELID
    , c.TECHDEPTID AS ASSGN_TECHDEPTID
    , c.TECHREGIONID AS ASSGN_TECHREGIONID
    , c.TECHGROUPID AS ASSGN_TECHGROUPID
    , c.TECHUSERID AS ASSGN_TECHUSERID
    , c.OPENDATE AS ASSGN_OPENDATE
    , c.CLOSEDATE AS ASSGN_CLOSEDATE
    , c.CLOSEREASONID AS ASSGN_CLOSEREASONID
    , c.USERID AS ASSGN_USERID
    , c.WORKTIME AS ASSGN_WORKTIME
    , c.UPDDATE AS ASSGN_UPDDATE
    , b.comment
    -- , b.techuserid
    , b.upddate as commentdate,b.userid as commentuserid
	from 
	rcbill.rcb_tickets a 
	inner join 
    rcbill.rcb_ticketassignments c
    on 
    a.ID=c.TICKETID
    inner join
	rcbill.rcb_ticketcomments b 
	on 
	a.ID=b.TICKETID
	where 
    a.id in (865626)
    and 
    date(a.OPENDATE)>'2016-12-31'
	order by a.id, b.UPDDATE
) a
order by ticketid, a.ASSGN_OPENDATE, commentdate

; 





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


, a.comment, a.commentdate, a.commentuserid
, (select name from rcb_tickettechusers where RCBUSERID in (a.commentuserid)) as commentuser
from 
(
   select a.*
     , b.comment
    -- , b.techuserid
    , b.upddate as commentdate,b.userid as commentuserid
	from 
	rcbill.rcb_tickets a 
    inner join
	rcbill.rcb_ticketcomments b 
	on 
	a.ID=b.TICKETID
	where 
    a.id in (865626)
    and 
    date(a.OPENDATE)>'2016-12-31'
	order by a.id, b.UPDDATE
) a
order by ticketid, a.commentdate

; 


    



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

, (select name from rcb_tickettechdepts where id in (a.ASSGN_TECHDEPTID)) as assgntechdept
, (select name from rcb_tickettechregions where id in (a.ASSGN_TECHREGIONID)) as assgntechregion
, (select name from rcb_tickettechlevels where ID in (a.ASSGN_TECHLEVELID)) as assgntechlevel
, (select name from rcb_tickettechusers where id in (a.ASSGN_TECHUSERID)) as assgntechuser
, a.ASSGN_OPENDATE 
, a.ASSGN_CLOSEDATE
, (select CLOSEREASONNAME from rcb_ticketclosereasons where TCRID in (a.ASSGN_CLOSEREASONID)) as assgnclosereason
, (select name from rcb_tickettechusers where RCBUSERID in (a.ASSGN_USERID)) as assgnuser
, a.ASSGN_UPDDATE

from 
(
 
  select a.*
    , c.ID AS ASSGN_ID
    , c.TECHLEVELID AS ASSGN_TECHLEVELID
    , c.TECHDEPTID AS ASSGN_TECHDEPTID
    , c.TECHREGIONID AS ASSGN_TECHREGIONID
    , c.TECHGROUPID AS ASSGN_TECHGROUPID
    , c.TECHUSERID AS ASSGN_TECHUSERID
    , c.OPENDATE AS ASSGN_OPENDATE
    , c.CLOSEDATE AS ASSGN_CLOSEDATE
    , c.CLOSEREASONID AS ASSGN_CLOSEREASONID
    , c.USERID AS ASSGN_USERID
    , c.WORKTIME AS ASSGN_WORKTIME
    , c.UPDDATE AS ASSGN_UPDDATE
	from 
	rcbill.rcb_tickets a 
	inner join 
    rcbill.rcb_ticketassignments c
    on 
    a.ID=c.TICKETID
 
	where 
    a.id in (865626)
    and 
    date(a.OPENDATE)>'2016-12-31'
	order by a.id, c.OPENDATE
) a
order by ticketid, a.ASSGN_OPENDATE


    ;

*/

select openreason, tickettype, opentechregion, stagetechregion, closetechregion, count(distinct ticketid) from rcbill_my.clientticketjourney where date(OPENDATE)>=@startdate
group by openreason, tickettype, opentechregion, stagetechregion, closetechregion
-- order by 2 desc
-- with rollup
;