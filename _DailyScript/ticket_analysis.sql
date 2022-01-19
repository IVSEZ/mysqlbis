-- TICKET ANALYSIS
use rcbill;
-- SET @rundate='2018-01-10';

/*
select * from rcbill.rcb_tickettechusers;
select * from rcbill.rcb_tickettechdepts;
select * from rcbill.rcb_tickettechregions;
select * from rcbill.rcb_techregions;
select * from rcbill.rcb_ticketopenreasons;
select * from rcbill.rcb_ticketclosereasons;
select * from rcbill.rcb_ticketseverities;
select * from rcbill.rcb_tickettechservices;
select * from rcbill.rcb_tickettypes;


-- select * from rcbill.rcb_tickets limit 1000; -- where year(OPENDATE)=2017;
-- select * from rcbill.rcb_ticketcomments limit 1000;


select a.*,b.ticketid, b.comment, b.techuserid, b.ID_OLD,b.upddate,b.userid
from 
rcbill.rcb_tickets a 
inner join 
rcbill.rcb_ticketcomments b 
on 
a.ID=b.TICKETID
-- where a.id in (861767,861768)
order by a.id, b.UPDDATE
;







*/

/*

5 * (DATEDIFF(@E, @S) DIV 7) + MID('0123444401233334012222340111123400012345001234550', 7 * WEEKDAY(@S) + WEEKDAY(@E) + 1, 1)
5 * (DATEDIFF(@E, @S) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(@S) + WEEKDAY(@E) + 1, 1)
5 * (DATEDIFF(@E, @S) DIV 7) + MID('0123455501234445012333450122234501101234000123450', 7 * WEEKDAY(@S) + WEEKDAY(@E) + 1, 1)
SELECT (DATEDIFF(date_end, date_start)) - ((WEEK(date_end) - WEEK(date_start)) * 2) - (case when weekday(date_end) = 6 then 1 else 0 end) - (case when weekday(date_start) = 5 then 1 else 0 end) - (SELECT COUNT(*) FROM holidays WHERE holiday>=date_start and holiday<=data_end)

(SELECT (DATEDIFF(a.closedate, a.opendate)) - ((WEEK(a.closedate) - WEEK(a.opendate)) * 2) - (case when weekday(a.closedate) = 6 then 1 else 0 end) - (case when weekday(a.opendate) = 5 then 1 else 0 end) - (SELECT COUNT(*) FROM holidays WHERE holiday>=a.opendate and holiday<=a.closedate)
(5 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays

*/


drop table if exists  rcbill_my.clientticketjourney;

create table rcbill_my.clientticketjourney as
(

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
    date(OPENDATE)>'2016-12-31'
	order by a.id, b.UPDDATE
) a
order by ticketid, commentdate
)
;

-- show index from rcbill_my.clientticketjourney;
CREATE INDEX IDXctj1
ON rcbill_my.clientticketjourney (clientcode);
CREATE INDEX IDXctj2
ON rcbill_my.clientticketjourney (opendate);
CREATE INDEX IDXctj3
ON rcbill_my.clientticketjourney (ticketid);

-- select * from  rcbill_my.clientticketjourney;

-- CREATE TABLE FOR CLIENTTICKET SNAPSHOT FOR INSTALLATION , RELOCATION, SURVEY
DROP TABLE IF exists rcbill_my.clientticketsnapshot_irs;

create table rcbill_my.clientticketsnapshot_irs 
(INDEX idxctsirs1(clientcode), INDEX idxctsirs2(contractcode), INDEX idxctsirs3(open_d), INDEX idxctsirs4(close_d)) 
as
(

	select @rundate as ReportDate, a.*
			, date(a.opendate) as open_d
            , date(a.closedate) as close_d
			, month(a.opendate) as open_m
            , month(a.closedate) as close_m
			, year(a.opendate) as open_y
            , year(a.closedate) as close_y
			, b.comment as firstcomment, c.comment as lastcomment
			, datediff(a.closedate,a.opendate) as tkt_alldays
			, (5 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays
			-- , (5 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123455501234445012333450122234501112345000123450', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays2

			## commented on 11/01/2022 and updated with new code
			-- , (6 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123455501234445012333450122234501112345011234560', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays2
            , (6 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123455501234445012333450122234501112345000123450', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays2


	from 
	(
		select distinct ticketid, clientcode, contractcode, trim(upper(tickettype)) as TicketType, trim(upper(openreason)) as OpenReason
        , trim(upper(closereason)) as CloseReason
        , trim(upper(opentechregion)) as OpenRegion
        , trim(upper(stagetechregion)) as StageRegion
        , trim(upper(closetechregion)) as CloseRegion
        , min(opendate) as opendate, max(closedate) as closedate
        , min(commentdate) as firstcommentdate, max(commentdate) as lastcommentdate
		from rcbill_my.clientticketjourney 
		where
		TRIM(UPPER(tickettype)) in ('INSTALLATION','RELOCATION','SURVEY') 
		-- openreason in ('installation','Relocation')
		-- and 
		-- closereason in ('installation done','Relocation Done')
		-- tickettype in ('installation','Relocation','Survey') 
		-- and 
		-- ticketstate='closed'
		-- and clientname like '%wolfgang%'
		group by 
		ticketid, clientcode, contractcode, 4, 5, 6, 7, 8, 9
	) a 
	left join
	(
		select ticketid
        -- , clientcode, contractcode
        , comment, commentdate

		from rcbill_my.clientticketjourney 
		where
		TRIM(UPPER(tickettype)) in ('INSTALLATION','RELOCATION','SURVEY') 
		-- openreason in ('installation','Relocation')
		-- and 
		-- closereason in ('installation done','Relocation Done')
		group by ticketid, comment, commentdate
	) b 
	on 
    /*
	a.lastcommentdate=b.commentdate
	and
	a.clientcode=b.clientcode
	and
	a.contractcode=b.contractcode
	*/
    a.ticketid=b.ticketid
    and
	a.firstcommentdate=b.commentdate

	left join
	(
		select ticketid
        -- , clientcode, contractcode
        , comment, commentdate

		from rcbill_my.clientticketjourney 
		where
		TRIM(UPPER(tickettype)) in ('INSTALLATION','RELOCATION','SURVEY') 
		-- openreason in ('installation','Relocation')
		-- and 
		-- closereason in ('installation done','Relocation Done')
		group by ticketid, comment, commentdate
	) c	
	on 
    /*
	a.lastcommentdate=b.commentdate
	and
	a.clientcode=b.clientcode
	and
	a.contractcode=b.contractcode
	*/
    a.ticketid=c.ticketid
    and
	a.lastcommentdate=c.commentdate	
  
  order by a.opendate
)
;


-- select * from  rcbill_my.clientticketjourney;
-- select * from  rcbill_my.clientticketsnapshot_irs ;



-- CREATE SNAPSHOT TABLE FOR FAULT TICKETS

drop temporary table if exists a;
create temporary table a
(INDEX idxtempa(lastcommentdate, ticketid), INDEX idxtempb(firstcommentdate, ticketid)) 
 as
(
	select distinct ticketid, clientcode, contractcode, trim(upper(tickettype)) as TicketType
    , trim(upper(openreason)) as OpenReason, trim(upper(closereason)) as CloseReason
	, trim(upper(opentechregion)) as OpenRegion
	, trim(upper(stagetechregion)) as StageRegion
	, trim(upper(closetechregion)) as CloseRegion    
    
    , min(opendate) as opendate, max(closedate) as closedate
    , min(commentdate) as firstcommentdate, max(commentdate) as lastcommentdate
	from rcbill_my.clientticketjourney 
	where
	trim(upper(tickettype)) in ('FAULT') 
	group by 
	ticketid, clientcode, contractcode, 4, 5, 6, 7, 8, 9
)
;



drop temporary table if exists b;
create temporary table b
(INDEX idxtempb(commentdate, ticketid)) 
 as
(
	select ticketid
    -- ,clientcode, contractcode
    , comment, commentdate
	from rcbill_my.clientticketjourney 
	where
	trim(upper(tickettype)) in ('FAULT') 
	group by ticketid
    -- , clientcode, contractcode
    , comment, commentdate
    -- order by ticketid, commentdate
)
;

drop temporary table if exists c;
create temporary table c
(INDEX idxtempb(commentdate, ticketid)) 
 as
(
	select ticketid
    -- ,clientcode, contractcode
    , comment, commentdate
	from rcbill_my.clientticketjourney 
	where
	trim(upper(tickettype)) in ('FAULT') 
	group by ticketid
    -- , clientcode, contractcode
    , comment, commentdate
    -- order by ticketid, commentdate
)
;

drop table if exists  rcbill_my.clientticketsnapshot_f ;

create table  rcbill_my.clientticketsnapshot_f 
(INDEX idxctsf1(clientcode), INDEX idxctsf2(contractcode), INDEX idxctsf3(open_d), INDEX idxctsf4(close_d)) 
as
(
select @rundate as ReportDate, a.*
		, date(a.opendate) as open_d
		, date(a.closedate) as close_d
		, month(a.opendate) as open_m
		, month(a.closedate) as close_m
		, year(a.opendate) as open_y
		, year(a.closedate) as close_y
		
		, b.comment as firstcomment, c.comment as lastcomment
		, datediff(a.closedate,a.opendate) as tkt_alldays
		, (5 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays
		-- , (5 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123455501234445012333450122234501112345000123450', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays2

        ## commented on 11/01/2022 and updated with new code
		-- , (6 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123455501234445012333450122234501112345011234560', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays2
		, (6 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123455501234445012333450122234501112345000123450', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays2
		-- , ((DATEDIFF(a.closedate, a.opendate)) - ((WEEK(a.closedate) - WEEK(a.opendate)) * 2) - (case when weekday(a.closedate) = 6 then 1 else 0 end) - (case when weekday(a.opendate) = 5 then 1 else 0 end))-- - (SELECT COUNT(*) FROM holidays WHERE holiday>=a.opendate and holiday<=a.closedate))
		



from a
left join
b 
on 
a.firstcommentdate=b.commentdate
and
a.ticketid=b.ticketid
left join
c
on 
a.lastcommentdate=c.commentdate
and
a.ticketid=c.ticketid

-- and
-- a.clientcode=b.clientcode
-- and
-- a.contractcode=b.contractcode
order by a.opendate
)
;

-- select * from rcbill_my.clientticketsnapshot_f;

#TICKET ASSIGNMENTS & COMMENTS JOURNEY
use rcbill;

set @startdate='2017-01-01';


drop table if exists rcbill_my.clientticket_cmmtjourney;

create table rcbill_my.clientticket_cmmtjourney as
(

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
		-- a.id in (865626)
		-- and 
		date(a.OPENDATE)>=@startdate
		order by a.id, b.UPDDATE
	) a
	order by ticketid, a.commentdate
)
; 


    

drop table if exists rcbill_my.clientticket_assgnjourney;


### updated code 19 Jan 2022
create table rcbill_my.clientticket_assgnjourney as
(
	select a.*
		-- , sec_to_time((a.working_minutesall)*60) AS working_hoursall
		, sec_to_time((a.working_minutes)*60) AS working_hours

		, dayname(a.ASSGN_OPENDATE) as OPEN_DAY
		, dayname(a.ASSGN_CLOSEDATE) as CLOSE_DAY

		, (select HOLIDAY_NAME from rcbill_my.holidays where COUNTRY_CODE='SC' and HOLIDAY_DATE=date(a.ASSGN_OPENDATE) limit 1) as OPEN_HOLIDAY

		, (select HOLIDAY_NAME from rcbill_my.holidays where COUNTRY_CODE='SC' and (HOLIDAY_DATE)=date(a.ASSGN_CLOSEDATE) limit 1) as CLOSE_HOLIDAY
	from 
	(

		select a.*


			
			-- , rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,a.start_time,a.end_time) AS working_minutesall
			
			-- , (rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2))/60) AS working_hours
			-- , sec_to_time((rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2)))*60) AS working_hours
			
			, rcbill_my.workday_time_diff_holidays2(a.dept_flag, 'SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,a.start_time,a.end_time) AS working_minutes
			-- , (rcbill_my.workday_time_diff_holidays2(rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',3), 'SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2))/60) AS working_hours2
			-- , sec_to_time((rcbill_my.workday_time_diff_holidays2(a.dept_flag, 'SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,a.start_time,a.end_time))*60) AS working_hours2

			

			
		from 
		(
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

			, datediff(a.ASSGN_CLOSEDATE,a.ASSGN_OPENDATE) as tkt_alldays
			, (5 * (DATEDIFF(a.ASSGN_CLOSEDATE,a.ASSGN_OPENDATE) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(a.ASSGN_OPENDATE) + WEEKDAY(a.ASSGN_CLOSEDATE) + 1, 1)) as tkt_workdays
			-- , (5 * (DATEDIFF(a.ASSGN_CLOSEDATE,a.ASSGN_OPENDATE) DIV 7) + MID('0123455501234445012333450122234501112345000123450', 7 * WEEKDAY(a.ASSGN_OPENDATE) + WEEKDAY(a.ASSGN_CLOSEDATE) + 1, 1)) as tkt_workdays2

			## commented on 11/01/2022 and updated with new code
			-- , (6 * (DATEDIFF(a.ASSGN_CLOSEDATE,a.ASSGN_OPENDATE) DIV 7) + MID('0123455501234445012333450122234501112345011234560', 7 * WEEKDAY(a.ASSGN_OPENDATE) + WEEKDAY(a.ASSGN_CLOSEDATE) + 1, 1)) as tkt_workdays2
			, (6 * (DATEDIFF(a.ASSGN_CLOSEDATE,a.ASSGN_OPENDATE) DIV 7) + MID('0123455501234445012333450122234501112345000123450', 7 * WEEKDAY(a.ASSGN_OPENDATE) + WEEKDAY(a.ASSGN_CLOSEDATE) + 1, 1)) as tkt_workdays2

			-- , ((DATEDIFF(a.ASSGN_CLOSEDATE, a.ASSGN_OPENDATE)) - ((WEEK(a.ASSGN_CLOSEDATE) - WEEK(a.ASSGN_OPENDATE)) * 2) - (case when weekday(a.ASSGN_CLOSEDATE) = 6 then 1 else 0 end) - (case when weekday(a.ASSGN_OPENDATE) = 5 then 1 else 0 end)) as tkt_workdays3-- - (SELECT COUNT(*) FROM holidays WHERE holiday>=a.opendate and holiday<=a.closedate))
			   
			, (select CLOSEREASONNAME from rcb_ticketclosereasons where TCRID in (a.ASSGN_CLOSEREASONID)) as assgnclosereason
			, (select name from rcb_tickettechusers where RCBUSERID in (a.ASSGN_USERID)) as assgnuser
			, a.ASSGN_UPDDATE


			, rcbill_my.GetShiftTimingsForDept(upper((select name from rcb_tickettechregions where id in (a.ASSGN_TECHREGIONID)))) as shift_timings
			, rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper((select name from rcb_tickettechregions where id in (a.ASSGN_TECHREGIONID)))),'|',1) as start_time
			, rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper((select name from rcb_tickettechregions where id in (a.ASSGN_TECHREGIONID)))),'|',2) as end_time
			, rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper((select name from rcb_tickettechregions where id in (a.ASSGN_TECHREGIONID)))),'|',3) as dept_flag
			

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
				-- a.id in (865626)
				-- and 
				date(a.OPENDATE)>=@startdate
				order by a.id, c.OPENDATE
				-- limit 100000
			) a
			order by ticketid, a.ASSGN_OPENDATE
		) a 
	) a
);

### commented on 19 Jan 2022
/*
create table rcbill_my.clientticket_assgnjourney as
(

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

	, datediff(a.ASSGN_CLOSEDATE,a.ASSGN_OPENDATE) as tkt_alldays
	, (5 * (DATEDIFF(a.ASSGN_CLOSEDATE,a.ASSGN_OPENDATE) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(a.ASSGN_OPENDATE) + WEEKDAY(a.ASSGN_CLOSEDATE) + 1, 1)) as tkt_workdays
	-- , (5 * (DATEDIFF(a.ASSGN_CLOSEDATE,a.ASSGN_OPENDATE) DIV 7) + MID('0123455501234445012333450122234501112345000123450', 7 * WEEKDAY(a.ASSGN_OPENDATE) + WEEKDAY(a.ASSGN_CLOSEDATE) + 1, 1)) as tkt_workdays2

    ## commented on 11/01/2022 and updated with new code
	-- , (6 * (DATEDIFF(a.ASSGN_CLOSEDATE,a.ASSGN_OPENDATE) DIV 7) + MID('0123455501234445012333450122234501112345011234560', 7 * WEEKDAY(a.ASSGN_OPENDATE) + WEEKDAY(a.ASSGN_CLOSEDATE) + 1, 1)) as tkt_workdays2
	, (6 * (DATEDIFF(a.ASSGN_CLOSEDATE,a.ASSGN_OPENDATE) DIV 7) + MID('0123455501234445012333450122234501112345000123450', 7 * WEEKDAY(a.ASSGN_OPENDATE) + WEEKDAY(a.ASSGN_CLOSEDATE) + 1, 1)) as tkt_workdays2

    -- , ((DATEDIFF(a.ASSGN_CLOSEDATE, a.ASSGN_OPENDATE)) - ((WEEK(a.ASSGN_CLOSEDATE) - WEEK(a.ASSGN_OPENDATE)) * 2) - (case when weekday(a.ASSGN_CLOSEDATE) = 6 then 1 else 0 end) - (case when weekday(a.ASSGN_OPENDATE) = 5 then 1 else 0 end)) as tkt_workdays3-- - (SELECT COUNT(*) FROM holidays WHERE holiday>=a.opendate and holiday<=a.closedate))
	
    
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
		-- a.id in (865626)
		-- and 
		date(a.OPENDATE)>=@startdate
		order by a.id, c.OPENDATE
	) a
	order by ticketid, a.ASSGN_OPENDATE
)
;
*/




select COUNT(*) as clientticket_cmmtjourney  from rcbill_my.clientticket_cmmtjourney;
select COUNT(*) as clientticket_assgnjourney from rcbill_my.clientticket_assgnjourney;


-- select *  from rcbill_my.clientticket_cmmtjourney;
-- select * from rcbill_my.clientticket_assgnjourney where ticketid=909213;

-- select * from  rcbill_my.clientticketjourney;
-- select * from  rcbill_my.clientticketsnapshot_irs ;
-- select * from rcbill_my.clientticketsnapshot_f;

-- select * from rcbill_my.clientticketsnapshot_irs where tickettype='Installation' and CloseReason is null order by opendate	;


/*
select tickettype, openreason, OpenRegion, StageRegion, date(opendate) as opendate, count(*) as tktcount 
from rcbill_my.clientticketsnapshot_irs 
-- where tickettype='Installation' 
-- and CloseReason is null 
group by tickettype, openreason, OpenRegion, StageRegion, 5
order by 5 desc	;


select tickettype, openreason, OpenRegion, StageRegion, date(opendate) as opendate, count(*) as tktcount 
from rcbill_my.clientticketsnapshot_irs 
where 
-- tickettype='Installation' 
-- and 
CloseReason is not null 
group by tickettype, openreason, OpenRegion, StageRegion, 5
order by 5 desc	;

select tickettype, openreason, OpenRegion, StageRegion, date(opendate) as opendate, count(*) as tktcount 
from rcbill_my.clientticketsnapshot_f 
-- where tickettype='Installation' 
-- and CloseReason is null 
group by tickettype, openreason, OpenRegion, StageRegion, 5
order by 5 desc	;
*/


-- OPEN TICKETS 

-- INSTALLATIONS - MAHE
-- select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and openreason='INSTALLATION' and (StageRegion<>'TECHNICAL - ADDITIONAL SERVICE INSTALLATIONS' and StageRegion<>'PRASLIN - INSTALLATIONS' and OpenRegion<>'PRASLIN TECH - SERVICE') order by opendate ;

-- INSTALLATIONS - PRASLIN
-- select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and openreason='INSTALLATION' and (StageRegion='PRASLIN - INSTALLATIONS' or OpenRegion='PRASLIN TECH - SERVICE') order by opendate ;

-- RELOCATIONS
-- select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and openreason='RELOCATION' order by opendate ;

-- SURVEY
-- select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and (openreason='SURVEY' or StageRegion='TECHNICAL - SURVEY') order by opendate ;
-- TECH AUDIT SURVEY
-- select * from rcbill_my.clientticketsnapshot_f where CloseReason is null and (clientcode='I6') order by opendate;

-- ADDITIONAL SERVICE INSTALLATIONS
-- select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and openreason='INSTALLATION' and stageregion='TECHNICAL - ADDITIONAL SERVICE INSTALLATIONS' order by opendate ;

-- FAULT - PRASLIN
-- select * from rcbill_my.clientticketsnapshot_f where CloseReason is null and (StageRegion='PRASLIN TECH - SERVICE' or OpenRegion='PRASLIN TECH - SERVICE' or OpenRegion='PRASLIN - MAINTENANCE') order by opendate ;


-- FAULT - MAHE
-- select * from rcbill_my.clientticketsnapshot_f where CloseReason is null and (StageRegion='TECHNICAL - NEW SERVICE' or StageRegion='TECHNICAL - PENDING SERVICE') order by opendate ;

-- MAINTENANCE - MAHE
-- select * from rcbill_my.clientticketsnapshot_f where CloseReason is null and (StageRegion='TECHNICAL - MAINTENANCE') order by opendate ;


-- OPEN SURVEY TICKETS
drop table if exists rcbill_my.rep_surveytickets;
create table rcbill_my.rep_surveytickets as 
(

	SELECT reportdate as REPORT_DATE, TICKETID AS TICKET_ID, CLIENTCODE AS CLIENT_CODE, CONTRACTCODE AS CONTRACT_CODE, TICKETTYPE AS TICKET_TYPE, OPENREASON AS OPEN_REASON
	-- , CLOSEREASON AS CLOSE_REASON
	, OPENREGION AS OPEN_REGION, STAGEREGION AS STAGE_REGION
	-- , CLOSEREGION AS CLOSE_REGION
	, opendate as OPEN_DATE 
	-- , CLOSEDATE AS CLOSE_DATE
	, FIRSTCOMMENTDATE AS FIRST_COMMENT_DATE
	, LASTCOMMENTDATE AS LAST_COMMENT_DATE
	, FIRSTCOMMENT AS FIRST_COMMENT
	, LASTCOMMENT AS LAST_COMMENT

	FROM 
	(
		(
		select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and (openreason='SURVEY' or StageRegion='TECHNICAL - SURVEY') order by opendate 
		)
		UNION ALL
		(
		select * from rcbill_my.clientticketsnapshot_f where CloseReason is null and (clientcode='I6') order by opendate
		)
	) A

);

-- select * from rcbill_my.rep_surveytickets;

/*
SELECT reportdate as REPORT_DATE, TICKETID AS TICKET_ID, CLIENTCODE AS CLIENT_CODE, CONTRACTCODE AS CONTRACT_CODE, TICKETTYPE AS TICKET_TYPE, OPENREASON AS OPEN_REASON
-- , CLOSEREASON AS CLOSE_REASON
, OPENREGION AS OPEN_REGION, STAGEREGION AS STAGE_REGION
-- , CLOSEREGION AS CLOSE_REGION
, opendate as OPEN_DATE 
-- , CLOSEDATE AS CLOSE_DATE
, FIRSTCOMMENTDATE AS FIRST_COMMENT_DATE
, LASTCOMMENTDATE AS LAST_COMMENT_DATE
, FIRSTCOMMENT AS FIRST_COMMENT
, LASTCOMMENT AS LAST_COMMENT

FROM 
(
	(
	select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and (openreason='SURVEY' or StageRegion='TECHNICAL - SURVEY') order by opendate 
	)
	UNION ALL
	(
	select * from rcbill_my.clientticketsnapshot_f where CloseReason is null and (clientcode='I6') order by opendate
	)
) A;

select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and openreason='INSTALLATION' 
and (StageRegion='TECHNICAL - NEW INSTALLATIONS') order by opendate ;

select * from rcbill_my.clientticketsnapshot_irs where CloseReason is null and openreason='INSTALLATION' 
and (StageRegion='TECHNICAL - PENDING INSTALLATIONS') order by opendate ;


select tickettype, openreason, StageRegion, date(opendate) as opendate, count(*) as tktcount from rcbill_my.clientticketsnapshot_irs where tickettype='Installation' and CloseReason is null 
group by tickettype, openreason, StageRegion, 4
order by 4	;
*/
/*
drop table if exists rcbill.clientvodstats;

create table rcbill.clientvodstats
(INDEX idxcvs1 (clientcode), INDEX idxcvs2(contractcode)) as
(
select a.*, b.clientcode, b.clientname, b.contractcode, b.mac , b.phoneno
from 
rcbill.tempvod a 
inner join 
rcbill.clientcontractdevices b 
on a.device=b.mac and a.device=b.phoneno
)
;
*/



/*
-- openreason: installation, installation done
-- closereason: Relocation, Relocation Done

select distinct openreason, count(*) from  rcbill_my.clientticketjourney group by 1 order by 1;
select distinct closereason,  count(*)  from  rcbill_my.clientticketjourney group by 1 order by 1;
select distinct tickettype,  count(*)  from  rcbill_my.clientticketjourney group by 1 order by 1;


select * from  rcbill_my.clientticketjourney 
where 
openreason in ('installation','Relocation')
and clientname like '%RAKESH RAI JUGOO%'
;

select * from  rcbill_my.clientticketjourney 
where
-- tickettype in ('installation','Relocation','Survey') 
tickettype in ('CreditNote') 
-- openreason in ('installation','Relocation')
-- and
-- clientname like '%chedanand%'
-- clientcode = 'I.000016294'
-- clientname like '%wolfgang%'
order by tickettype
;


select distinct clientcode, contractcode, openreason, closereason, min(opendate) as opendate, max(closedate) as closedate,max(commentdate) as lastcommentdate
from rcbill_my.clientticketjourney 
where
openreason in ('installation','Relocation')
and 
closereason in ('installation done','Relocation Done')
and 
ticketstate='closed'
-- and clientname like '%wolfgang%'
group by 
clientcode, contractcode, openreason, closereason

;


select clientcode, contractcode, comment, commentdate

from rcbill_my.clientticketjourney 
where
openreason in ('installation','Relocation')
and 
closereason in ('installation done','Relocation Done')
and 
ticketstate='closed'
group by comment, commentdate
;


select a.*, b.comment
		, datediff(a.closedate,a.opendate) as tkt_alldays
		, (5 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays

from 
(
	select distinct clientcode, contractcode, tickettype, openreason, closereason, min(opendate) as opendate, max(closedate) as closedate,max(commentdate) as lastcommentdate
	from rcbill_my.clientticketjourney 
	where
	TRIM(UPPER(tickettype)) in ('INSTALLATION','RELOCATION','SURVEY') 
	-- openreason in ('installation','Relocation')
	-- and 
	-- closereason in ('installation done','Relocation Done')
    -- tickettype in ('installation','Relocation','Survey') 
    -- and 
	-- ticketstate='closed'
	-- and clientname like '%wolfgang%'
	group by 
	clientcode, contractcode, openreason, closereason
) a 
left join
(
	select clientcode, contractcode, comment, commentdate

	from rcbill_my.clientticketjourney 
	where
	TRIM(UPPER(tickettype)) in ('INSTALLATION','RELOCATION','SURVEY') 
	-- openreason in ('installation','Relocation')
	-- and 
	-- closereason in ('installation done','Relocation Done')
	group by comment, commentdate
) b 
on 
a.lastcommentdate=b.commentdate
and
a.clientcode=b.clientcode
and
a.contractcode=b.contractcode
order by a.opendate
;


select a.*, b.comment
		-- , datediff(a.closedate,a.opendate) as tkt_alldays
		-- , (5 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays

from 
(
	select distinct clientcode, contractcode, tickettype, openreason, closereason, min(opendate) as opendate, max(closedate) as closedate,max(commentdate) as lastcommentdate
	from rcbill_my.clientticketjourney 
	where
	trim(upper(tickettype)) in ('FAULT') 
	group by 
	clientcode, contractcode, openreason, closereason
) a 
left join
(
	select clientcode, contractcode, comment, commentdate
	from rcbill_my.clientticketjourney 
	where
	trim(upper(tickettype)) in ('FAULT') 
	group by clientcode, contractcode, comment, commentdate
    order by clientcode, contractcode, commentdate
) b 
on 
a.lastcommentdate=b.commentdate
and
a.clientcode=b.clientcode
and
a.contractcode=b.contractcode
order by a.opendate
;


select distinct ticketid, clientname, clientcode, contractcode, service, tickettype, ticketstate, opendate, opentechregion
, stagetechregion, closedate, closetechregion
from  rcbill_my.clientticketjourney where ticketid in (861539) 
;

select commentdate, commentuser, comment 
from  rcbill_my.clientticketjourney where ticketid in (861539) 
order by commentdate
;
	select distinct ticketid, tickettype,service, opendate, openreason, closedate, closereason,visitcount, worktime, clientname, clientcode, count(*) as comments, min(commentdate) as firstcommentdate, max(commentdate) as lastcommentdate
	from  rcbill_my.clientticketjourney
    where clientcode='I.000007057'
	group by  ticketid, tickettype,service, opendate, openreason, closedate, closereason, worktime, clientname, clientcode
    order by ticketid, opendate
    ;
    
    

select a.comment,b.*
from rcbill_my.clientticketjourney a
join
(
	select distinct ticketid, tickettype,service, opendate, openreason, closedate, closereason, worktime, clientname, clientcode, min(commentdate) as firstcommentdate, max(commentdate) as lastcommentdate
	from  rcbill_my.clientticketjourney
	group by  ticketid, tickettype,service, opendate, openreason, closedate, closereason, worktime, clientname, clientcode
) b
on 
a.ticketid=b.ticketid
and
(
a.commentdate=b.firstcommentdate
or
a.commentdate=b.lastcommentdate
)
;
*/