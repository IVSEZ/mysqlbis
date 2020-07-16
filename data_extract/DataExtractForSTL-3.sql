-- create database rcbill_extract;

use rcbill_extract;




drop table if exists rcbill_extract.IV_CUSTOMERACCOUNT;

create table rcbill_extract.IV_CUSTOMERACCOUNT AS
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
, concat('CA_',KOD) AS ACCOUNTNUMBER
, ACTIVE AS ACCOUNTSTATUS
, ifnull((SELECT USERNAME FROM rcbill.rcb_users where CLID=a.ID LIMIT 1),concat('CA_',KOD)) as USERNAME
, UPDDATE AS CREATEDDATE
-- , BEGDATE AS ACTIVATIONDATE
, UPDDATE AS ACTIVATIONDATE
, '' AS STATUSCHANGEDATE
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

-- select * from rcbill_extract.IV_CUSTOMERACCOUNT ;


###################################################################################


####	SERVICE ACCOUNT

select 'SERVICE ACCOUNT' AS TABLENAME;
-- sele

select * from rcbill.rcb_contracts
-- where clid in (select CLID from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR') 
ORDER BY ID DESC;

select
 quote(substring_index(trim(replace(FIRM,',','')),' ',1)) as FIRSTNAME
, quote(trim(substring(trim(replace(FIRM,',','')),position(' ' in trim(replace(FIRM,',',''))),length(trim(replace(FIRM,',','')))))) as LASTNAME
, quote(TRIM(REPLACE(a.MOLADDRESS,'CITY',''))) AS ADDRESSONE
, quote(TRIM(REPLACE(a.ADDRESS,'CITY',''))) AS ADDRESSTWO
, quote(TRIM(REPLACE(a.MOLRegistrationAddress,'CITY',''))) AS ADDRESSTHREE
, a.CITY AS CITY
, (SELECT ClientSubDistrict from rcbill.rcb_clientaddress where ClientCode=a.KOD) as SUBDISTRICT
, (SELECT ClientLocation from rcbill.rcb_clientaddress where ClientCode=a.KOD) as DISTRICT
, (SELECT `NAME` FROM rcbill.rcb_regions WHERE ID=a.RegionID) as STATE
, 'SEYCHELLES' AS COUNTRY
, a.POSTALCODE AS ZIPCODE
, a.MEMAIL AS EMAILID
, a.BEMAIL AS BUSINESSEMAILID
, a.MPHONE AS MOBILENUMBER
, a.MPHONE AS PHONEHOME
, a.BPHONE AS PHONEOFFICE
, a.FAX AS FAXNUMBER
, a.KOD AS CUSTOMERACCOUNTNUMBER

, b.KOD AS SERVICEACCCOUNTNUMBER
, (select cs.LABEL from rcbill.rcb_ContractStates cs where cs.ID=b.Active) as CONTRACTSTATUS
, b.DATA AS CREATEDDATE
, b.StartDate as ACTIVATIONDATE
, b.UpdDate as STATUSCHANGEDDATE

, (select `Value` from rcbill.rcb_contractslastaction where id=b.LastActionID) as LASTACTION
, (select network from rcbill_my.customercontractsnapshot where contractcode=b.KOD LIMIT 1) as TECHNOLOGY
, '' AS BUILDINGNAME
, '' AS BUILDINGTYPE
, '' AS STREETNAME
, 0 AS CHANNELPARTNERID
, '' AS PROPERTYTYPE
, (select CLIENTPARCEL from rcbill.rcb_clientparcels where clientcode=a.KOD) as PARCELNUMBER
, MOLADDRESS AS LANDMARK  
, (select latitude from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS LATITUDE
, (select longitude from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS LONGITUDE
, '' AS FLOOR
, b.USERID AS EMPLOYEEID
, (SELECT USERNAME FROM rcbill.rcb_users where CLID=b.USERID LIMIT 1) as EMPLOYEENAME
, '' AS EMPLOYEEDEPARTMENT
, (select mxk_interface FROM rcbill_my.customers_contracts_cmts_mxk WHERE CON_CONTRACTCODE=b.KOD limit 1) as MXKCODE
, (select mxk_name FROM rcbill_my.customers_contracts_cmts_mxk WHERE CON_CONTRACTCODE=b.KOD limit 1) as MXKNAME
, '' as CARDNO
, '' as PORTNO
, '' as SPLITTER
, '' as NETWORKACCESSPOINT
, '' AS NETWORKSVLAN
, '' AS VLANID

, case
	when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='VIP' THEN 'RESIDENTIAL'
	when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='EMPLOYEE' THEN 'RESIDENTIAL'
	when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='INTELVISION OFFICE' THEN 'CORPORATE LARGE'
    ELSE (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS) 
   end AS SERVICECATEGORY
, b.ContractType as SERVICE

, case 
	when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='VIP' THEN 'VIP'
	when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='EMPLOYEE' THEN 'EMPLOYEE'
	when (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS)='INTELVISION OFFICE' THEN 'INTELVISION OFFICE'
    ELSE (SELECT NAME FROM rcbill.rcb_clientclasses WHERE ID=a.CLCLASS) 
   end as CUSTOMERSUBCATEGORY

, (select coord_x from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS XCOORDINATE
, (select coord_y from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS YCOORDINATE


, (select hfc_node FROM rcbill_my.customers_contracts_cmts_mxk WHERE CON_CONTRACTCODE=b.KOD limit 1) as HFCNODE
, (select nodename FROM rcbill_my.customers_contracts_cmts_mxk WHERE CON_CONTRACTCODE=b.KOD limit 1) as HFCNODENAME
, b.StartDate as CONTRACTSTARTDATE
, b.EndDate as CONTRACTENDDATE

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
inner join 
rcbill.rcb_contracts b
on a.ID=b.CLID
where a.kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
ORDER BY b.ID DESC

;
