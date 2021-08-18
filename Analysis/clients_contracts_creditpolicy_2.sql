use rcbill_my;

-- DURATION 13.438 sec / 22818.187 sec
-- select * from rcbill_my.cus


#set @period = '2021-07-21';

-- select * from rcbill.clientcontracts limit 1000;
-- select * from rcbill.clientcontractsservicepackageprice where clientcode='I10952';
-- show index from rcbill.clientcontractsservicepackageprice ;

drop temporary table if exists a;
create temporary table a (INDEX idxa1 (clientcode), INDEX idxa2 (contractcode), INDEX idxa3 (service), INDEX idxa4 (package)) as 
(
	select 
	upper(clientcode) as clientcode, upper(clientname) as clientname, upper(contractcode) as contractcode, currency
    , upper(RatingPlanName) as RatingPlanName, upper(CreditPolicyName) as CreditPolicyName
    , upper(package) as package, price, upper(service) as service
    , LASTACTION, contractstartdate, contractenddate, contractstatus, serviceinstancenumber
    , servicestartdate, serviceenddate, StatusChangedDate, serviceid, servicerateid
    , CLIENT_ID, CONTRACT_ID
	from 
	rcbill.clientcontractsservicepackageprice
);

-- select * from a where clientcode='I10952';

drop temporary table if exists b;
create temporary table b (INDEX idxb1 (clientcode), INDEX idxb2 (contractcode), INDEX idxb3 (service), INDEX idxb4 (package) ) as 
(
	select  
    period, periodday, periodmth, PERIODYEAR, upper(clientcode) as clientcode, upper(clientname) as clientname
    , clientclass, clienttype, representative, clientaddress, cl_location, cl_area, cl_areaname, cl_latitude
    , cl_longitude, upper(contractcode) as contractcode, contractaddress, con_location, con_area, con_areaname
    , con_latitude, con_longitude, upper(SERVICE) as SERVICE, servicecategory, servicecategory2, servicesubcategory
    , upper(package) as package, price, region, ACTIVECOUNT, DEVICESCOUNT, REPORTED, Network
    from rcbill_my.customercontractactivity where period=@rundate and REPORTED='Y'
);

-- select * from b where clientcode='I10952';

drop table if exists rcbill_my.rep_cust_cont_creditpol;

create table rcbill_my.rep_cust_cont_creditpol(index idxrccp1(CLIENTCODE), index idxrccp2(CONTRACTCODE), index idxrccp3(CLIENT_ID), index idxrccp4(CONTRACT_ID))
AS
(
	select b.period as REPORTDATE
	-- , b.periodday, b.periodmth, b.PERIODYEAR
	, b.clientcode AS CLIENTCODE, b.clientname AS CLIENTNAME, b.clientclass AS CLIENTCLASS, b.clienttype AS CLIENTTYPE
	, b.contractcode AS CONTRACTCODE, a.RatingPlanName AS RATINGPLANNAME, a.CreditPolicyName AS CREDITPOLICYNAME
	, b.SERVICE, b.package AS PACKAGE, b.servicecategory AS SERVICECATEGORY, b.servicecategory2 AS SERVICECATEGORY2
	, b.servicesubcategory AS SERVICESUBCATEGORY, b.price AS PRICE, b.region AS REGION
	, b.ACTIVECOUNT, b.DEVICESCOUNT, b.REPORTED, b.Network AS NETWORK

	, b.representative AS REPRESENTATIVE, b.clientaddress AS CLIENTADDRESS, b.cl_location, b.cl_area, b.cl_areaname, b.cl_latitude, b.cl_longitude
	, b.contractaddress AS CONTRACTADDRESS, b.con_location, b.con_area, b.con_areaname, b.con_latitude, b.con_longitude

	, a.CLIENT_ID, a.CONTRACT_ID
	from 
	 b
	left join 
	 a
		on 
		a.clientcode=b.clientcode
		and 
		a.contractcode=b.contractcode
		and
		a.service=b.SERVICE
		and 
		a.package=b.package

	-- where b.clientcode='I10952'
)
;

select count(*) as rep_cust_cont_creditpol from rcbill_my.rep_cust_cont_creditpol;
-- select * from rcbill_my.rep_cust_cont_creditpol;

### REPORT FOR cccp_index.html
/*
SELECT
REPORTDATE, CLIENTCODE, CLIENTNAME, CLIENTCLASS, CLIENTTYPE, CONTRACTCODE
, CREDITPOLICYNAME, RATINGPLANNAME, SERVICE, PACKAGE, SERVICECATEGORY, SERVICECATEGORY2, SERVICESUBCATEGORY
, PRICE, NETWORK, REGION
FROM 
rcbill_my.rep_cust_cont_creditpol
ORDER BY CLIENTCODE ASC
;
*/


