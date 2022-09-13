/*
select distinct ticketid, OPENDATE, date(opendate) as OPEN_DATE, openuser, openreason, opentechdept, opentechregion, stagetechregion, CLOSEDATE, closeuser, closereason, closetechdept, closetechregion
, a.clientname, a.clientcode, a.contractcode, ticketseverity, service, tickettype, ticketstate
, b.clientclass, b.clientlocation
from rcbill_my.clientticketjourney a 
left join 
rcbill_my.rep_custconsolidated b 
on a.clientcode=b.clientcode
where year(OPENDATE)>=2017
group by ticketid -- , OPENDATE, date(opendate), openuser, openreason, opentechdept, opentechregion, stagetechregion, CLOSEDATE, closeuser, closereason, closetechdept, closetechregion, a.clientname, a.clientcode, a.contractcode, ticketseverity, service, tickettype, ticketstate
order by opendate desc ;
-- limit 100;
*/
-- select * from rcbill_my.rep_custconsolidated limit 100;


/*
select OPEN_DATE, TICKET_TYPE, SERVICE
, OPENREASON
, OpenTechRegion AS OPENEDFROM, StageTechRegion AS OPENEDTO
, CLIENT_CLASS, CLIENT_ISLAND, CLIENT_DISTRICT, CLIENT_SUBDISTRICT
, count(TICKET_ID) as tkts, count(distinct clientcode) as accts, count(distinct contractcode) as conts
from rcbill_my.rep_clienttickets
group by 1,2,3,4,5,6,7,8,9,10
order by open_date desc
;
*/


select * from rcbill_my.rep_clienttickets; -- where open_date='2022-08-08';
select * from rcbill_my.rep_clientticket_summary;

select OPEN_DATE, TICKET_TYPE, SUM(TKTS) AS TKTS, SUM(ACCTS) AS ACCTS, SUM(CONTS) AS CONTS from rcbill_my.rep_clientticket_summary GROUP BY 1,2 ORDER BY OPEN_DATE DESC;
select OPEN_DATE, TICKET_TYPE, OPENEDFROM, OPENEDTO, SUM(TKTS) AS TKTS, SUM(ACCTS) AS ACCTS, SUM(CONTS) AS CONTS from rcbill_my.rep_clientticket_summary GROUP BY 1,2,3,4 ORDER BY OPEN_DATE DESC;
select OPEN_DATE, TICKET_TYPE, CLIENT_ISLAND, CLIENT_DISTRICT -- , CLIENT_SUBDISTRICT
, SUM(TKTS) AS TKTS, SUM(ACCTS) AS ACCTS, SUM(CONTS) AS CONTS from rcbill_my.rep_clientticket_summary GROUP BY 1,2,3,4 ORDER BY OPEN_DATE DESC;


select date(opendate) as opendate
, openreason
, OpenRegion, StageRegion
, count(*) as tkts, count(distinct clientcode) as accts, count(distinct contractcode) as conts
from rcbill_my.clientticketsnapshot_f
group by 1,2,3,4
order by opendate desc
;

select date(opendate) as opendate
, openreason
, count(*) as tkts, count(distinct clientcode) as accts, count(distinct contractcode) as conts
from rcbill_my.clientticketsnapshot_irs
group by 1,2
order by opendate desc
;

select date(opendate) as opendate
, openreason
, count(*) as tkts, count(distinct clientcode) as accts, count(distinct contractcode) as conts
from rcbill_my.clientticketsnapshot_f
group by 1,2
order by opendate desc
;

select date(opendate) as opendate
, OpenRegion as OpenedFrom
, count(*) as tkts, count(distinct clientcode) as accts, count(distinct contractcode) as conts
from rcbill_my.clientticketsnapshot_f
group by 1,2
order by opendate desc
;

select date(opendate) as opendate
, StageRegion as OpenedTo
, count(*) as tkts, count(distinct clientcode) as accts, count(distinct contractcode) as conts
from rcbill_my.clientticketsnapshot_f
group by 1,2
order by opendate desc
;