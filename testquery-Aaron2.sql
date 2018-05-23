SELECT 
CL.ID AS CL_CLIENTID,
CL.FIRM AS CL_CLIENTNAME,
CL.KOD AS CL_CLIENTCODE,
CL.DANNO AS CL_SSN,
CL.PASSNO AS CL_PASSPORT,
CL.ADDRESS AS CL_ADDRESS,
CL.MPHONE AS CL_PHONE,
CL.BEGDATE AS CL_STARTDATE,
CL.CLTYPE AS CL_CLIENTTYPE,
CL.CLCLASS AS CL_CLIENTCLASS,
CL.ACTIVE AS CL_CLIENTACTIVE,

CON.ID AS CON_CONTRACTID,
CON.KOD AS CON_CONTRACTCODE,
CON.CLID AS CON_CLIENTID,
CON.STARTDATE AS CON_STARTDATE,
CON.ENDDATE AS CON_ENDDATE,
CON.RATINGPLANID AS CON_RATINGPLANID,
CON.ACTIVE AS CON_ACTIVE,
CON.CREDITPOLICYID AS CON_CREDITPOLICYID,

CONSER.CID AS CONSER_CONTRACTID,
CONSER.SERVICEID AS CONSER_SERVICEID,
CONSER.SERVICERATEID AS CONSER_SERVICERATEID,
CONSER.STARTDATE AS CONSER_STARTDATE,

SER.ID AS SER_SERVICEID,
SER.NAME AS SER_SERVICENAME,
SER.INSTATISTICS AS SER_INSTATISTICS,

VPNR.ID AS VPNR_SERVICERATEID,
VPNR.RATINGPLANID AS VPNR_RATINGPLANID,
VPNR.SERVICEID AS VPNR_SERVICEID,
VPNR.NAME AS VPNR_SERVICENAME,
VPNR.PERIOD AS VPNR_PERIOD,
VPNR.PRICE AS VPNR_PRICE,
VPNR.POST AS VPNR_POST,


CASA.PAYOBJECTID AS CASA_PAYOBJECTID,
CASA.PAYTYPE*-1 AS CASA_SERVICEID,
CASA.CASHPOINTID AS CASA_CASHPOINTID,
CASA.CLID AS CASA_CLIENTID,
CASA.CID AS CASA_CONTRACTID,
CASA.PAYDATE AS CASA_PAYDATE,
CASA.ENTERDATE AS CASA_PAYDATE2,
CASA.MONEY AS CASA_PAYAMOUNT,
CASA.INVID AS CASA_INVOICEID,
CASA.BEGDATE AS CASA_SUBSTARTDATE,
CASA.ENDDATE AS CASA_SUBENDDATE,
CASA.RSID AS CASA_SERVICERATEID

FROM 

rcb_tclients as CL
inner join
rcb_contracts as CON
on
CL.ID=CON.CLID

inner join
rcb_contractservices as CONSER
on
CON.ID=CONSER.CID

inner join
rcb_services as SER
on
-- CONSER_SERVICEID=SER_SERVICEID
CONSER.SERVICEID=SER.ID

inner join
rcb_vpnrates as VPNR
on
-- CONSER_SERVICERATEID=VPNR_SERVICERATEID
CONSER.SERVICERATEID=VPNR.ID


inner join
rcb_casa as CASA
on 
-- CON_CONTRACTID=CASA_CONTRACTID
CON.ID=CASA.CID


where
CL.ID=698681


-- ============================================================================================================================
-- 723711
-- 723013
select * from rcb_tclients where id=702931;
select * from rcb_contracts where clid in (select distinct id from rcb_tclients where id=702931);
-- select * from rcb_casa where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=723711)) order by begdate;
select * from rcb_contractservices where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=702931)) order by startdate;
-- select * from rcb_contractservices where serviceid in (select distinct paytype*-1 from rcb_casa where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=723013)) ) order by startdate;


 select * from rcb_services where id in (select distinct serviceid from rcb_contractservices where cid in (select distinct ID from rcb_contracts where clid IN (select distinct id from rcb_tclients where id=702931)));
-- select * from rcb_vpnrates where id in (select distinct ServiceRateID from rcb_contractservices where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=723013)));
-- select * from rcb_invoicesheader where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=723013)) order by data, invoiceno, begdate;

-- select * from rcb_invoicescontents where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=723013)) order by upddate, invoiceno, fromdate;
-- select * from rcb_invoicescontents where invoiceid in (select id from rcb_invoicesheader where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=723013))) order by upddate, invoiceno, fromdate; 

-- select * from rcb_invoicesheader where clid in (723711) order by data, invoiceno, begdate;
-- select * from rcb_invoicesheader where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=723013)) order by data, invoiceno, begdate;
-- select * from rcb_invoicescontents where invoiceid in (select id from rcb_invoicesheader where clid in (723013)) order by upddate, invoiceno, fromdate; 
select * from rcb_invoicescontents where cid in (select distinct id from rcb_contracts where clid in (select distinct id from rcb_tclients where id=723013)) order by upddate, invoiceno, fromdate; 
select * from rcb_invoicesheader where id in (select distinct invoiceid from rcb_invoicescontents where cid in (select distinct id from rcb_contracts where clid in (select distinct id from rcb_tclients where id=723013))) order by data, invoiceno, begdate;

-- 719551
select * from rcb_tclients where id=719551;
select * from rcb_contracts where clid in (select distinct id from rcb_tclients where id=719551);
select * from rcb_contractservices where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=719551)) order by cid;
select * from rcb_vpnrates where id in (select distinct ServiceRateID from rcb_contractservices where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=719551)));



SELECT
CL.ID as CL_CLIENTID
,CL.FIRM as CL_CLIENTNAME
,CL.KOD as CL_CLIENTCODE
,CL.CLTYPE as CL_CLTYPE
,CL.CLClass as CL_CLCLASS
-- ,CLC.NAME as CL_CLCLASSNAME

,CON.ID AS CON_CONTRACTID
,CON.KOD AS CON_CONTRACTCODE
,CON.DATA AS CON_CONTRACTDATE
,CON.CLID AS CON_CLIENTID
,CON.STARTDATE AS CON_STARTDATE
,CON.ENDDATE AS CON_ENDDATE
,CON.ACTIVE AS CON_ACTIVE
,CON.CONTRACTTYPE AS CON_CONTRACTTYPE
,CON.LASTACTIONID as CON_LASTACTIONID
,CON.PPCard as CON_PPCARD
,CON.Template as CON_TEMPLATE
,CON.TempActivateStartDate as CON_TEMPACTIVATESTARTDATE
,CON.TempActivateEndDate as CON_TEMPACTIVATEENDDATE
,NOW() as INSERTEDON
,'2016-12-13' as REPORTDATE

 ,CS.serviceid as CS_SERVICEID
-- ,S.NAME as S_SERVICENAME

,CASE  
    WHEN CON.LASTACTIONID IN (1,10,11,15,19,2,3,9) THEN 'ACTIVE'
    WHEN CON.LASTACTIONID IN (21,22) and (('2016-12-13' BETWEEN CON.STARTDATE AND CON.ENDDATE)) THEN 'VALID BUT DEACTIVATED'
    WHEN CON.LASTACTIONID IN (21,22) and (('2016-12-13' BETWEEN CON.TempActivateStartDate AND CON.TempActivateEndDate)) THEN 'TEMP ACTIVATED'    
	WHEN CON.LASTACTIONID IN (0,12,13,14,20,30,31,33,34,35,39,5,6,7,8,9,22) and (('2016-12-13' BETWEEN CON.STARTDATE AND CON.ENDDATE)) THEN 'VALID BUT DEACTIVATED'
-- 	WHEN CON.LASTACTIONID IN (0,12,13,14,20,30,31,33,34,35,39,5,6,7,8,9,22) THEN 'INACTIVE'
    ELSE 'INACTIVE' END as CONTRACTCURRENTSTATUS

 from 
 rcb_tclients CL
/*
LEFT JOIN 
rcb_clientclasses CLC
on
CL.CLClass=CLC.ID 
 */
LEFT JOIN
rcb_contracts CON 
ON
CL.ID=CON.CLID



LEFT JOIN 
rcb_contractservices CS
on
CON.ID=CS.CID

/*
LEFT JOIN
rcb_services S
on CS.ServiceID=S.ID
*/

WHERE CL.ID=719551 and CON.PPCard=0 and CON.Template=0

order by
CL_CLIENTNAME,
CON_CONTRACTCODE,
CON_STARTDATE;



-- select * from rcb_ratingplans where id in (select distinct RatingPlanID from rcb_vpnrates where id in (select distinct ServiceRateID from rcb_contractservices where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=723711))));
-- select * from rcb_ratingplans where id in (840,838);

-- ===================================================
SELECT 
CL.ID AS CL_CLIENTID,
CL.FIRM AS CL_CLIENTNAME,
CL.KOD AS CL_CLIENTCODE,
CL.DANNO AS CL_SSN,
CL.PASSNO AS CL_PASSPORT,
CL.ADDRESS AS CL_ADDRESS,
CL.MPHONE AS CL_PHONE,
CL.BEGDATE AS CL_STARTDATE,
CL.CLTYPE AS CL_CLIENTTYPE,
CL.CLCLASS AS CL_CLIENTCLASS,
CL.ACTIVE AS CL_CLIENTACTIVE,

CON.ID AS CON_CONTRACTID,
CON.KOD AS CON_CONTRACTCODE,
CON.CLID AS CON_CLIENTID,
CON.STARTDATE AS CON_STARTDATE,
CON.ENDDATE AS CON_ENDDATE,
CON.RATINGPLANID AS CON_RATINGPLANID,
CON.ACTIVE AS CON_ACTIVE,
CON.CREDITPOLICYID AS CON_CREDITPOLICYID,



CASA.PAYOBJECTID AS CASA_PAYOBJECTID,
CASA.PAYTYPE*-1 AS CASA_SERVICEID,
CASA.CASHPOINTID AS CASA_CASHPOINTID,
CASA.CLID AS CASA_CLIENTID,
CASA.CID AS CASA_CONTRACTID,
CASA.PAYDATE AS CASA_PAYDATE,
CASA.ENTERDATE AS CASA_PAYDATE2,
CASA.MONEY AS CASA_PAYAMOUNT,
CASA.INVID AS CASA_INVOICEID,
CASA.BEGDATE AS CASA_SUBSTARTDATE,
CASA.ENDDATE AS CASA_SUBENDDATE,
CASA.RSID AS CASA_SERVICERATEID,


CONSER.CID AS CONSER_CONTRACTID,
CONSER.SERVICEID AS CONSER_SERVICEID,
CONSER.SERVICERATEID AS CONSER_SERVICERATEID,
CONSER.STARTDATE AS CONSER_STARTDATE,
CONSER.ENDDATE AS CONSER_ENDDATE,


-- (select SERVICERATEID AS CONSER_SERVICERATEID from rcb_contractservices as CONSER where CONSER.CID=CASA.CID and CONSER.SERVICEID=-(CASA.PAYTYPE)) as CONSER_SERVICERATEID



SER.ID AS SER_SERVICEID,
SER.NAME AS SER_SERVICENAME,
SER.INSTATISTICS AS SER_INSTATISTICS,

VPNR.ID AS VPNR_SERVICERATEID,
VPNR.RATINGPLANID AS VPNR_RATINGPLANID,
VPNR.SERVICEID AS VPNR_SERVICEID,
VPNR.NAME AS VPNR_SERVICENAME,
VPNR.PERIOD AS VPNR_PERIOD,
VPNR.PRICE AS VPNR_PRICE,
VPNR.POST AS VPNR_POST

FROM 

rcb_tclients as CL
left join
rcb_contracts as CON
on
CL.ID=CON.CLID

left join
rcb_contractservices as CONSER
on
(CASA.CID=CONSER.CID and -(CASA.PAYTYPE)=CONSER.SERVICEID) -- and CASA.PAYDATE=CONSER.STARTDATE)


left join
rcb_casa as CASA
on 
-- CON_CONTRACTID=CASA_CONTRACTID
CON.ID=CASA.CID







LEFT join
rcb_services as SER
on
-- CONSER_SERVICEID=SER_SERVICEID
CONSER.SERVICEID=SER.ID

LEFT join
rcb_vpnrates as VPNR
on
-- CONSER_SERVICERATEID=VPNR_SERVICERATEID
CONSER.SERVICERATEID=VPNR.ID

where
 CL.ID=723711
-- CL.ID=698681
-- and 
-- SER.INSTATISTICS=1

order by CON_CONTRACTID, CON_STARTDATE, CASA_PAYDATE


-- ========================================================

SELECT 
CL.ID AS CL_CLIENTID,
CL.FIRM AS CL_CLIENTNAME,
CL.KOD AS CL_CLIENTCODE,
CL.DANNO AS CL_SSN,
CL.PASSNO AS CL_PASSPORT,
CL.ADDRESS AS CL_ADDRESS,
CL.MPHONE AS CL_PHONE,
CL.BEGDATE AS CL_STARTDATE,
CL.CLTYPE AS CL_CLIENTTYPE,
CL.CLCLASS AS CL_CLIENTCLASS,
CL.ACTIVE AS CL_CLIENTACTIVE,

CON.ID AS CON_CONTRACTID,
CON.KOD AS CON_CONTRACTCODE,
CON.CLID AS CON_CLIENTID,
CON.STARTDATE AS CON_STARTDATE,
CON.ENDDATE AS CON_ENDDATE,
CON.RATINGPLANID AS CON_RATINGPLANID,
CON.ACTIVE AS CON_ACTIVE,
CON.CREDITPOLICYID AS CON_CREDITPOLICYID,



CASA.PAYOBJECTID AS CASA_PAYOBJECTID,
CASA.PAYTYPE*-1 AS CASA_SERVICEID,
CASA.CASHPOINTID AS CASA_CASHPOINTID,
CASA.CLID AS CASA_CLIENTID,
CASA.CID AS CASA_CONTRACTID,
CASA.PAYDATE AS CASA_PAYDATE,
CASA.ENTERDATE AS CASA_PAYDATE2,
CASA.MONEY AS CASA_PAYAMOUNT,
CASA.INVID AS CASA_INVOICEID,
CASA.BEGDATE AS CASA_SUBSTARTDATE,
CASA.ENDDATE AS CASA_SUBENDDATE,
CASA.RSID AS CASA_SERVICERATEID



FROM 

rcb_tclients as CL
left join
rcb_contracts as CON
on
CL.ID=CON.CLID

/*
left join
rcb_contractservices as CONSER
on
(CASA.CID=CONSER.CID and -(CASA.PAYTYPE)=CONSER.SERVICEID) -- and CASA.PAYDATE=CONSER.STARTDATE)
*/

left join
rcb_casa as CASA
on 
-- CON_CONTRACTID=CASA_CONTRACTID
CON.ID=CASA.CID



 where
 CL.ID=723711
-- CL.ID=698681
-- and 
-- SER.INSTATISTICS=1

order by CL.FIRM, CON_CONTRACTID, CON_STARTDATE, CASA_PAYDATE 