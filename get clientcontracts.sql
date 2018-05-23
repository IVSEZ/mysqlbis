/*
select count(*) from rcb_tclients;
select count(*) from rcb_contracts;
select * from rcb_tclients;


 
select * from rcb_contracts where clid in (723711);

select * from rcb_contracts where kod='I.000231307';

select 
CL.ID as CL_CLIENTID
,CL.FIRM as CL_CLIENTNAME
,CL.KOD as CL_CLIENTCODE

 from rcb_tclients CL;

select * from rcb_contracts limit 100;
select 
CON.ID AS CON_CONTRACTID
,CON.KOD AS CON_CONTRACTCODE
,CON.DATA AS CON_CONTRACTDATE
,CON.CLID AS CON_CLIENTID
,CON.STARTDATE AS CON_STARTDATE
,CON.ENDDATE AS CON_ENDDATE
,CON.ACTIVE AS CON_ACTIVE
,CON.CONTRACTTYPE AS CON_CONTRACTTYPE
,CON.LASTACTIONID as CON_LASTACTIONID

from
rcb_contracts CON;
*/
select distinct reportdate from rcb_tclients;
select distinct reportdate from rcb_casa;
select distinct reportdate from rcb_contracts;
select distinct reportdate from rcb_contractservices;
select distinct reportdate from rcb_invoicesheader;
select distinct reportdate from rcb_invoicescontents;

## SCRIPT STARTS

drop table if exists clientcontracts;


CREATE TABLE IF NOT EXISTS clientcontracts AS (
SELECT
CL.ID as CL_CLIENTID
,CL.FIRM as CL_CLIENTNAME
,CL.KOD as CL_CLIENTCODE
,CL.CLTYPE as CL_CLTYPE
,CL.CLClass as CL_CLCLASS
,CLC.NAME as CL_CLCLASSNAME

,CON.ID AS CON_CONTRACTID
,CON.KOD AS CON_CONTRACTCODE
,CON.DATA AS CON_CONTRACTDATE
,CON.CLID AS CON_CLIENTID
,CON.STARTDATE AS CON_STARTDATE
,CON.ENDDATE AS CON_ENDDATE
-- ,DATEDIFF(CON.ENDDATE,CON.STARTDATE) as CONPERIOD


,CON.ACTIVE AS CON_ACTIVE
,CON.CONTRACTTYPE AS CON_CONTRACTTYPE
,CON.LASTACTIONID as CON_LASTACTIONID
,CON.PPCard as CON_PPCARD
,CON.Template as CON_TEMPLATE
,CON.TempActivateStartDate as CON_TEMPACTIVATESTARTDATE
,CON.TempActivateEndDate as CON_TEMPACTIVATEENDDATE
,NOW() as INSERTEDON
-- ,str_to_date('2017-01-19','%Y-%m-%d') as REPORTDATE
,@REPORTDATE as REPORTDATE

,CS.serviceid as CS_SERVICEID
,S.NAME as S_SERVICENAME
,CS.ServiceRateID as CS_SERVICERATEID
,VPNR.Name as VPNR_SERVICETYPE
,VPNR.Price as VPNR_SERVICEPRICE

,CASE  
    WHEN CON.LASTACTIONID IN (1,10,11,15,19,2,3,9) THEN 'ACTIVE'
    WHEN CON.LASTACTIONID IN (21,22) and ((@REPORTDATE BETWEEN CON.STARTDATE AND CON.ENDDATE)) THEN 'VALID BUT DEACTIVATED'
    WHEN CON.LASTACTIONID IN (21,22) and ((@REPORTDATE  BETWEEN CON.TempActivateStartDate AND CON.TempActivateEndDate)) THEN 'TEMP ACTIVATED'    
	WHEN CON.LASTACTIONID IN (0,12,13,14,20,30,31,33,34,35,39,5,6,7,8,9,22) and ((@REPORTDATE BETWEEN CON.STARTDATE AND CON.ENDDATE)) THEN 'VALID BUT DEACTIVATED'
-- 	WHEN CON.LASTACTIONID IN (0,12,13,14,20,30,31,33,34,35,39,5,6,7,8,9,22) THEN 'INACTIVE'
    ELSE 'INACTIVE' END as CONTRACTCURRENTSTATUS

,CASE 
	WHEN (S.NAME like '%subscription%' and VPNR.NAME not like '%only%') or (S.NAME is null)
    THEN 
		CASE
			WHEN CON.EndDate is not null then DATEDIFF(CON.ENDDATE,CON.STARTDATE)
			WHEN CON.EndDate is null and CS.UpdDate<@REPORTDATE then DATEDIFF(CS.UpdDate,CON.STARTDATE)
			ELSE DATEDIFF(@REPORTDATE,CON.STARTDATE)
        END
	ELSE 0 
    END as CONPERIOD
 from 
 rcb_tclients CL
 LEFT JOIN
rcb_contracts CON 

ON
CL.ID=CON.CLID


LEFT JOIN 
rcb_contractservices CS
on
CON.ID=CS.CID


LEFT JOIN 
rcb_clientclasses CLC
on
CL.CLClass=CLC.ID


LEFT JOIN
rcb_services S
on CS.ServiceID=S.ID

LEFT JOIN
rcb_vpnrates VPNR
on CS.ServiceRateID=VPNR.ID

WHERE CON.PPCard=0 and CON.Template=0

order by
CL_CLIENTNAME,
CON_CONTRACTCODE,
CON_STARTDATE
);

-- drop index IDXClientContracts on clientcontracts;

CREATE INDEX IDXClientContracts1
ON clientcontracts (CL_CLIENTID);
CREATE INDEX IDXClientContracts2
ON clientcontracts (CON_CONTRACTID);
CREATE INDEX IDXClientContracts3
ON clientcontracts (CL_CLIENTNAME);
CREATE INDEX IDXClientContracts4
ON clientcontracts (CL_CLIENTCODE);
CREATE INDEX IDXClientContracts5
ON clientcontracts (CON_CONTRACTCODE);
CREATE INDEX IDXClientContracts6
ON clientcontracts (S_SERVICENAME);

-- select * from clientcontracts ;
-- select distinct (con_lastactionid), count(*) from clientcontracts group by con_lastactionid order by 2 desc;
-- select distinct (CONTRACTCURRENTSTATUS), count(*) from clientcontracts group by CONTRACTCURRENTSTATUS order by 2 desc;

select * from clientcontracts;-- where CONTRACTCURRENTSTATUS='ACTIVE';
/*
select * from clientcontracts where conperiod is null;

select a.*,b.NAME as CL_CLCLASSNAME, c.NAME as S_SERVICENAME
from 
clientcontracts a
left join
rcb_clientclasses b
on
a.CL_CLCLASS=b.ID

left join
rcb_services c 
on
a.CS_SERVICEID=c.ID
;
*/

drop table clientcontractssummary;
CREATE TABLE IF NOT EXISTS clientcontractssummary AS (
SELECT distinct a.CL_CLIENTNAME, a.CL_CLIENTCODE, a.CONTRACTCURRENTSTATUS, a.CON_LASTACTIONID, b.Value as LASTACTION ,
count(a.CON_CONTRACTID) as Contract_count, min(a.CON_STARTDATE) as first_startdate, max(a.CON_ENDDATE) as last_enddate
,NOW() as INSERTEDON
,@REPORTDATE as REPORTDATE
from 
clientcontracts a 
left join
rcb_contractslastaction b
on 
a.CON_LASTACTIONID=b.ID

/*
where
a.CL_CLIENTNAME not like 'PREPAID%'
and
a.CL_CLIENTNAME not like '%PREPAID%'
and
a.CL_CLIENTNAME not like 'TEST%'
and
a.CL_CLIENTNAME != 'PREPAID CARDS'
*/
group by a.CL_CLIENTNAME, a.CL_CLIENTCODE, a.CONTRACTCURRENTSTATUS, a.CON_LASTACTIONID, LASTACTION
order by CL_CLIENTNAME, CL_CLIENTCODE, first_startdate
)
;

drop table clientcontractssummary2;

CREATE TABLE IF NOT EXISTS clientcontractssummary2 AS (
SELECT distinct a.CL_CLIENTNAME, a.CL_CLIENTCODE, a.CONTRACTCURRENTSTATUS, 
count(a.CON_CONTRACTID) as Contract_count, min(a.CON_STARTDATE) as first_startdate, max(a.CON_ENDDATE) as last_enddate
,NOW() as INSERTEDON
,@REPORTDATE as REPORTDATE


from 
clientcontracts a 
left join
rcb_contractslastaction b
on 
a.CON_LASTACTIONID=b.ID


group by a.CL_CLIENTNAME, a.CL_CLIENTCODE, a.CONTRACTCURRENTSTATUS
order by CL_CLIENTNAME, CL_CLIENTCODE, first_startdate
)
;

select * from clientcontracts;
select * from clientcontracts where S_SERVICENAME like '%SUBSCRIPTION%' or S_SERVICENAME is null;



select * from clientcontracts where CON_TEMPACTIVATESTARTDATE BETWEEN '2016-7-1' and '2016-7-31' and S_SERVICENAME like '%subscription%';
select * from clientcontracts where CON_TEMPACTIVATESTARTDATE BETWEEN '2016-8-1' and '2016-8-31' and S_SERVICENAME like '%subscription%';
select * from clientcontracts where CON_TEMPACTIVATESTARTDATE BETWEEN '2016-9-1' and '2016-9-30' and S_SERVICENAME like '%subscription%';
select * from clientcontracts where CON_TEMPACTIVATESTARTDATE BETWEEN '2016-10-1' and '2016-10-31' and S_SERVICENAME like '%subscription%';
select * from clientcontracts where CON_TEMPACTIVATESTARTDATE BETWEEN '2016-11-1' and '2016-11-30' and S_SERVICENAME like '%subscription%';
select * from clientcontracts where CON_TEMPACTIVATESTARTDATE BETWEEN '2016-12-1' and '2016-12-31' and S_SERVICENAME like '%subscription%';
select * from clientcontracts where CON_TEMPACTIVATESTARTDATE BETWEEN '2016-7-1' and '2016-12-31' and S_SERVICENAME like '%subscription%';





select * from clientcontractssummary;
select * from clientcontractssummary2;



/*
select * from clientcontracts where CL_CLIENTID in (723013,668796)
order by CL_CLIENTID
;

select * from clientcontracts where CON_CONTRACTCODE in ('I60746.1');

select distinct(s_servicename) from clientcontracts;
select * from clientcontracts where S_SERVICENAME is null;
*/

/*
select * from rcb_contractservices where cid in (select CON_CONTRACTID from clientcontracts where S_SERVICENAME is null);
select a.*, b.serviceid , b.cid
from 
clientcontracts a
left join
rcb_contractservices b
on a.CON_CONTRACTID=b.CID
where 
a.S_SERVICENAME is null;
*/
/*
select * from rcb_contractservices where cid in (1301466);
select * from rcb_contracts where ID in (1301466);
select * from clientcontracts where CON_CONTRACTID in (1301466);

select count(*) from clientcontracts;

select count(*) from rcb_contracts;
select count(*) from rcb_contracts WHERE PPCard=0 and Template=0 ;

*/