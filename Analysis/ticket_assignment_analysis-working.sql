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