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
 substring_index(trim(replace(FIRM,',','')),' ',1) as FIRSTNAME
, substring(trim(replace(FIRM,',','')),position(' ' in trim(replace(FIRM,',',''))),length(trim(replace(FIRM,',','')))) as LASTNAME
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
, TRIM(REPLACE(MOLADDRESS,'CITY','')) AS ADDRESSONE
, TRIM(REPLACE(ADDRESS,'CITY','')) AS ADDRESSTWO
, TRIM(REPLACE(MOLRegistrationAddress,'CITY','')) AS ADDRESSTHREE
, CITY AS CITY
, (SELECT ClientSubDistrict from rcbill.rcb_clientaddress where ClientCode=a.KOD) as SUBDISTRICT
, (SELECT ClientLocation from rcbill.rcb_clientaddress where ClientCode=a.KOD) as DISTRICT
-- , '' AS STATE
-- , RegionID
, (SELECT `NAME` FROM rcbill.rcb_regions WHERE ID=a.RegionID) as STATE
, 'SEYCHELLES' AS COUNTRY
-- , (select SETTLEMENTNAME from rcbill.rcb_address where AREANAME=(SELECT `NAME` FROM rcbill.rcb_regions WHERE ID=RegionID) and SETTLEMENTNAME LIKE ADDRESS LIMIT 1) AS DISTRICT	
, POSTALCODE AS ZIPCODE
, MEMAIL AS EMAILID
, BEMAIL AS BUSINESSEMAILID
, MPHONE AS MOBILENUMBER
, MPHONE AS PHONEHOME
, BPHONE AS PHONEOFFICE
, FAX AS FAXNUMBER
, '' AS PARENTACCOUNTNUMBER
, KOD AS ACCOUNTNUMBER
, ACTIVE AS ACCOUNTSTATUS
, (SELECT USERNAME FROM rcbill.rcb_users where CLID=a.ID LIMIT 1) as USERNAME
, UPDDATE AS CREATEDDATE
, BEGDATE AS ACTIVATIONDATE
, '' AS STATUSCHANGEDATE
-- , USERID AS CREATEDBYID
, DANNO AS NINNUMBER
, PASSNo AS PASSPORTNUMBER
, BULSTAT AS BUSREGNNUMBER
, MEGN AS TAXNUMBER
, DANNO AS CORPORATETAXNUMBER
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
, (select a1_parcel from rcbill.rcb_clientparcels where clientcode=a.KOD) as PARCELNUMBER1
, (select a2_parcel from rcbill.rcb_clientparcels where clientcode=a.KOD) as PARCELNUMBER2
, (select a3_parcel from rcbill.rcb_clientparcels where clientcode=a.KOD) as PARCELNUMBER3
, (select CONCAT_WS( "|", a1_parcel,a2_parcel,a3_parcel) from rcbill.rcb_clientparcels where clientcode=a.KOD) as PARCELNUMBER
, MOLADDRESS AS LANDMARK     
, ID AS ACCOUNTID
    
    
from rcbill.rcb_tclients a 
where
0=0
-- and a.CLClass in (13)
and kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')

ORDER BY a.ID DESC
-- limit 1000
;


###################################################################################


####	BILLING ACCOUNT
select 
-- 0
-- , ID
 substring_index(trim(replace(FIRM,',','')),' ',1) as FIRSTNAME
, substring(trim(replace(FIRM,',','')),position(' ' in trim(replace(FIRM,',',''))),length(trim(replace(FIRM,',','')))) as LASTNAME
, 'DEFAULT' as BILLCYCLE
, 'EMAIL' AS BILLDELIVERYMODE
, 'SCR' AS CURRENCY


, TRIM(REPLACE(MOLADDRESS,'CITY','')) AS ADDRESSONE
, TRIM(REPLACE(ADDRESS,'CITY','')) AS ADDRESSTWO
, TRIM(REPLACE(MOLRegistrationAddress,'CITY','')) AS ADDRESSTHREE
, CITY AS CITY
, (SELECT ClientSubDistrict from rcbill.rcb_clientaddress where ClientCode=a.KOD) as SUBDISTRICT
, (SELECT ClientLocation from rcbill.rcb_clientaddress where ClientCode=a.KOD) as DISTRICT
, (SELECT `NAME` FROM rcbill.rcb_regions WHERE ID=a.RegionID) as STATE
, 'SEYCHELLES' AS COUNTRY
, POSTALCODE AS ZIPCODE
, MEMAIL AS EMAILID
, BEMAIL AS BUSINESSEMAILID
, MPHONE AS MOBILENUMBER
, MPHONE AS PHONEHOME
, BPHONE AS PHONEOFFICE
, FAX AS FAXNUMBER
, KOD AS CUSTOMERACCOUNTNUMBER
, concat('B_',KOD) AS BILLINGACCOUNTNUMBER
, ACTIVE AS ACCOUNTSTATUS
, (SELECT USERNAME FROM rcbill.rcb_users where CLID=a.ID LIMIT 1) as USERNAME
, UPDDATE AS CREATEDDATE
, BEGDATE AS ACTIVATIONDATE
, '' AS STATUSCHANGEDATE
-- , USERID AS CREATEDBYID
, 'SUMMARY' AS BILLFORMATTYPE

, '' AS BUILDINGNAME
, '' AS BUILDINGTYPE
, '' AS STREETNAME
, '' AS PROPERTYTYPE
, (select a1_parcel from rcbill.rcb_clientparcels where clientcode=a.KOD) as PARCELNUMBER1
, (select a2_parcel from rcbill.rcb_clientparcels where clientcode=a.KOD) as PARCELNUMBER2
, (select a3_parcel from rcbill.rcb_clientparcels where clientcode=a.KOD) as PARCELNUMBER3
, (select CONCAT_WS( "|", a1_parcel,a2_parcel,a3_parcel) from rcbill.rcb_clientparcels where clientcode=a.KOD) as PARCELNUMBER
, MOLADDRESS AS LANDMARK     
    
    
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

select
 substring_index(trim(replace(a.FIRM,',','')),' ',1) as FIRSTNAME
, substring(trim(replace(a.FIRM,',','')),position(' ' in trim(replace(a.FIRM,',',''))),length(trim(replace(a.FIRM,',','')))) as LASTNAME
, TRIM(REPLACE(a.MOLADDRESS,'CITY','')) AS ADDRESSONE
, TRIM(REPLACE(a.ADDRESS,'CITY','')) AS ADDRESSTWO
, TRIM(REPLACE(a.MOLRegistrationAddress,'CITY','')) AS ADDRESSTHREE
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

, b.


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