-- create database rcbill_extract;

use rcbill_extract;




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
, BEGDATE AS CREATEDDATE
-- , BEGDATE AS ACTIVATIONDATE
, BEGDATE AS ACTIVATIONDATE
, UPDDATE AS STATUSCHANGEDATE
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

create table rcbill_extract.IV_SERVICEACCOUNT(index idxivsa1(SERVICEACCCOUNTNUMBER), index idxivsa2(CUSTOMERACCOUNTNUMBER)) AS
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
	, cast(concat('SA_',a.KOD) as char(255)) AS SERVICEACCCOUNTNUMBER
	, a.ACTIVE AS ACCOUNTSTATUS

	-- , (select cs.LABEL from rcbill.rcb_ContractStates cs where cs.ID=b.Active) as CONTRACTSTATUS
	-- , b.DATA AS CREATEDDATE
	-- , b.StartDate as ACTIVATIONDATE
	-- , b.UpdDate as STATUSCHANGEDDATE

	, BEGDATE AS CREATEDDATE
	-- , BEGDATE AS ACTIVATIONDATE
	, BEGDATE AS ACTIVATIONDATE
	, UPDDATE AS STATUSCHANGEDATE

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
###################################################################################

####	BILLING ACCOUNT

select 'BILLING ACCOUNT' AS TABLENAME;


drop table if exists rcbill_extract.IV_PREP_BILLINGACCOUNT1;
create table rcbill_extract.IV_PREP_BILLINGACCOUNT1(index idxipba1(clientcode), index idxipba2(contractcode)) as 
(
	select a.*
    , case when MaxInvDate=0 and MinInvDate=0 then 'PREPAID'
	else 'POSTPAID' end as `BILLCYCLE`
	from 
    (
		select clientcode, clientname, contractcode, servicecategory, servicecategory2, service,package, PackageType, network
        , currentstatus, lastcontractdate 
		, (select currency from rcbill.rcb_contracts where kod=a.contractcode) as currency
		, (select name from rcbill.rcb_ratingplans where ID=(select ratingplanid from rcbill.rcb_contracts where kod=a.contractcode)) as RatingPlanName
		-- , (select currency from rcbill.rcb_contracts where kod=a.contractcode) as currency
		, (select `name` from rcbill.rcb_creditpolicy where ID=(select CreditPolicyID from rcbill.rcb_contracts where kod=a.contractcode)) as CreditPolicyName
		, (select MaxInvDate from rcbill.rcb_creditpolicy where ID=(select CreditPolicyID from rcbill.rcb_contracts where kod=a.contractcode)) as MaxInvDate
		, (select MinInvDate from rcbill.rcb_creditpolicy where ID=(select CreditPolicyID from rcbill.rcb_contracts where kod=a.contractcode)) as MinInvDate
        , (select `Value` from rcbill.rcb_contractslastaction where id=(select LastActionID from rcbill.rcb_contracts where kod=a.contractcode)) as LASTACTION
		from rcbill_my.customercontractsnapshot a 
		where a.clientcode in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
        order by CurrentStatus asc, contractcode desc
	) a 
    group by 1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
    order by a.CurrentStatus asc, a.contractcode desc
)
;

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1;

drop table if exists rcbill_extract.IV_PREP_BILLINGACCOUNT2;
create table rcbill_extract.IV_PREP_BILLINGACCOUNT2 as 
(
	select clientcode, currency, ratingplanname, billcycle
    , cast(concat('BA_',clientcode,'_',contractcode) as char(255)) as `BillingAccountNumber`
	, clientname, contractcode
    -- , lastaction
    -- , creditpolicyname
	, count(contractcode)
	from 
	rcbill_extract.IV_PREP_BILLINGACCOUNT1 a 
	-- where a.currentstatus='Active'
	group by 1,2,3,4
    -- order by a.currentstatus asc, a.contractcode desc
)
;

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2;

-- select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (select concat('CA_',clientcode) from rcbill_extract.IV_BILLINGACCOUNTPREP);
-- select * from rcbill_extract.IV_BILLINGACCOUNTPREP where clientcode in (select replace(accountnumber,'CA_','') from rcbill_extract.IV_CUSTOMERACCOUNT);

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode in ('I.000018187','I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where clientcode in ('I.000018187', 'I.000011750');

-- select a.*,b.* from rcbill_extract.IV_PREP_BILLINGACCOUNT2 a inner join rcbill_extract.IV_PREP_BILLINGACCOUNT1 b on a.clientcode=b.clientcode where a.clientcode in ('I.000011750');

drop table if exists rcbill_extract.IV_BILLINGACCOUNT;

create table rcbill_extract.IV_BILLINGACCOUNT (index idxivba1(BILLINGACCCOUNTNUMBER), index idxivba2(CUSTOMERACCOUNTNUMBER)) AS
(

	select 
	 upper(substring_index(trim(replace(a.ClientName,',','')),' ',1)) as FIRSTNAME
	, upper(trim(substring(trim(replace(a.ClientName,',','')),position(' ' in trim(replace(a.ClientName,',',''))),length(trim(replace(a.ClientName,',','')))))) as LASTNAME
	, case when a.billcycle='PREPAID' then 'DEFAULT' 
		else (select creditpolicyname from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode=a.clientcode and contractcode=a.contractcode order by lastcontractdate desc limit 1)
		end as BILLCYCLE
	, 'EMAIL' AS BILLDELIVERYMODE
	, a.currency as CURRENCY
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
	, cast(a.BillingAccountNumber as char(255)) AS BILLINGACCCOUNTNUMBER
	-- , b.ACTIVE AS ACCOUNTSTATUS
	, case when (select currentstatus from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode=a.clientcode and contractcode=a.contractcode order by lastcontractdate desc limit 1) = 'Active' then 1 else 0 end as ACCOUNTSTATUS

	-- , b.BEGDATE AS CREATEDDATE
	-- , b.BEGDATE AS ACTIVATIONDATE
	-- , b.UPDDATE AS STATUSCHANGEDATE
	, (select startdate from rcbill.rcb_contracts where kod=a.contractcode) as CREATEDDATE
	, (select startdate from rcbill.rcb_contracts where kod=a.contractcode) as ACTIVATIONDATE
	, (select upddate from rcbill.rcb_contracts where kod=a.contractcode) as STATUSCHANGEDATE
	, (select lastaction from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode=a.clientcode and contractcode=a.contractcode order by lastcontractdate desc limit 1) as LASTACTION

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

	from 
	rcbill_extract.IV_PREP_BILLINGACCOUNT2 a 
	left join 
	rcbill.rcb_tclients b 
	on a.clientcode=b.kod
	order by a.clientcode desc
)
;

-- select * from rcbill_extract.IV_BILLINGACCOUNT where accountstatus=1;
-- select length(BILLINGACCCOUNTNUMBER) from rcbill_extract.IV_BILLINGACCOUNT;

 select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in ('CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998');
 select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998');
 select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998');
 
 
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

-- SERVICE INSTANCES
select 'SERVICE INSTANCE' AS TABLENAME;

SELECT

(select KOD from rcbill.rcb_tclients where id=a.clid) as CLIENTCODE
, a.KOD as CONTRACTCODE
, (select Name from rcbill.rcb_vpnrates where ID=b.ServiceRateID) as PACKAGENAME
, b.ID as SERVICEINSTANCENUMBER
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


/*
, (select UserName from rcbill.rcb_devices where CSID=b.ID order by UserName asc limit 1) as USERNAME
, (select PhoneNo from rcbill.rcb_devices where CSID=b.ID order by PhoneNo asc limit 1) as CPEID_PHONE
, (select NATIP from rcbill.rcb_devices where CSID=b.ID  order by NATIP asc limit 1) as CPEID_NATIP
, (select MAC from rcbill.rcb_devices where CSID=b.ID  order by MAC asc limit 1) as CPEID_MAC
, (select SerNo from rcbill.rcb_devices where CSID=b.ID  order by SerNo asc limit 1) as CPEID_SERNO
*/


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



where a.clid 
in 
-- (select id from rcbill.rcb_tclients where kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR'))
(select id from rcbill.rcb_tclients where kod in ('I7')) -- ,'I.000011750')) -- ('I.000009787','I.000011750','I.000018187'))


ORDER BY a.CLID desc

;



