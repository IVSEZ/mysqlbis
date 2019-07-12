#FOR Daily calls script
SET @date1='2019-06-05';
SET @date2='2019-06-06';

select * from rcbill_my.callstats;

select * from rcbill_my.ccrota;

select * from rcbill_my.callingclients where callnumber=2781089;
select * from rcbill_my.dailycalls where CALLNUMBER=2781089;


	select a.calldate, a.callnumber, a.callqueuename, a.callagent, a.calleventname, a.waittime, a.talktime from 
    -- select * from 
	rcbill_my.dailycalls a 
	where
	-- (a.calldate>@date1 and a.calldate<@date2)
	-- and
	(a.callnumber not in ('4414243','anonymous')) and (length(a.callnumber)>3)
;


use rcbill_my;
drop temporary table if exists a;
create temporary table a as
(
	select a.calldate, a.callnumber, a.callqueuename, a.callagent, a.calleventname, a.waittime, a.talktime from 
    -- select * from 
	rcbill_my.dailycalls a 
	where
	-- (a.calldate>@date1 and a.calldate<@date2)
	-- and
	(a.callnumber not in ('4414243','anonymous')) and (length(a.callnumber)>3)
)
;
drop temporary table if exists b;
create temporary table b as
(
select firm, kod, mphone from rcbill.rcb_clientphones a where (a.mphone not in ('4414243','anonymous')) and (length(a.mphone)>3)
)
;

create table rcbill_my.callingclients2 as 
(
	SELECT 
	DATE(a.calldate) AS CAll_DATE,
	TIME(a.calldate) AS CAll_TIME,
	a.calldate AS calldatetime,
	a.callnumber,
	a.callqueuename,
	a.callagent,
	a.calleventname,
	a.waittime,
	a.talktime,
	b.firm,
	b.kod,
	b.mphone   
    
    
FROM
    a
        LEFT JOIN
    b ON b.mphone LIKE CONCAT('%', a.callnumber, '%')
ORDER BY a.calldate
)
;




select count(*) as callingclientsafter from rcbill_my.callingclients2;



##### 
-- RENAME OLD TABLE
rename table rcbill_my.callingclients to rcbill_my.callingclients1;


rename table rcbill_my.callingclients2 to rcbill_my.callingclients;


select count(*) as callingclientsafter from rcbill_my.callingclients;

CREATE INDEX IDXcclients1
ON rcbill_my.callingclients (calldatetime);

CREATE INDEX IDXcclients2
ON rcbill_my.callingclients (KOD);

CREATE INDEX IDXcclients3
ON rcbill_my.callingclients (FIRM);

CREATE INDEX IDXcclients4
ON rcbill_my.callingclients (callnumber);

show index from rcbill_my.callingclients ;

select * from rcbill_my.callingclients where firm like '%dolores tirant%';



##### call detail report for one customer
SELECT 
    kod AS clientcode,
    firm AS clientname,
    calldatetime AS calldate,
    shiftday,
    shift,
    callnumber AS callernumber,
    waittime,
    calleventname AS callstatus,
    (SELECT 
            CCAgent
        FROM
            rcbill_my.ccrota
        WHERE
            ccdate = CALL_DATE AND CCSHIFT = shift
                AND CCNUMBER = callagent) AS ccagent,
    talktime
FROM
    (SELECT 
        *,
            rcbill_my.GetShiftName(calldatetime) AS shift,
            rcbill_my.GetWeekdayName(WEEKDAY(DATE(calldatetime))) AS shiftday
    FROM
        rcbill_my.callingclients
    WHERE
        kod = 'I.000009236'
    ORDER BY calldatetime DESC) a
ORDER BY calldatetime DESC
;



#################for all customers

drop temporary table if exists tempccl1;

create temporary table tempccl1
(index idxtccl1(call_date), index idxtccl2(shift), index idxtccl3(callnumber) )
as
(
	SELECT 
			*,
				rcbill_my.GetShiftName(calldatetime) AS shift,
				rcbill_my.GetWeekdayName(WEEKDAY(DATE(calldatetime))) AS shiftday
		FROM
			rcbill_my.callingclients
		-- WHERE
		--    kod = 'I.000009236'
		ORDER BY calldatetime DESC
);

drop table if exists rcbill_my.rep_cccallreport;

create table rcbill_my.rep_cccallreport 
(index idxrccr1(calldate), index idxrccr2(clientcode), index idxrccr3(clientname), index idxrccr4(callernumber), index idxrccr5(ccagent))
as 
(
SELECT 
    a.kod AS clientcode,
    a.firm AS clientname,
    a.calldatetime AS calldate,
    a.shiftday,
    a.shift,
    a.callnumber AS callernumber,
    a.waittime,
    a.calleventname AS callstatus,
	b.ccagent AS ccagent,
    a.callagent,
    a.talktime
FROM
    tempccl1 a
    
    left join 
    
    rcbill_my.ccrota b 
    on 
    a.call_date=b.ccdate
    and a.shift=b.ccshift
    and a.callagent=b.ccnumber
ORDER BY a.calldatetime DESC
)
;
########################################################################

select * from rcbill_my.rep_cccallreport where clientcode='I.000009236';
