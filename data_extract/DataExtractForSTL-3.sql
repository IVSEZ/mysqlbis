-- create database rcbill_extract;

use rcbill_extract;


select 'CUSTOMER ACCOUNT' AS TABLENAME;

drop table if exists rcbill_extract.IV_CUSTOMERACCOUNT;

create table rcbill_extract.IV_CUSTOMERACCOUNT (index idxIVCA1(ACCOUNTNUMBER)) AS
(

####	CUSTOMER ACCOUNT
select 
-- 0
-- , ID
 substring_index(trim(replace(FIRM,',','')),' ',1) as FIRSTNAME
, trim(substring(trim(replace(FIRM,',','')),position(' ' in trim(replace(FIRM,',',''))),length(trim(replace(FIRM,',',''))))) as LASTNAME
/*
-- REMOVED FROM CA AS IT IS MAPPED WITH SA
, case 
	when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='VIP' THEN 'RESIDENTIAL'
	when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='EMPLOYEE' THEN 'RESIDENTIAL'
	when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='INTELVISION OFFICE' THEN 'CORPORATE LARGE'
    ELSE (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS) 
   end AS CUSTOMERSEGMENT
, case 
	when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='VIP' THEN 'VIP'
	when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='EMPLOYEE' THEN 'EMPLOYEE'
	when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='INTELVISION OFFICE' THEN 'INTELVISION OFFICE'
    ELSE (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS) 
   end as CUSTOMERSUBSEGMENT
*/
-- , quote(TRIM(REPLACE(MOLADDRESS,'CITY',''))) AS ADDRESSONE
-- , quote(TRIM(REPLACE(ADDRESS,'CITY',''))) AS ADDRESSTWO
-- , quote(TRIM(REPLACE(MOLRegistrationAddress,'CITY',''))) AS ADDRESSTHREE
, ifnull(if(CITY='',NULL,CITY),'TBU') AS CITY
, ifnull((SELECT `NAME` FROM rcbill.rcb_regions WHERE ID=a.RegionID),'TBU') as STATE
, 'SEYCHELLES' AS COUNTRY
, ifnull((SELECT ClientLocation from rcbill.rcb_clientaddress where ClientCode=a.KOD),'TBU') as DISTRICT
, ifnull((SELECT ClientSubDistrict from rcbill.rcb_clientaddress where ClientCode=a.KOD),'TBU') as SUBDISTRICT
-- , '' AS STATE
-- , RegionID
-- , (select SETTLEMENTNAME from rcbill.rcb_address where AREANAME=(SELECT `NAME` FROM rcbill.rcb_regions WHERE ID=RegionID) and SETTLEMENTNAME LIKE ADDRESS LIMIT 1) AS DISTRICT	
, '00000' AS ZIPCODE
, trim(MEMAIL) AS EMAILID
, trim(BEMAIL) AS BUSINESSEMAILID
, MPHONE AS MOBILENUMBER
, MPHONE AS PHONEHOME
, BPHONE AS PHONEOFFICE
, FAX AS FAXNUMBER
, '' AS PARENTACCOUNTNUMBER
, cast(concat('CA_',KOD) as char(255)) AS ACCOUNTNUMBER
, ACTIVE AS ACCOUNTSTATUS
, ifnull((SELECT USERNAME FROM rcbill.rcb_users where CLID=a.ID LIMIT 1),concat('CA_',KOD)) as USERNAME
, ifnull(BEGDATE,UPDDATE) AS CREATEDDATE
, ifnull(BEGDATE,UPDDATE) AS ACTIVATIONDATE
, case when UPDDATE <= BEGDATE then BEGDATE 
	else UPDDATE end AS STATUSCHANGEDATE


-- , USERID AS CREATEDBYID
, case 
	when FIZLICE = 0 then 'BUSINESS REGISTRATION NUMBER'
    when FIZLICE = 1 then 'NIN NUMBER'
    when FIZLICE = 2 then 'PASSPORT NUMBER'
    
    end as `PRIMARY_ID_TYPE`

, case 
	when FIZLICE = 0 then BULSTAT
    when FIZLICE = 1 then DANNO
    when FIZLICE = 2 then PASSNO
    
    end as `PRIMARY_ID_VALUE`    

, case
	when length(MEGN)>0 then 'TAX NUMBER'
    end as `SECONDARY_ID_TYPE`
    
, case
	when length(MEGN)>0 then MEGN
    end as `SECONDARY_ID_VALUE`

-- , DANNO AS CORPORATETAXNUMBER
-- , FIZLICE AS TAXNUMBERINDICATOR #(0=Business, 1=Residential, 2=Expatriate)
, 
	case 
		when FIZLICE=0 then 'BUSINESS'
		when FIZLICE=1 then 'RESIDENTIAL'
		when FIZLICE=2 then 'EXPATRIATE'
	end as TAXNUMBERINDICATOR
, '' AS BUILDINGNAME
, '' AS BIRTHDATE
, '' AS STREETNAME
, 'ENGLISH' AS PREFERREDLANGUAGE
, '' AS PROPERTYTYPE

, (select CLIENTPARCEL from rcbill.rcb_clientparcels where clientcode=a.KOD) as PARCELNUMBER
, MOLADDRESS AS LANDMARK
, (select latitude from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS LATITUDE
, (select longitude from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS LONGITUDE
, '' AS FLOOR
, (select coord_x from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS XCOORDINATE
, (select coord_y from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS YCOORDINATE
    
-- , ID AS ACCOUNTID
-- , DANNO AS NINNUMBER
-- , PASSNo AS PASSPORTNUMBER
-- , BULSTAT AS BUSREGNNUMBER
-- , MEGN AS TAXNUMBER
    
    
from rcbill.rcb_tclients a 
where
0=0
-- and a.CLClass in (13)
and kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')

ORDER BY a.ID DESC
-- limit 1000
/*
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\"'
LINES TERMINATED BY '\n'
*/
)
;

-- show index from rcbill_extract.IV_CUSTOMERACCOUNT ;
-- select * from rcbill_extract.IV_CUSTOMERACCOUNT ;


###################################################################################


####	SERVICE ACCOUNT

select 'SERVICE ACCOUNT' AS TABLENAME;
-- sele

-- select * from rcbill.rcb_contracts
			-- where clid in (select CLID from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR') 
-- ORDER BY ID DESC;
drop table if exists rcbill_extract.IV_SERVICEACCOUNT;

create table rcbill_extract.IV_SERVICEACCOUNT(index idxivsa1(SERVICEACCOUNTNUMBER), index idxivsa2(CUSTOMERACCOUNTNUMBER)) AS
(
	select
	 substring_index(trim(replace(FIRM,',','')),' ',1) as FIRSTNAME
	, trim(substring(trim(replace(FIRM,',','')),position(' ' in trim(replace(FIRM,',',''))),length(trim(replace(FIRM,',',''))))) as LASTNAME
	, TRIM(REPLACE(a.MOLADDRESS,'CITY','')) AS ADDRESSONE
	, TRIM(REPLACE(a.ADDRESS,'CITY','')) AS ADDRESSTWO
	, TRIM(REPLACE(a.MOLRegistrationAddress,'CITY','')) AS ADDRESSTHREE
	, ifnull(if(CITY='',NULL,CITY),'TBU') AS CITY
	, ifnull((SELECT ClientLocation from rcbill.rcb_clientaddress where ClientCode=a.KOD),'TBU') as DISTRICT
	, ifnull((SELECT ClientSubDistrict from rcbill.rcb_clientaddress where ClientCode=a.KOD),'TBU') as SUBDISTRICT
	, ifnull((SELECT `NAME` FROM rcbill.rcb_regions WHERE ID=a.RegionID),'TBU') as STATE
	, 'SEYCHELLES' AS COUNTRY
	, '00000' AS ZIPCODE
	, trim(MEMAIL) AS EMAILID
	, trim(BEMAIL) AS BUSINESSEMAILID
	, a.MPHONE AS MOBILENUMBER
	, a.MPHONE AS PHONEHOME
	, a.BPHONE AS PHONEOFFICE
	, a.FAX AS FAXNUMBER
	, cast(concat('CA_',a.KOD) as char(255)) AS CUSTOMERACCOUNTNUMBER
	, cast(concat('SA_',a.KOD) as char(255)) AS SERVICEACCOUNTNUMBER
	, a.ACTIVE AS ACCOUNTSTATUS

	-- , (select cs.LABEL from rcbill.rcb_ContractStates cs where cs.ID=b.Active) as CONTRACTSTATUS
	-- , b.DATA AS CREATEDDATE
	-- , b.StartDate as ACTIVATIONDATE
	-- , b.UpdDate as STATUSCHANGEDDATE

	-- , BEGDATE AS CREATEDDATE
	-- , BEGDATE AS ACTIVATIONDATE
	-- , UPDDATE AS STATUSCHANGEDATE

	, ifnull(BEGDATE,UPDDATE) AS CREATEDDATE
	, ifnull(BEGDATE,UPDDATE) AS ACTIVATIONDATE
	, case when UPDDATE <= BEGDATE then BEGDATE 
		else UPDDATE end AS STATUSCHANGEDATE


	-- , (select `Value` from rcbill.rcb_contractslastaction where id=b.LastActionID) as LASTACTION
	-- , (select network from rcbill_my.customercontractsnapshot where contractcode=b.KOD LIMIT 1) as TECHNOLOGY
	, (select ccs.network from rcbill_my.customercontractsnapshot ccs where ccs.clientcode=a.KOD order by ccs.currentstatus asc, ccs.contractcode desc LIMIT 1) as TECHNOLOGY
	-- , b.activenetwork
	, '' AS BUILDINGNAME
	, '' AS BUILDINGTYPE
	, '' AS STREETNAME
	, 0 AS CHANNELPARTNERID
	, '' AS PROPERTYTYPE
	, (select CLIENTPARCEL from rcbill.rcb_clientparcels where clientcode=a.KOD) as PARCELNUMBER
	, a.MOLADDRESS AS LANDMARK  
	, (select latitude from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS LATITUDE
	, (select longitude from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS LONGITUDE
	, '' AS FLOOR
	, a.USERID AS EMPLOYEEID
	-- , (SELECT USERNAME FROM rcbill.rcb_users where CLID=a.USERID LIMIT 1) as EMPLOYEENAME
	, (SELECT `NAME` FROM rcbill.rcb_tickettechusers where RCBUSERID=a.USERID LIMIT 1) as EMPLOYEENAME
	, (SELECT `NAME` FROM rcbill.rcb_tickettechregions where ID = (select TechRegionID from rcbill.rcb_tickettechusers where RCBUSERID=a.USERID LIMIT 1) LIMIT 1) AS EMPLOYEEDEPARTMENT



	-- , (select mxk_interface FROM rcbill_my.customers_contracts_cmts_mxk WHERE CON_CONTRACTCODE=b.KOD limit 1) as MXKCODE
	-- , (select mxk_name FROM rcbill_my.customers_contracts_cmts_mxk WHERE CON_CONTRACTCODE=b.KOD limit 1) as MXKNAME

	-- , (select clean_mxk_interface FROM rcbill_my.rep_custconsolidated WHERE clientcode=a.KOD limit 1) as MXKCODE
	-- , (select clean_mxk_name FROM rcbill_my.rep_custconsolidated WHERE clientcode=a.KOD limit 1) as MXKNAME
	, b.clean_mxk_interface as MXKCODE
	, b.clean_mxk_name as MXKNAME


	, '' as CARDNO
	, '' as PORTNO
	, '' as SPLITTER
	, '' as NETWORKACCESSPOINT
	, '' AS NETWORKSVLAN
	, '' AS VLANID

	, case
		when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='PREPAID' THEN 'RESIDENTIAL'
		when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='STANDING ORDER' THEN 'RESIDENTIAL'
		when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='VIP' THEN 'RESIDENTIAL'
		when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='EMPLOYEE' THEN 'RESIDENTIAL'
		when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='INTELVISION OFFICE' THEN 'CORPORATE LARGE'
		when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='CORPORATE' THEN 'CORPORATE BULK'
		when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='CORPORATE BUNDLE' THEN 'CORPORATE BULK'
		ELSE (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS) 
	   end AS SERVICECATEGORY

	-- , b.ContractType as SERVICE

	-- , (select activeservices FROM rcbill_my.rep_custconsolidated WHERE clientcode=a.KOD limit 1) as ACTIVESERVICE
	, b.activeservices as ACTIVESERVICE

	, case 
		when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='VIP' THEN 'VIP'
		when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='EMPLOYEE' THEN 'EMPLOYEE'
		when (trim(upper(firm)) like ('%RETENTION') or trim(upper(firm)) like ('%RETENTION%') or trim(upper(firm)) like ('RETENTION%'))THEN 'RETENTION'
		when (trim(upper(firm)) like ('%TEST') or trim(upper(firm)) like ('%TEST%') or trim(upper(firm)) like ('TEST%')) THEN 'TEST'
		when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='INTELVISION OFFICE' THEN 'INTELVISION OFFICE'
		-- ELSE (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS) 
        ELSE ''
	   end as CUSTOMERSUBCATEGORY

	, (select coord_x from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS XCOORDINATE
	, (select coord_y from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS YCOORDINATE


	-- , (select clean_hfc_node FROM rcbill_my.rep_custconsolidated WHERE clientcode=a.KOD limit 1) as HFCNODE
	-- , (select clean_hfc_nodename FROM rcbill_my.rep_custconsolidated WHERE clientcode=a.KOD limit 1) as HFCNODENAME
	, b.clean_hfc_node as HFCNODE
	, b.clean_hfc_nodename as HFCNODENAME


	-- , b.StartDate as CONTRACTSTARTDATE
	-- , b.EndDate as CONTRACTENDDATE

	/*
	, b.CreditPolicyId as CreditPolicyId
	, (select NAME from RCBill.dbo.CreditPolicy where id=b.CreditPolicyId) as CreditPolicyName
	, (select BillingPeriod from RCBill.dbo.CreditPolicy where id=b.CreditPolicyId) as BILLCYCLE
	, b.CommChanelID as CommChanelID
	, (select LABEL from RCBill.dbo.ContractCommChannels_LNG where LNG='en' and id=b.CommChanelID) as BILLDELIVERYMODE
	, b.Currency as CURRENCY
	, b.Active as Active
	, b.ActivatedDate as ACTIVATIONDATE
	, b.LastActionID as LastActionID
	, (select LABEL from RCBill.dbo.ContractActions_view_LNG where LNG='en' and id=b.LastActionID) as LASTACTION

	, b.DATA as CONTRACTDATE
	, b.StartDate as CONTRACTSTARTDATE
	, b.EndDate as CONTRACTENDDATE
	, b.ValidityPeriod AS CONTRACTVALIDITYPERIOD
	, b.RatingPlanID AS RatingPlanID
	, (select name from [RCBill].[dbo].[RatingPlans] where ID=b.RatingPlanID) as RatingPlanName
	, b.UPDDATE AS CREATEDDATE
	, b.USERID AS CREATEDBYID
	, (SELECT NAME FROM RCBill.dbo.USERS where id=b.USERID) as CREATEDBYNAME

	*/

	FROM 
	-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (13) order by ID desc)as a
	-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (10,14) order by ID desc)as a
	-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (16) order by ID desc)as a
	-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (6) order by ID desc)as a
	-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (7) order by ID desc)as a
	-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (3) order by ID desc)as a
	-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (2) order by ID desc)as a
	rcbill.rcb_tclients a 
	left join 
	rcbill_my.rep_custconsolidated b
	on a.kod=b.clientcode
	-- inner join 
	-- rcbill.rcb_contracts b
	-- on a.ID=b.CLID
	where a.kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
	-- where a.kod in ('I.000011750')


	ORDER BY a.ID DESC
)
;

-- select * from rcbill_extract.IV_SERVICEACCOUNT ;
-- select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I748');
###################################################################################

####	BILLING ACCOUNT

select 'BILLING ACCOUNT' AS TABLENAME;


drop table if exists rcbill_extract.IV_PREP_BILLINGACCOUNT1;
create table rcbill_extract.IV_PREP_BILLINGACCOUNT1(index idxipba1(clientcode), index idxipba2(contractcode)) as 
(
	select a.*
--    , case when MaxInvDate=0 and MinInvDate=0 then 'PREPAID'
-- 	else 'POSTPAID' end as `BILLCYCLE`
    , case when a.MinInvDate=0 then 'PREPAID'
     when a.MinInvDate is null then 'PREPAID'
	else 'POSTPAID' end as `BILLCYCLE`
    , cast(concat('BA_',a.clientcode,'_',a.contractcode) as char(255)) as `BillingAccountNumber`

	from 
    (
		select clientcode, clientname, contractcode, servicecategory, servicecategory2, service,package, PackageType, network
        , currentstatus, lastcontractdate 
		, ifnull((select currency from rcbill.rcb_contracts where kod=a.contractcode),'SCR') as currency
		, ifnull((select name from rcbill.rcb_ratingplans where ID=(select ratingplanid from rcbill.rcb_contracts where kod=a.contractcode)),'MAHE_SU_STANDARD_20110601') as RatingPlanName
		-- , (select currency from rcbill.rcb_contracts where kod=a.contractcode) as currency
		, (select `name` from rcbill.rcb_creditpolicy where ID=(select CreditPolicyID from rcbill.rcb_contracts where kod=a.contractcode)) as CreditPolicyName
		, (select MaxInvDate from rcbill.rcb_creditpolicy where ID=(select CreditPolicyID from rcbill.rcb_contracts where kod=a.contractcode)) as MaxInvDate
		, (select MinInvDate from rcbill.rcb_creditpolicy where ID=(select CreditPolicyID from rcbill.rcb_contracts where kod=a.contractcode)) as MinInvDate
        , (select `Value` from rcbill.rcb_contractslastaction where id=(select LastActionID from rcbill.rcb_contracts where kod=a.contractcode)) as LASTACTION
		from rcbill_my.customercontractsnapshot a 
		where a.clientcode in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
        -- and a.lastcontractdate>='2019-01-01'
        order by CurrentStatus asc, contractcode desc
	) a 
    group by 1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
    order by a.CurrentStatus asc, a.contractcode desc
)
;

-- select * from rcbill_my.rep_custextract where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1;
-- select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice;
-- select * from rcbill_my.rep_clientcontractdevices where CLIENT_CODE in ('I14');

select 'IV_PREP_clientcontractsservicepackagepricedevice' AS TABLENAME;

drop table if exists rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice;

create table rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice(index idxipccsppd1(clientcode), index idxipccsppd2(contractcode)) as 
(
			select a.*
            , case 
				when a.contractstatus=0 then 'Not Active'
                when a.contractstatus=1 then 'Active' end as CurrentStatus
            , ifnull(a.contractenddate,(select reportdate from rcbill_my.rep_custextract where clientcode=a.clientcode)) as LastContractDate
            , (select technology from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER = concat('CA_',a.clientcode)) as network
            , b.CONTRACT_TYPE,b.SERVICE_TYPE,b.FSAN,b.MAC,b.UID,b.username
			, case when a.serviceenddate is null then 1 
				else 0 end as servicestatus

			 from rcbill.clientcontractsservicepackageprice a 
			 left join 
			 rcbill_my.rep_clientcontractdevices b 
			 on a.clientcode=b.CLIENT_CODE and a.contractcode=b.CONTRACT_CODE and a.service=b.SERVICE_TYPE
             where a.clientcode in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
        
             order by a.contractstatus asc, a.contractcode desc
);


select 'IV_PREP_BILLINGACCOUNT_A1' AS TABLENAME;


drop table if exists rcbill_extract.IV_PREP_BILLINGACCOUNT_A1;
create table rcbill_extract.IV_PREP_BILLINGACCOUNT_A1(index idxipba1(clientcode), index idxipba2(contractcode)) as 
(
	select a.clientcode, a.clientname, a.contractcode, a.currentstatus, a.currency, a.ratingplanname, a.creditpolicyname, a.MaxInvDate, a.MinInvDate
    , a.package, a.service, a.lastcontractdate, a.lastaction
--    , case when MaxInvDate=0 and MinInvDate=0 then 'PREPAID'
-- 	else 'POSTPAID' end as `BILLCYCLE`
    , case when a.MinInvDate=0 then 'PREPAID'
     when a.MinInvDate is null then 'PREPAID'
	else 'POSTPAID' end as `BILLCYCLE`
    , cast(concat('BA_',a.clientcode,'_',a.contractcode) as char(255)) as `BillingAccountNumber`
	from 
	rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice a 
	group by 1,3,4,5,6,7,8,9,10,11,12,13,14,15
)
;


-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode in ('I.000011750');
-- select * from IV_PREP_clientcontractsservicepackagepricedevice where clientcode in ('I.000011750') order by contractenddate desc;
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I.000011750');


select 'IV_PREP_BILLINGACCOUNT2' AS TABLENAME;


drop table if exists rcbill_extract.IV_PREP_BILLINGACCOUNT2;
create table rcbill_extract.IV_PREP_BILLINGACCOUNT2(index idxipba21(clientcode), index idxipba22(contractcode), index idxipba23(BillingKey), index idxipba24(BillingAccountNumber)) as 
(
	select a.*
    from 
	(
		select 
		-- clientcode, currency, ratingplanname, billcycle , CreditPolicyName
		clientcode
		,
		cast(concat('BA_',clientcode,'_',currency, ratingplanname, billcycle , CreditPolicyName) as char(255)) as `BillingKey`

		-- , cast(concat('BA_',clientcode,'_',contractcode) as char(255)) as `BillingAccountNumber`
        , BillingAccountNumber
		, contractcode
		, currency, ratingplanname, billcycle , CreditPolicyName
		-- , clientname, contractcode
		-- , lastaction
		-- , creditpolicyname
		, count(contractcode) as ContractCount
		from 
		-- rcbill_extract.IV_PREP_BILLINGACCOUNT1 a 
        rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 a 
		-- where a.currentstatus='Active'
		-- group by 1,2,3,4,5,6,7
		group by 1,2,3,4
		-- order by a.currentstatus asc, a.contractcode desc
	) a
    where a.BillingKey is not null
    
)
;

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2;
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1;
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2;

select 'IV_PREP_BILLINGACCOUNT3' AS TABLENAME;

drop table if exists rcbill_extract.IV_PREP_BILLINGACCOUNT3;
create table rcbill_extract.IV_PREP_BILLINGACCOUNT3(index idxipba31(clientcode), index idxipba33(BillingKey)) as 
(
	select clientcode, BillingKey
    -- , cast(concat('BA_',clientcode,'_',contractcode) as char(255)) as `BillingAccountNumber`
    , BillingAccountNumber
    , contractcode
	, currency, ratingplanname, billcycle , CreditPolicyName
	from 
	rcbill_extract.IV_PREP_BILLINGACCOUNT2 a 
	-- where a.currentstatus='Active'
	group by 1,2
    -- order by a.currentstatus asc, a.contractcode desc
)
;


-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode in ('I.000011750');
-- select * from IV_PREP_clientcontractsservicepackagepricedevice where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I.000011750');

/*
select a.*, b.contractcode
from 
rcbill_extract.IV_PREP_BILLINGACCOUNT2 a 
inner join 
rcbill_extract.IV_PREP_BILLINGACCOUNT1 b
on 
a.clientcode=b.clientcode
and a.currency=b.currency
and a.ratingplanname=b.RatingPlanName
and a.billcycle=b.BILLCYCLE
and a.CreditPolicyName=b.CreditPolicyName

where a.clientcode in ('I.000011750')
;
*/


-- select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (select concat('CA_',clientcode) from rcbill_extract.IV_BILLINGACCOUNTPREP);
-- select * from rcbill_extract.IV_BILLINGACCOUNTPREP where clientcode in (select replace(accountnumber,'CA_','') from rcbill_extract.IV_CUSTOMERACCOUNT);

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode in ('I.000018187','I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where clientcode in ('I.000018187', 'I.000011750');

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode in ('I14554');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where clientcode in ('I14554');

-- select a.*,b.* from rcbill_extract.IV_PREP_BILLINGACCOUNT2 a inner join rcbill_extract.IV_PREP_BILLINGACCOUNT1 b on a.clientcode=b.clientcode where a.clientcode in ('I.000011750');

select 'BILLING ACCOUNT' AS TABLENAME;

drop table if exists rcbill_extract.IV_BILLINGACCOUNT;

create table rcbill_extract.IV_BILLINGACCOUNT (index idxivba1(BILLINGACCOUNTNUMBER), index idxivba2(CUSTOMERACCOUNTNUMBER)) AS
(

	select 
	-- upper(substring_index(trim(replace(a.ClientName,',','')),' ',1)) as FIRSTNAME
	-- , upper(trim(substring(trim(replace(a.ClientName,',','')),position(' ' in trim(replace(a.ClientName,',',''))),length(trim(replace(a.ClientName,',','')))))) as LASTNAME
	 upper(substring_index(trim(replace(b.Firm,',','')),' ',1)) as FIRSTNAME
	, upper(trim(substring(trim(replace(b.Firm,',','')),position(' ' in trim(replace(b.Firm,',',''))),length(trim(replace(b.Firm,',','')))))) as LASTNAME


	-- , case when a.billcycle='PREPAID' then 'DEFAULT' 
	-- 	else (select creditpolicyname from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode=a.clientcode and contractcode=a.contractcode order by lastcontractdate desc limit 1)
	-- 	end as BILLCYCLE
	
	, case when a.billcycle='PREPAID' then 'DEFAULT' 
		else concat('MONTHLY_1_', (select InvoicingDate from rcbill.rcb_contracts where KOD=a.contractcode order by kod desc limit 1))
        -- , (select MaxInvDate from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode=a.clientcode and contractcode=a.contractcode order by lastcontractdate desc limit 1))
		end as BILLCYCLE
    
    
    , 'EMAIL' AS BILLDELIVERYMODE
	, case when (a.currency <> 'SCR' or a.currency <> 'USD') then 'SCR'
		else a.currency end as CURRENCY
	, ifnull(if(b.CITY='',NULL,b.CITY),'TBU') AS CITY
	, ifnull((SELECT ClientLocation from rcbill.rcb_clientaddress where ClientCode=a.clientcode),'TBU') as DISTRICT
	, ifnull((SELECT ClientSubDistrict from rcbill.rcb_clientaddress where ClientCode=a.clientcode),'TBU') as SUBDISTRICT
	, ifnull((SELECT `NAME` FROM rcbill.rcb_regions WHERE ID=b.RegionID),'TBU') as STATE
	, 'SEYCHELLES' AS COUNTRY
	, '00000' AS ZIPCODE
	, trim(b.MEMAIL) AS EMAILID
	, trim(b.BEMAIL) AS BUSINESSEMAILID
	, b.MPHONE AS MOBILENUMBER
	, b.MPHONE AS PHONEHOME
	, b.BPHONE AS PHONEOFFICE
	, b.FAX AS FAXNUMBER
	, cast(concat('CA_',a.clientcode) as char(255)) AS CUSTOMERACCOUNTNUMBER
	, cast(a.BillingAccountNumber as char(255)) AS BILLINGACCOUNTNUMBER
	-- , b.ACTIVE AS ACCOUNTSTATUS
	
    , case when (select currentstatus from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode=a.clientcode and contractcode=a.contractcode order by lastcontractdate desc limit 1) = 'Active' then 1 else 0 end as ACCOUNTSTATUS

	-- , b.BEGDATE AS CREATEDDATE
	-- , b.BEGDATE AS ACTIVATIONDATE
	-- , b.UPDDATE AS STATUSCHANGEDATE
	, (select startdate from rcbill.rcb_contracts where kod=a.contractcode) as CREATEDDATE
	, (select startdate from rcbill.rcb_contracts where kod=a.contractcode) as ACTIVATIONDATE
	, (select upddate from rcbill.rcb_contracts where kod=a.contractcode) as STATUSCHANGEDATE
	
    , (select lastaction from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode=a.clientcode and contractcode=a.contractcode order by lastcontractdate desc limit 1) as LASTACTION

	, 'SUMMARY' AS BILLFORMATTYPE
	, '' AS BUILDINGNAME
	, '' AS BUILDINGTYPE
	, '' AS STREETNAME
	, '' AS PROPERTYTYPE
	, (select CLIENTPARCEL from rcbill.rcb_clientparcels where clientcode=a.clientcode) as PARCELNUMBER
	, (select MOLADDRESS from rcbill.rcb_tclients where kod=a.clientcode) AS LANDMARK  
	, (select latitude from rcbill.rcb_clientparcelcoords where clientcode=a.clientcode and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS LATITUDE
	, (select longitude from rcbill.rcb_clientparcelcoords where clientcode=a.clientcode and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS LONGITUDE
	, '' AS FLOOR
	, a.billcycle AS CHARGINGPATTERN
	, (select coord_x from rcbill.rcb_clientparcelcoords where clientcode=a.clientcode and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS XCOORDINATE
	, (select coord_y from rcbill.rcb_clientparcelcoords where clientcode=a.clientcode and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS YCOORDINATE
	, a.ratingplanname as RATINGPLAN
	, (select creditpolicyname from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode=a.clientcode and contractcode=a.contractcode order by lastcontractdate desc limit 1) AS CREDITCLASSNAME

	from 
	rcbill_extract.IV_PREP_BILLINGACCOUNT3 a 
	left join 
	rcbill.rcb_tclients b 
	on a.clientcode=b.kod
	order by a.clientcode desc
)
;

-- select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I7') order by CUSTOMERACCOUNTNUMBER;
-- select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I.000011750') order by CUSTOMERACCOUNTNUMBER;

-- select * from rcbill_extract.IV_BILLINGACCOUNT where accountstatus=1;
-- select length(BILLINGACCCOUNTNUMBER) from rcbill_extract.IV_BILLINGACCOUNT;


-- 'I.000009787','I.000011750','I.000018187','I.000011998','I13703','I7'


 -- select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in ('CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7') order by ACCOUNTNUMBER;
 -- select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7') order by CUSTOMERACCOUNTNUMBER;
 -- select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7') 
 -- and ACCOUNTSTATUS=1
 -- order by CUSTOMERACCOUNTNUMBER;
 
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode in ('I.000011750');

-- select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I.000011750');

 /*
 SELECT a.*,b.* 
 from rcbill_extract.IV_CUSTOMERACCOUNT a inner join rcbill_extract.IV_SERVICEACCOUNT b 
 on a.ACCOUNTNUMBER=b.CUSTOMERACCOUNTNUMBER
 ;

SELECT a.*,b.* 
 from rcbill_extract.IV_CUSTOMERACCOUNT a inner join rcbill_extract.IV_BILLINGACCOUNT b 
 on a.ACCOUNTNUMBER=b.CUSTOMERACCOUNTNUMBER
 ;
 
SELECT a.*,b.* 
 from rcbill_extract.IV_SERVICEACCOUNT a inner join rcbill_extract.IV_BILLINGACCOUNT b 
 on a.CUSTOMERACCOUNTNUMBER=b.CUSTOMERACCOUNTNUMBER
 ;
 
 
*/
###################################################################################
-- select * from rcbill.rcb_contracts where clid in (select id from rcbill.rcb_tclients where kod='I.000011750');
## MAKE A TABLE OF CUSTOMER ACCOUNT, SERVICE ACCOUNT AND BILLING ACCOUNT TOGETHER

select 'IV_PREP_SERVICEINSTANCE1' AS TABLENAME;

drop table if exists rcbill_extract.IV_PREP_SERVICEINSTANCE1;

create table rcbill_extract.IV_PREP_SERVICEINSTANCE1 (index idxipsi1(clientcode), index idxipsi2(contractcode), index idxipsi3(BillingKey), index idxipsi4(BILLINGACCOUNTNUMBER), index idxipsi5(CUSTOMERACCOUNTNUMBER), index idxipsi6(SERVICEACCOUNTNUMBER)) as 
(
	select a.*
	, b.BillingKey
	, c.contractcode
	-- , d.*
    , e.currency, e.ratingplanname, e.LASTACTION, e.contractstartdate, e.contractenddate, e.contractstatus, e.servicestartdate, e.serviceenddate, e.servicestatus, e.servicerateid
    , e.package, e.price, e.service, e.CurrentStatus, e.LastContractDate, e.network, e.CONTRACT_TYPE, e.SERVICE_TYPE, e.FSAN, e.MAC, e.UID, e.username
	, e.serviceinstancenumber, e.StatusChangedDate, e.serviceid    
	from 
	(
		select a.ACCOUNTNUMBER as CUSTOMERACCOUNTNUMBER, replace(a.ACCOUNTNUMBER,'CA_','') as clientcode
		, b.SERVICEACCOUNTNUMBER
		-- , c.contractcode
		-- , c.billingkey
		, d.BILLINGACCOUNTNUMBER
		, d.FIRSTNAME, d.LASTNAME
		from 
			rcbill_extract.IV_CUSTOMERACCOUNT a 
				left join 
			rcbill_extract.IV_SERVICEACCOUNT b
					on a.ACCOUNTNUMBER=b.CUSTOMERACCOUNTNUMBER
			-- 	left join  
			-- rcbill_extract.IV_PREP_BILLINGACCOUNT3 c
			-- 		on replace(a.ACCOUNTNUMBER,'CA_','')=c.clientcode
				left join 
			rcbill_extract.IV_BILLINGACCOUNT d 
					-- on c.billingaccountnumber=d.BILLINGACCCOUNTNUMBER
					on a.AccountNumber=d.CUSTOMERACCOUNTNUMBER

		-- where a.ACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7') 
        -- where a.ACCOUNTNUMBER in ('CA_I.000011750') 
		group by 1,2,3,4


	) a 
	LEFT JOIN 
	rcbill_extract.IV_PREP_BILLINGACCOUNT3 b
	on a.BILLINGACCOUNTNUMBER=b.BillingAccountNumber

	LEFT JOIN 
	rcbill_extract.IV_PREP_BILLINGACCOUNT2 c 
	on b.BillingKey=c.BillingKey

	-- LEFT JOIN 
	-- rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 d 
	-- on c.contractcode=d.contractcode
    
	LEFT JOIN 
	rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice e 
	on c.contractcode=e.contractcode
    
)
;



-- show index from rcbill_extract.IV_PREP_SERVICEINSTANCE1;
-- 'I.000004181','0010'
-- select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7') ;
-- select * from rcbill.rcb_contracts where clid in (select id from rcbill.rcb_tclients where kod='I.000011750');
-- select * from rcbill.rcb_contractservices where cid in (select id from rcbill.rcb_contracts where clid in (select id from rcbill.rcb_tclients where kod='I.000011750'));
-- select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where clientcode in ('I.000011750') ;

####################################################################################################
-- SERVICE INSTANCES
select 'SERVICE INSTANCE' AS TABLENAME;

drop table if exists rcbill_extract.IV_SERVICEINSTANCE;

create table rcbill_extract.IV_SERVICEINSTANCE as
(

	select 
	-- a.*
	-- , b.*



	a.CustomerAccountNumber as CUSTOMERACCOUNTNUMBER
	, a.BillingAccountNumber as BILLINGACCOUNTNUMBER
	, a.ServiceAccountNumber as SERVICEACCOUNTNUMBER
	, a.SERVICEINSTANCEIDENTIFIER as SERVICEINSTANCEIDENTIFIER
	, a.SERVICEINSTANCENUMBER2 as SERVICEINSTANCENUMBER
	, a.PackageName as PACKAGENAME
	, a.ServiceStatus as SERVICESTATUS
	, a.username as USERNAME
	, a.CREATEDDATE
	, a.ACTIVATIONDATE
	, a.STATUSCHANGEDDATE
	, a.LASTACTION
	, a.PACKAGEAMOUNT
	, a.CPE_TYPE
	, a.CPE_ID
	, a.CONTRACTSTARTDATE
	, a.CONTRACTENDDATE
	, a.SERVICEREMARKS
	, a.EXPIRYDATE
	, a.OVERRIDDEN
	, a.FSAN
	, a.ServiceID
	, a.ServiceRateID
	-- , a.CONTRACTVALIDITYPERIOD
	, a.SERVICESTARTDATE
	, a.SERVICEENDDATE
	, a.clientcode
	, a.contractcode
	, a.serviceinstancestatus	

	-- , (select ips.CUSTOMERACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as CUSTOMERACCOUNTNUMBER
	-- , (select ips.BILLINGACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as BILLINGACCOUNTNUMBER
	-- , (select ips.SERVICEACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as SERVICEACCOUNTNUMBER
	-- , (select ips.currentstatus from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as SERVICESTATUS


	from 
	(

			SELECT
			 (@cnt := @cnt + 1) AS rowNumber,
			  ips1.CustomerAccountNumber as CUSTOMERACCOUNTNUMBER
			, ips1.BillingAccountNumber as BILLINGACCOUNTNUMBER
			, ips1.ServiceAccountNumber as SERVICEACCOUNTNUMBER
			, ips1.clientcode
			, ips1.contractcode 
			, ips1.package as PACKAGENAME
			, ips1.serviceinstancenumber as SERVICEINSTANCENUMBER
			, cast(concat('SIN_',ips1.serviceinstancenumber,'_',@cnt) as char(255)) as SERVICEINSTANCENUMBER2
			, cast(concat('SII_',ips1.contractcode) as char(255)) as SERVICEINSTANCEIDENTIFIER
			, ips1.CurrentStatus as SERVICESTATUS
            , case when ips1.servicestatus = 0 then 'Not Active'
				else 'Active' end as SERVICEINSTANCESTATUS


			, case when ips1.username is null then ips1.UID
				when length(ips1.username)=0 then ips1.UID
                when service_type in ('VOICE','GVOICE') then ips1.UID
				else ips1.username end as USERNAME

			-- , ifnull(c.username,c.phoneno) as USERNAME
			, ips1.contractstartdate AS CREATEDDATE
			, ips1.servicestartdate as ACTIVATIONDATE
			, ips1.StatusChangedDate as STATUSCHANGEDDATE
			-- , a.LastActionID as LastActionID
			, ips1.LASTACTION as LASTACTION
			, ips1.price as PACKAGEAMOUNT
			-- , '' as CPE_TYPE
			, ips1.service as CPE_TYPE
			, case when service_type in ('VOICE','GVOICE') then ips1.username
                else ips1.MAC end as CPE_ID
			, ips1.contractstartdate as CONTRACTSTARTDATE
			, ips1.contractenddate as CONTRACTENDDATE
			, '' as SERVICEREMARKS
			, '' as EXPIRYDATE
			, 'Y' as OVERRIDDEN
			-- , c.phoneno as PHONENO
			, ips1.FSAN as FSAN

			, ips1.serviceid as ServiceID
			, ips1.servicerateid as ServiceRateID


			/*
			, (select UserName from rcbill.rcb_devices where CSID=b.ID order by UserName asc limit 1) as USERNAME
			, (select PhoneNo from rcbill.rcb_devices where CSID=b.ID order by PhoneNo asc limit 1) as CPEID_PHONE
			, (select NATIP from rcbill.rcb_devices where CSID=b.ID  order by NATIP asc limit 1) as CPEID_NATIP
			, (select MAC from rcbill.rcb_devices where CSID=b.ID  order by MAC asc limit 1) as CPEID_MAC
			, (select SerNo from rcbill.rcb_devices where CSID=b.ID  order by SerNo asc limit 1) as CPEID_SERNO
			*/


			-- , a.DATA as CONTRACTDATE

			-- , a.ValidityPeriod AS CONTRACTVALIDITYPERIOD
			, ips1.servicestartdate as SERVICESTARTDATE
			, ips1.serviceenddate as SERVICEENDDATE
			from 
			rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips1

			CROSS JOIN (SELECT @cnt := 0) AS dummy


			-- where ips1.clientcode in  
			-- (select id from rcbill.rcb_tclients where kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR'))
			-- ('I.000011750') -- ,'I.000011750')) -- ('I.000009787','I.000011750','I.000018187'))
			-- ('I.000021409')

			ORDER BY ips1.clientcode desc
	) a 
)
;


-- select * from rcbill_extract.IV_SERVICEINSTANCE where clientcode in ('I.000021409');
-- select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where clientcode in ('I7') ;
-- select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where clientcode in ('I748') ;
-- select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where clientcode in ('I14') ;
-- select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where clientcode in ('I.000009787 ') ;

-- select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where clientcode in ('I.000011750') ;
-- select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where clientcode in ('I.000021409') ;
-- select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where clientcode in ('I.000021390') ;


####################################################################################################

/*
select 
si.SERVICEINSTANCENUMBER
, count(*)
from 
rcbill_extract.IV_SERVICEINSTANCE si
group by si.SERVICEINSTANCENUMBER
;

select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCENUMBER is null;

select cpe_type, count(*)
from 
rcbill_extract.IV_SERVICEINSTANCE si
group by cpe_type
;


select packagename, count(*)
from 
rcbill_extract.IV_SERVICEINSTANCE si
group by packagename
;


select cpe_type, packagename, count(*)
from 
rcbill_extract.IV_SERVICEINSTANCE si
group by cpe_type, packagename
;

select 
si.SERVICEINSTANCENUMBER
, si.CPE_TYPE
, si.PACKAGENAME
, si.PACKAGEAMOUNT
, case 
	when (cpe_type like '%RENT%' or cpe_type like '%MONTHLY%' or cpe_type like '%SUBSCRIPTION%') then 'MONTHLY CHARGE'
    else 'ONETIME CHARGE' end as CHARGENAME
from 
rcbill_extract.IV_SERVICEINSTANCE si
;

select * from rcbill_extract.IV_SERVICEINSTANCE;
*/


##################################################################################################################
-- SERVICE INSTANCE CHARGE
select 'SERVICE INSTANCE CHARGE' AS TABLENAME;

drop table if exists rcbill_extract.IV_SERVICEINSTANCECHARGE;

create table rcbill_extract.IV_SERVICEINSTANCECHARGE(index idxisic1(SERVICEINSTANCENUMBER)) as -- , index idxisic2(CPE_TYPE), index idxisic3(PACKAGENAME)) as
(
	select 
	si.SERVICEINSTANCENUMBER
	, case 
		when (si.cpe_type like '%RENT%' or si.cpe_type like '%MONTHLY%' or si.cpe_type like '%SUBSCRIPTION%') then 'MONTHLY CHARGE'
		else 'ONETIME CHARGE' end as CHARGENAME
	, si.PACKAGEAMOUNT as CHARGEPRICE
	-- , si.CPE_TYPE
	-- , si.PACKAGENAME
	from 
	rcbill_extract.IV_SERVICEINSTANCE si
)
;

-- select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where CHARGENAME='ONETIME CHARGE'; -- CPE_TYPE like '%RENT%' ; -- CHARGENAME='MONTHLY CHARGE';



##################################################################################################################
-- INVENTORY
select 'INVENTORY' AS TABLENAME;

drop table if exists rcbill_extract.IV_INVENTORY;

create table rcbill_extract.IV_INVENTORY(index idxisic1(SERVICEINSTANCENUMBER)) as -- , index idxisic2(CPE_TYPE), index idxisic3(PACKAGENAME)) as
(

select 
	si.SERVICEINSTANCENUMBER
	-- , si.CUSTOMERACCOUNTNUMBER
    -- , si.BILLINGACCOUNTNUMBER
    -- , si.SERVICEACCOUNTNUMBER
    -- , si.SERVICEINSTANCEIDENTIFIER
    
	, si.USERNAME as INVENTORYNUMBER
    , case when si.CPE_TYPE in ('GVOICE','VOICE') then si.CPE_ID 
		   when length(si.FSAN)>0 then si.FSAN
           else si.USERNAME end as SERIALNUMBER
    , si.CPE_TYPE as INVENTORYSUBTYPE
    
    -- , si.PACKAGENAME
    -- , si.CPE_TYPE
    -- , si.CPE_ID
    -- , si.FSAN
    -- , si.USERNAME
    , '' as REMARK
    , '' as STAFFNAME
    , si.SERVICESTARTDATE
    , si.SERVICEENDDATE
    , si.SERVICESTATUS
    , si.serviceinstancestatus as SERVICEINSTANCESTATUS
    , '' as SOURCECHANNEL


from rcbill_extract.IV_SERVICEINSTANCE si where 
-- CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390')  
-- and 
((si.fsan is not null) or (si.CPE_ID is not null) or (si.USERNAME is not null))

)
;



##################################################################################################################
-- SUBSCRIBER ADDON
select 'SUBSCRIBER ADDON' AS TABLENAME;

drop table if exists rcbill_extract.IV_ADDON;

create table rcbill_extract.IV_ADDON(index idxisic1(SERVICEINSTANCENUMBER)) as -- , index idxisic2(CPE_TYPE), index idxisic3(PACKAGENAME)) as
(

select 
	si.SERVICEINSTANCENUMBER
	-- , si.CUSTOMERACCOUNTNUMBER
    -- , si.BILLINGACCOUNTNUMBER
    -- , si.SERVICEACCOUNTNUMBER
    -- , si.SERVICEINSTANCEIDENTIFIER
    , si.PACKAGENAME
    , si.SERVICESTARTDATE
    , si.SERVICEENDDATE

    -- , si.PACKAGENAME
    -- , si.CPE_TYPE
    -- , si.CPE_ID
    -- , si.FSAN
    -- , si.USERNAME
    , 'Y' as OVERRIDDEN


from rcbill_extract.IV_SERVICEINSTANCE si where 
-- CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390')  
-- and 
cpe_type like '%SUBSCRIPTION%'

)
;


##################################################################################################################
-- SUBSCRIBER ADDON CHARGE
select 'SUBSCRIBER ADDON CHARGE' AS TABLENAME;

drop table if exists rcbill_extract.IV_ADDONCHARGE;

create table rcbill_extract.IV_ADDONCHARGE(index idxisic1(SERVICEINSTANCENUMBER)) as -- , index idxisic2(CPE_TYPE), index idxisic3(PACKAGENAME)) as
(

select 
	si.SERVICEINSTANCENUMBER
	-- , si.CUSTOMERACCOUNTNUMBER
    -- , si.BILLINGACCOUNTNUMBER
    -- , si.SERVICEACCOUNTNUMBER
    -- , si.SERVICEINSTANCEIDENTIFIER
    -- , si.PACKAGENAME
    , 'MONTHLY CHARGE' as CHARGENAME
	, si.PACKAGEAMOUNT as CHARGEPRICE
    -- , si.PACKAGENAME
    -- , si.CPE_TYPE
    -- , si.CPE_ID
    -- , si.FSAN
    -- , si.USERNAME
    -- , 'Y' as OVERRIDDEN


from rcbill_extract.IV_SERVICEINSTANCE si where 
-- CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390')  
-- and 
cpe_type like '%SUBSCRIPTION%'

)
;




select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390')  order by ACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390')  order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390') 
 -- and ACCOUNTSTATUS=1
 order by CUSTOMERACCOUNTNUMBER;
 
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390') 
;

select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390') )
;

select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390') )
;

select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390') )
;

select * from rcbill_extract.IV_ADDONCHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390') )
;


/*

select 
-- a.*
-- , b.*


-- , b.CustomerAccountNumber as CUSTOMERACCOUNTNUMBER
-- , b.BillingAccountNumber as BILLINGACCOUNTNUMBER
-- , b.ServiceAccountNumber as SERVICEACCOUNTNUMBER
a.clientcode
, a.contractcode
, a.PackageName as PACKAGENAME
, a.SERVICEINSTANCENUMBER2 as SERVICEINSTANCENUMBER
-- , b.currentstatus as SERVICESTATUS
, a.username as USERNAME
, a.CREATEDDATE
, a.ACTIVATIONDATE
, a.STATUSCHANGEDDATE
, a.LASTACTION
, a.PACKAGEAMOUNT
, a.CPE_TYPE
, a.CPE_ID
, a.CONTRACTSTARTDATE
, a.CONTRACTENDDATE
, a.SERVICEREMARKS
, a.EXPIRYDATE
, a.OVERRIDDEN
, a.FSAN
, a.ServiceID
, a.ServiceRateID
, a.CONTRACTVALIDITYPERIOD
, a.SERVICESTARTDATE
, a.SERVICEENDDATE


-- , (select ips.CUSTOMERACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as CUSTOMERACCOUNTNUMBER
-- , (select ips.BILLINGACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as BILLINGACCOUNTNUMBER
-- , (select ips.SERVICEACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as SERVICEACCOUNTNUMBER
-- , (select ips.currentstatus from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as SERVICESTATUS


from 
(

		SELECT
		 (@cnt := @cnt + 1) AS rowNumber,
        (select KOD from rcbill.rcb_tclients where id=a.clid) as CLIENTCODE
		, a.KOD as CONTRACTCODE
		, (select Name from rcbill.rcb_vpnrates where ID=b.ServiceRateID) as PACKAGENAME
		, b.ID as SERVICEINSTANCENUMBER
        , cast(concat(b.id,'_',@cnt) as char(255)) as SERVICEINSTANCENUMBER2
		, b.Active as SERVICESTATUS
		, case when c.username is null then c.phoneno
			when length(c.username)=0 then c.phoneno
			else c.username end as USERNAME

		-- , ifnull(c.username,c.phoneno) as USERNAME
		, a.DATA AS CREATEDDATE
		, b.StartDate as ACTIVATIONDATE
		, b.UpdDate as STATUSCHANGEDDATE
		-- , a.LastActionID as LastActionID
		, (select `Value` from rcbill.rcb_contractslastaction where id=a.LastActionID) as LASTACTION
		, (select Price from rcbill.rcb_vpnrates where ID=b.ServiceRateID) as PACKAGEAMOUNT
		-- , '' as CPE_TYPE
		, (select Name from rcbill.rcb_services where ID=b.ServiceID) as CPE_TYPE
		, c.mac as CPE_ID
		, a.StartDate as CONTRACTSTARTDATE
		, a.EndDate as CONTRACTENDDATE
		, '' as SERVICEREMARKS
		, '' as EXPIRYDATE
		, 'Y' as OVERRIDDEN
		-- , c.phoneno as PHONENO
		, c.NATIP as FSAN

		, b.ServiceID as ServiceID
		, b.ServiceRateID as ServiceRateID





		-- , a.DATA as CONTRACTDATE

		, a.ValidityPeriod AS CONTRACTVALIDITYPERIOD
		, b.StartDate as SERVICESTARTDATE
		, b.EndDate as SERVICEENDDATE
		from 
		rcbill.rcb_contracts a 
		left join 
		rcbill.rcb_contractservices b
		on 
		a.ID=b.CID

		-- left join rcbill.rcb_devices c 
		left join rcbill.clientcontractdevices c
		on 
		b.id=c.csid

		CROSS JOIN (SELECT @cnt := 0) AS dummy


		where a.clid 
		in 
		-- (select id from rcbill.rcb_tclients where kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR'))
		(select id from rcbill.rcb_tclients where kod in ('I.000011750')) -- ,'I.000011750')) -- ('I.000009787','I.000011750','I.000018187'))


		ORDER BY a.CLID desc
) a 

;

*/

