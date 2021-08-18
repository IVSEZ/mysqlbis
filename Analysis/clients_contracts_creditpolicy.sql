use rcbill_my;

-- DURATION 13.438 sec / 22818.187 sec
-- select * from rcbill_my.cus
set @period = '2021-07-21';

-- select * from rcbill.clientcontracts limit 1000;

-- select * from rcbill.clientcontractsservicepackageprice where 

drop temporary table if exists a;
create temporary table a (INDEX idxa1 (CL_CLIENTCODE), INDEX idxa2 (CON_CONTRACTCODE), INDEX idxa3 (S_SERVICENAME), INDEX idxa4 (VPNR_SERVICETYPE)) as 
(
	select a.*
    ,upper(b.name) as CREDITPOLICYNAME, upper(c.name) as RATINGPLANNAME
	from 
	-- rcbill.clientcontracts a
    (
		select
		CL_CLIENTID, CL_CLIENTNAME, upper(CL_CLIENTCODE) as CL_CLIENTCODE, CL_CLTYPE, CL_CLCLASS, CL_CLCLASSNAME
        , CON_CONTRACTID, upper(CON_CONTRACTCODE) as CON_CONTRACTCODE, CON_CONTRACTDATE, CON_CLIENTID, CON_STARTDATE
        , CON_ENDDATE, CON_CREDITPOLICYID, CON_RATINGPLANID, CON_ACTIVE, CON_CONTRACTTYPE, CON_LASTACTIONID
        , CON_PPCARD, CON_TEMPLATE, CON_TEMPACTIVATESTARTDATE, CON_TEMPACTIVATEENDDATE, RD_CONTRACTID, RDT_DEVICENAME
        , INSERTEDON, REPORTDATE, CS_SERVICEID, upper(S_SERVICENAME) as S_SERVICENAME, CS_SERVICERATEID, CS_SUBSCRIPTIONCOUNT
        , upper(VPNR_SERVICETYPE) as VPNR_SERVICETYPE, VPNR_SERVICEPRICE, CONTRACTCURRENTSTATUS, CONPERIOD2, CONPERIOD
        from rcbill.clientcontracts
    ) a 
	left join
	rcbill.rcb_creditpolicy b
	on a.con_creditpolicyid=b.id
	left join
	rcbill.rcb_ratingplans c 
	on a.con_ratingplanid=c.id
);

-- select * from a where cl_clientcode='I10952';

drop temporary table if exists b;
create temporary table b (INDEX idxb1 (clientcode), INDEX idxb2 (contractcode), INDEX idxb3 (service), INDEX idxb4 (package) ) as 
(
	select  
    period, periodday, periodmth, PERIODYEAR, upper(clientcode) as clientcode, upper(clientname) as clientname
    , clientclass, clienttype, representative, clientaddress, cl_location, cl_area, cl_areaname, cl_latitude
    , cl_longitude, upper(contractcode) as contractcode, contractaddress, con_location, con_area, con_areaname
    , con_latitude, con_longitude, upper(SERVICE) as SERVICE, servicecategory, servicecategory2, servicesubcategory
    , upper(package) as package, price, region, ACTIVECOUNT, DEVICESCOUNT, REPORTED, Network
    from rcbill_my.customercontractactivity where period=@period and REPORTED='Y'
);



select a.*, b.*
from 
 b
left join 
 a
on 
a.CL_CLIENTCODE=b.clientcode
and 
a.CON_CONTRACTCODE=b.contractcode
and
a.S_SERVICENAME=b.SERVICE
and 
a.VPNR_SERVICETYPE=b.package

/*
on 
upper(a.CL_CLIENTCODE)=upper(b.clientcode)
and 
upper(a.CON_CONTRACTCODE)=upper(b.contractcode)
and
upper(a.S_SERVICENAME)=upper(b.SERVICE)
and 
upper(a.VPNR_SERVICETYPE)=upper(b.package)
*/
;


	select b.*,
    a.VPNR_SERVICETYPE, a.VPNR_SERVICEPRICE, a.CREDITPOLICYNAME, a.RATINGPLANNAME
	from 
	 b
	left join 
	 a
	on 
	a.CL_CLIENTCODE=b.clientcode
	and 
	a.CON_CONTRACTCODE=b.contractcode
	and
	a.S_SERVICENAME=b.SERVICE
	and 
	a.VPNR_SERVICETYPE=b.package
;

