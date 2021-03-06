-- CUSTOMER ACCOUNT
-- SELECT TOP 10000 * FROM RCBill.dbo.tCLIENTS ORDER BY ID DESC;

-- SELECT * FROM rcbill.dbo.users order by CLID desc;
-- select clid, count(*) FROM rcbill.dbo.users group by clid order by 2 desc;
-- select * from rcbill.dbo.users where id=248243;
-- select distinct active from rcbill.dbo.tclients;
-- select CompanyGroupID, count(*) from rcbill.dbo.tclients group by CompanyGroupID;
-- select * from rcbill.dbo.CompanyGroups;

-- SELECT ID, Name from RCBill.dbo.ClientClasses;

-- select * from rcbill.rcb_tclients;
/*
select * from rcbill.rcb_tclients
where
0=0
-- and a.CLClass in (13)
and kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
*/

-- select * from rcbill.rcb_clientparcels;
-- SELECT * from rcbill.rcb_regions;
-- select * from rcbill.rcb_clientaddress;
-- select distinct settlementname, areaname from rcbill.rcb_address
-- select * from rcbill.rcb_address;
-- select * from rcbill.rcb_devices where CSID=b.ID order by UserName asc
-- select * from rcbill.rcb_users;
-- show index from rcbill.rcb_users;
-- SELECT * FROM rcbill.rcb_clientparcels;

use rcbill;


####	CUSTOMER ACCOUNT
select 
-- 0
-- , ID
 quote(substring_index(trim(replace(FIRM,',','')),' ',1)) as FIRSTNAME
, quote(trim(substring(trim(replace(FIRM,',','')),position(' ' in trim(replace(FIRM,',',''))),length(trim(replace(FIRM,',','')))))) as LASTNAME
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
, quote(CITY) AS CITY
, quote((SELECT `NAME` FROM rcbill.rcb_regions WHERE ID=a.RegionID)) as STATE
, quote('SEYCHELLES') AS COUNTRY
, quote((SELECT ClientLocation from rcbill.rcb_clientaddress where ClientCode=a.KOD)) as DISTRICT
, quote((SELECT ClientSubDistrict from rcbill.rcb_clientaddress where ClientCode=a.KOD)) as SUBDISTRICT
-- , '' AS STATE
-- , RegionID
-- , (select SETTLEMENTNAME from rcbill.rcb_address where AREANAME=(SELECT `NAME` FROM rcbill.rcb_regions WHERE ID=RegionID) and SETTLEMENTNAME LIKE ADDRESS LIMIT 1) AS DISTRICT	
, quote(POSTALCODE) AS ZIPCODE
, quote(trim(MEMAIL)) AS EMAILID
, quote(trim(BEMAIL)) AS BUSINESSEMAILID
, quote(MPHONE) AS MOBILENUMBER
, quote(MPHONE) AS PHONEHOME
, quote(BPHONE) AS PHONEOFFICE
, quote(FAX) AS FAXNUMBER
, quote('') AS PARENTACCOUNTNUMBER
, concat('CA_',KOD) AS ACCOUNTNUMBER
, quote(ACTIVE) AS ACCOUNTSTATUS
, ifnull(quote((SELECT USERNAME FROM rcbill.rcb_users where CLID=a.ID LIMIT 1)),quote(concat('CA_',KOD))) as USERNAME
, UPDDATE AS CREATEDDATE
, BEGDATE AS ACTIVATIONDATE
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
, quote('') AS BUILDINGNAME
, quote('') AS BIRTHDATE
, quote('') AS STREETNAME
, quote('ENGLISH') AS PREFERREDLANGUAGE
, quote('') AS PROPERTYTYPE

, quote((select CLIENTPARCEL from rcbill.rcb_clientparcels where clientcode=a.KOD)) as PARCELNUMBER
, quote(MOLADDRESS) AS LANDMARK
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
;


###################################################################################


####	BILLING ACCOUNT
select 
-- 0
-- , ID
 quote(substring_index(trim(replace(FIRM,',','')),' ',1)) as FIRSTNAME
, quote(trim(substring(trim(replace(FIRM,',','')),position(' ' in trim(replace(FIRM,',',''))),length(trim(replace(FIRM,',','')))))) as LASTNAME
, 'DEFAULT' as BILLCYCLE
, 'EMAIL' AS BILLDELIVERYMODE
, 'SCR' AS CURRENCY


-- , TRIM(REPLACE(MOLADDRESS,'CITY','')) AS ADDRESSONE
-- , TRIM(REPLACE(ADDRESS,'CITY','')) AS ADDRESSTWO
-- , TRIM(REPLACE(MOLRegistrationAddress,'CITY','')) AS ADDRESSTHREE
, quote(CITY) AS CITY
, (SELECT `NAME` FROM rcbill.rcb_regions WHERE ID=a.RegionID) as STATE
, quote((SELECT ClientLocation from rcbill.rcb_clientaddress where ClientCode=a.KOD)) as DISTRICT
, quote((SELECT ClientSubDistrict from rcbill.rcb_clientaddress where ClientCode=a.KOD)) as SUBDISTRICT
, 'SEYCHELLES' AS COUNTRY
, POSTALCODE AS ZIPCODE
, MEMAIL AS EMAILID
, BEMAIL AS BUSINESSEMAILID
, MPHONE AS MOBILENUMBER
, MPHONE AS PHONEHOME
, BPHONE AS PHONEOFFICE
, FAX AS FAXNUMBER
, KOD AS CUSTOMERACCOUNTNUMBER
, concat('BA_',KOD) AS BILLINGACCOUNTNUMBER
, ACTIVE AS ACCOUNTSTATUS
, ifnull((SELECT USERNAME FROM rcbill.rcb_users where CLID=a.ID LIMIT 1),concat('BA_',KOD)) as USERNAME
, UPDDATE AS CREATEDDATE
, BEGDATE AS ACTIVATIONDATE
, '' AS STATUSCHANGEDATE
-- , USERID AS CREATEDBYID
, 'SUMMARY' AS BILLFORMATTYPE

, '' AS BUILDINGNAME
, '' AS BUILDINGTYPE
, '' AS STREETNAME
, '' AS PROPERTYTYPE
, (select CLIENTPARCEL from rcbill.rcb_clientparcels where clientcode=a.KOD) as PARCELNUMBER
, MOLADDRESS AS LANDMARK     
, (select latitude from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS LATITUDE
, (select longitude from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS LONGITUDE
, '' AS FLOOR

, 'PREPAID' AS CHARGINGPATTERN
, (select coord_x from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS XCOORDINATE
, (select coord_y from rcbill.rcb_clientparcelcoords where clientcode=a.KOD and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))) AS YCOORDINATE
    
    
from rcbill.rcb_tclients a 
where
0=0
-- and a.CLClass in (13)
and kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
ORDER BY a.ID DESC
-- limit 1000
;


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



-- =========================================================

-- SERVICE INSTANCES
select 'SERVICE INSTANCE' AS TABLENAME;
-- SELECT * from RCBill.dbo.Contracts where clid in (select top 1000 id from RCBill.dbo.tCLIENTS order by ID desc)

-- SELECT * FROM rcbill.rcb_ContractServices ;
-- select * from RCBill.dbo.VPNRates
-- SELECT TOP 100 * FROM RCBill.dbo.Devices ORDER BY ID DESC WHERE CSID=2205116

-- SELECT TOP 100 * FROM RCBill.dbo.Devices ORDER BY ID DESC

-- show index from rcbill.rcb_contracts;

SELECT

(select concat('B_',KOD) from rcbill.rcb_tclients where id=a.clid) as BILLINGACCOUNTNUMBER
, a.KOD as SERVICEACCOUNTNUMBER
, (select Name from rcbill.rcb_vpnrates where ID=b.ServiceRateID) as PACKAGENAME
, b.ID as SERVICEINSTANCENUMBER
, b.Active as SERVICESTATUS
, c.username as USERNAME
, a.DATA AS CREATEDDATE
, b.StartDate as ACTIVATIONDATE
, b.UpdDate as STATUSCHANGEDDATE
, a.LastActionID as LastActionID
, (select `Value` from rcbill.rcb_contractslastaction where id=a.LastActionID) as CONTRACTLASTACTION
, (select Price from rcbill.rcb_vpnrates where ID=b.ServiceRateID) as PACKAGEAMOUNT

, '' as CPE_TYPE
, c.mac as CPE_ID
, c.phoneno as PHONENO
, c.NATIP as NATIP

, b.ServiceID as ServiceID
, b.ServiceRateID as ServiceRateID
, (select Name from rcbill.rcb_services where ID=b.ServiceID) as SERVICETYPE
, (select Name from rcbill.rcb_vpnrates where ID=b.ServiceRateID) as CPETYPE


/*
, (select UserName from rcbill.rcb_devices where CSID=b.ID order by UserName asc limit 1) as USERNAME
, (select PhoneNo from rcbill.rcb_devices where CSID=b.ID order by PhoneNo asc limit 1) as CPEID_PHONE
, (select NATIP from rcbill.rcb_devices where CSID=b.ID  order by NATIP asc limit 1) as CPEID_NATIP
, (select MAC from rcbill.rcb_devices where CSID=b.ID  order by MAC asc limit 1) as CPEID_MAC
, (select SerNo from rcbill.rcb_devices where CSID=b.ID  order by SerNo asc limit 1) as CPEID_SERNO
*/


-- , a.DATA as CONTRACTDATE
, a.StartDate as CONTRACTSTARTDATE
, a.EndDate as CONTRACTENDDATE
, '' as SERVICEREMARKS
, '' as EXPIRYDATE

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
(select id from rcbill.rcb_tclients where kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR'))
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (13)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (10,14)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (16)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (6)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (7)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (3)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (2)  order by ID desc)



ORDER BY a.CLID desc

;
-- =========================================================


###################################################################################


/*


select 'CUSTOMER ACCOUNT' AS TABLENAME;

select
 ltrim(rtrim(substring(replace(firm,',',' '),1,charindex(' ',replace(firm,',',' '))))) as FirstName
, ltrim(rtrim(substring(replace(firm,',',' '),charindex(' ',replace(firm,',',' ')),LEN(replace(firm,',',' '))))) as LastName
-- , replace(SUBSTRING(firm,1,charindex(' ',firm)),',','') as FirstName
, ParentID AS PARENTACCOUNTNUMBER
, KOD AS ACCOUNTNUMBER
, ID AS ACCOUNTID
, ACTIVE AS ACCOUNTSTATUS
, (select top 1 UserName from RCBill.dbo.USERS where CLID=a.ID) as USERNAME
, (SELECT NAME FROM RCBill.dbo.ClientClasses WHERE ID=CLCLASS) AS CUSTOMERSEGMENT

, (SELECT NAME FROM [RCBill].[dbo].[CompanyGroups] WHERE ID=a.CompanyGroupID) as CUSTOMERTYPE
, ltrim(rtrim(REPLACE(ADDRESS,'city',''))) AS ADDRESSONE
, MOLADDRESS AS ADDRESSTWO
, MOLRegistrationAddress AS ADDRESSTHREE
, ADDRESS AS STREETNAME
, POSTALCODE AS POSTALCODE
, CITY AS CITY
, '' AS STATE
, ADDRESS as DISTRICT
, ADDRESS AS SUBDISTRICT
, (SELECT NAME FROM [RCBill].[dbo].[Regions] WHERE ID=a.RegionID) as REGION
, 'Seychelles' AS COUNTRY
, MEMAIL AS EMAILADDRESS
, BEMAIL AS BUSINESSEMAILADDRESS
, MPHONE AS PHONEMOBILE
, MPHONE AS PHONEHOME
, BPHONE AS PHONEOFFICE
, FAX AS FAXNUMBER
, DANNO AS NINNUMBER
, PASSNo AS PASSPORTNUMBER
, BULSTAT AS BUSREGNNUMBER
, MEGN AS TAXNUMBER
, DANNO AS CORPORATETAXNUMBER
, FIZLICE AS TAXNUMBERINDICATOR
, '' AS BIRTHDATE
, UPDDATE AS CREATEDDATE
, BEGDATE AS ACTIVATIONDATE
, '' AS STATUSCHANGEDATE
, USERID AS CREATEDBYID
, (SELECT NAME FROM RCBill.dbo.USERS where id=a.USERID) as CREATEDBYNAME
, firm as FULLNAME

FROM 
RCBill.dbo.tCLIENTS as a
where 
-- KOD='I13079'
-- a.CLClass=1	--Standing Order
-- a.CLClass=2	--VIP
-- a.CLClass=3	--Intelvision Office
-- a.CLClass=4	--Corporate Small
-- a.CLClass=5	--Corporate Medium
-- a.CLClass=6	--Corporate Large
-- a.CLClass=7	--Employee
-- a.CLClass=8	--Prepaid
-- a.CLClass=9	--Black Listed
-- a.CLClass=10	--Corporate Bulk
-- a.CLClass=11	--corporate
-- a.CLClass=12	--USD_standard
-- a.CLClass=13	--Residential
-- a.CLClass=14	--Corporate Bundle
-- a.CLClass=15	--Interconnect
-- a.CLClass=16	--Corporate Lite

 a.CLClass in (13)
-- a.CLClass in (10,14)
-- a.CLClass in (16)
-- a.CLClass in (6)
-- a.CLClass in (7)
-- a.CLClass in (3)
-- a.CLClass in (2)

ORDER BY a.ID DESC
;


-- =========================================================

-- BILLING ACCOUNT

-- SERVICE ACCOUNT

select 'BILLING/SERVICE ACCOUNT' AS TABLENAME;
-- SELECT * from RCBill.dbo.ContractStates_view_LNG 
-- SELECT * from RCBill.dbo.Contracts where clid in (select top 1000 id from RCBill.dbo.tCLIENTS order by ID desc)
select
a.FIRM as FULLNAME
, a.KOD AS CUSTOMERACCOUNTNUMBER
, a.KOD AS BILLINGACCOUNTNUMBER
, a.ID AS ACCOUNTID

, b.ID as CONTRACTID
, b.KOD as SERVICECONTRACTNUMBER


, a.ACTIVE AS ACCOUNTSTATUS
, a.ADDRESS AS ADDRESSONE
, a.MOLADDRESS AS ADDRESSTWO
, a.MOLRegistrationAddress AS ADDRESSTHREE
, a.ADDRESS AS STREETNAME
, a.POSTALCODE AS POSTALCODE
, a.CITY AS CITY
, '' AS STATE
, a.ADDRESS as DISTRICT
, a.ADDRESS AS SUBDISTRICT
, (SELECT NAME FROM [RCBill].[dbo].[Regions] WHERE ID=a.RegionID) as REGION
, 'Seychelles' AS COUNTRY
, a.MEMAIL AS EMAILADDRESS
, a.BEMAIL AS BUSINESSEMAILADDRESS
, a.MPHONE AS PHONEMOBILE
, a.MPHONE AS PHONEHOME
, a.BPHONE AS PHONEOFFICE
, a.FAX AS FAXNUMBER

, b.CreditPolicyId as CreditPolicyId
, (select NAME from RCBill.dbo.CreditPolicy where id=b.CreditPolicyId) as CreditPolicyName
, (select BillingPeriod from RCBill.dbo.CreditPolicy where id=b.CreditPolicyId) as BILLCYCLE
, b.CommChanelID as CommChanelID
, (select LABEL from RCBill.dbo.ContractCommChannels_LNG where LNG='en' and id=b.CommChanelID) as BILLDELIVERYMODE
, b.Currency as CURRENCY
, b.Active as Active
, (select LABEL from RCBill.dbo.ContractStates_view_LNG where LNG='en' and id=b.Active) as CONTRACTSTATUS
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



FROM 
 ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (13) order by ID desc)as a
-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (10,14) order by ID desc)as a
-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (16) order by ID desc)as a
-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (6) order by ID desc)as a
-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (7) order by ID desc)as a
-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (3) order by ID desc)as a
-- ( select top 1000 * from RCBill.dbo.tCLIENTS where CLClass in (2) order by ID desc)as a

inner join 
RCBill.dbo.Contracts as b
on a.ID=b.CLID
ORDER BY a.ID DESC
;



--=========================================================

-- SERVICE INSTANCES
select 'SERVICE INSTANCE' AS TABLENAME
-- SELECT * from RCBill.dbo.Contracts where clid in (select top 1000 id from RCBill.dbo.tCLIENTS order by ID desc)

-- SELECT top 100 * FROM RCBill.dbo.ContractServices 
-- select * from RCBill.dbo.VPNRates
-- SELECT TOP 100 * FROM RCBill.dbo.Devices ORDER BY ID DESC WHERE CSID=2205116

-- SELECT TOP 100 * FROM RCBill.dbo.Devices ORDER BY ID DESC
SELECT 
-- a.*, b.*
-- , 
(select FIRM from RCBill.dbo.tCLIENTS where id=a.clid) as FULLNAME
, (select KOD from RCBill.dbo.tCLIENTS where id=a.clid) as CUSTOMERACCOUNTNUMBER
, (select KOD from RCBill.dbo.tCLIENTS where id=a.clid) as BILLINGACCOUNTNUMBER
, a.KOD as SERVICEACCOUNTNUMBER
, b.ServiceID as ServiceID
, b.ServiceRateID as ServiceRateID
, (select Name from RCBill.dbo.Services where ID=b.ServiceID) as SERVICETYPE
, (select Name from RCBill.dbo.VPNRates where ID=b.ServiceRateID) as SERVICENAME
, (select Price from RCBill.dbo.VPNRates where ID=b.ServiceRateID) as SERVICEPRICE
, (select Name from RCBill.dbo.VPNRates where ID=b.ServiceRateID) as CPETYPE


, (select TOP 1 UserName from RCBill.dbo.Devices where CSID=b.ID order by UserName asc) as USERNAME
, (select TOP 1 PhoneNo from RCBill.dbo.Devices where CSID=b.ID order by PhoneNo asc) as CPEID_PHONE
, (select TOP 1 NATIP from RCBill.dbo.Devices where CSID=b.ID  order by NATIP asc) as CPEID_NATIP
, (select TOP 1 MAC from RCBill.dbo.Devices where CSID=b.ID  order by MAC asc) as CPEID_MAC
, (select TOP 1 SerNo from RCBill.dbo.Devices where CSID=b.ID  order by SerNo asc) as CPEID_SERNO


, b.ID as SERVICEINSTANCENUMBER
, b.Active as SERVICESTATUS
, b.UpdDate as CREATEDDATE
, b.ActivatedDate as ACTIVATIONDATE

, a.DATA as CONTRACTDATE
, a.StartDate as CONTRACTSTARTDATE
, a.EndDate as CONTRACTENDDATE
, a.ValidityPeriod AS CONTRACTVALIDITYPERIOD

, a.LastActionID as LastActionID
, (select LABEL from RCBill.dbo.ContractActions_view_LNG where LNG='en' and id=a.LastActionID) as CONTRACTLASTACTION

, b.StartDate as SERVICESTARTDATE
, b.EndDate as SERVICEENDDATE
from 
RCBill.dbo.Contracts a 
inner join 
RCBill.dbo.ContractServices b
on 
a.ID=b.CID
where a.clid 
in 
 (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (13)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (10,14)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (16)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (6)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (7)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (3)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (2)  order by ID desc)



ORDER BY a.CLID desc


--=========================================================

-- CREDIT NOTE / DEBIT NOTE

-- ideally should be PAYMENTS
select 'PAYMENTS' AS TABLENAME

select 
-- *
-- ,
(select FIRM from RCBill.dbo.tCLIENTS where id=a.clid) as FULLNAME
, (select KOD from RCBill.dbo.tCLIENTS where ID=a.CLID) as CUSTOMERACCOUNTNUMBER
, (select KOD from RCBill.dbo.Contracts where id=a.CID) as SERVICEACCOUNTNUMBER
, (select Name from RCBill.dbo.Services where ID=(a.PAYTYPE*-1)) as SERVICETYPE
, (select NAME from RCBill.dbo.PayObjects where ID=a.PAYOBJECTID) as PAYOBJECT
, (select NAME from RCBill.dbo.CashPoints where ID=a.CashPointID) as CASHPOINT
, a.PAYDATE
, a.MONEY as AMOUNT
, a.BankReference 
, a.ZAB as BankIdentifier
, a.ExternalReference
, a.INVID
, a.hard
, a.ENTERDATE
, a.UPDDATE
, a.USERID AS CREATEDBYID
, (SELECT NAME FROM RCBill.dbo.USERS where id=a.USERID) as CREATEDBYNAME
from 
RCBill.dbo.CASA a where a.CLID 
in 
 (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (13)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (10,14)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (16)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (6)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (7)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (3)  order by ID desc)
-- (select top 1000 id from RCBill.dbo.tCLIENTS  where CLClass in (2)  order by ID desc)

ORDER BY a.CLID DESC


--=========================================================

-- INVOICES

select 'INVOICES' AS TABLENAME
-- SELECT top 1000 * FROM RCBill.dbo.InvoicesHeader order by ID desc
-- SELECT top 1000 * FROM RCBill.dbo.InvoicesContents order by ID desc



--=========================================================

-- PARTNER ACCOUNT
select 'PARTNER ACCOUNT' AS TABLENAME

SELECT 
a.ID
, a.KOD
, a.Name
, a.StartInvoiceNo
, a.EndInvoiceNo
, a.UPDDATE
, a.USERID AS CREATEDBYID
, (SELECT NAME FROM RCBill.dbo.USERS where id=a.USERID) as CREATEDBYNAME
, a.SetupDate as SETUPDATE
, (SELECT NAME FROM RCBill.dbo.USERS where id=a.SetupUserID) as SETUPBYNAME
from RCBill.dbo.CashPoints a ;




*/