-- create database rcbill_extract;

use rcbill_extract;

set @kod1 = 'I14';
set @kod2 = 'I.000009787';
set @kod3 = 'I.000011750';
set @kod4 = 'I.000018187';
set @kod5 = 'I.000011998';
set @kod6 = 'I7';
set @kod7 = 'I.000021409';
set @kod8 = 'I.000021390';
set @kod9 = 'I9991';
set @kod10 = 'I.000021467';
set @kod11 = 'I.000020888';
set @kod11 = 'I16192';

-- select rcbill.GetClientID(@kod11) as clid;

set @clid1 = 699807;
set @clid2 = 721746;
set @clid3 = 723711;
set @clid4 = 730174;
set @clid5 = 723959;
set @clid6 = 711581;
set @clid7 = 734460;
set @clid8 = 734440;
set @clid9 = 691038;
set @clid10 = 691038;
set @clid11 = 733908;
set @clid11 = 708755;


set @custid1 = 'CA_I14';
set @custid2 = 'CA_I.000009787';
set @custid3 = 'CA_I.000011750';
set @custid4 = 'CA_I.000018187';
set @custid5 = 'CA_I.000011998';
set @custid6 = 'CA_I7';
set @custid7 = 'CA_I.000021409';
set @custid8 = 'CA_I.000021390';
set @custid9 = 'CA_I9991';
set @custid10 = 'CA_I.000021467';
set @custid11 = 'CA_I.000020888';
set @custid11 = 'CA_I16192';


select 'CUSTOMER ACCOUNT' AS TABLENAME;

drop table if exists rcbill_extract.IV_CUSTOMERACCOUNT;

create table rcbill_extract.IV_CUSTOMERACCOUNT (index idxIVCA1(ACCOUNTNUMBER), index idxIVCA12(CLIENT_ID)) AS
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
, a.CLCLASS    
, a.FIZLICE

, a.ID as CLIENT_ID
from rcbill.rcb_tclients a 
where
0=0
-- and a.CLClass in (13)


 and kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
-- and kod in (@kod1,@kod2,@kod3,@kod4,@kod5,@kod6,@kod7,@kod8,@kod9,@kod10, @kod11)


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

####	BILLING ACCOUNT

-- select 'BILLING ACCOUNT' AS TABLENAME;

/*
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
*/
-- select * from rcbill_my.rep_custextract where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1;
-- select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice;
-- select * from rcbill_my.rep_clientcontractdevices where CLIENT_CODE in ('I14');

select 'IV_PREP_clientcontractsservicepackagepricedevice' AS TABLENAME;

drop table if exists rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice;

create table rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice(index idxipccsppd1(clientcode), index idxipccsppd2(contractcode)) as 
(
			select a.*
            -- , rcbill.GetClientID(a.clientcode) as CLIENT_ID
            -- , rcbill.GetContractID(a.contractcode) as CONTRACT_ID
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
             -- where a.clientcode in (@kod1,@kod2,@kod3,@kod4,@kod5,@kod6,@kod7,@kod8,@kod9,@kod10,@kod11)

             
        
             -- order by a.clientcode asc, a.contractstatus desc, a.contractcode desc
             order by a.CLIENT_ID asc, a.contractstatus desc, a.CONTRACT_ID desc
);


-- select * from IV_PREP_clientcontractsservicepackagepricedevice where clientcode in ('I.000011750') order by contractenddate desc;
-- select * from IV_PREP_clientcontractsservicepackagepricedevice where clientcode in ('I9991') order by contractenddate desc;

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
    , cast(concat('BA_',a.clientcode,'_',a.contractcode) as char(255)) as `BillingAccountNumber_STG`
    , a.client_id, a.contract_id
	from 
	rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice a 
	group by 1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
    -- order by a.clientcode asc, a.currentstatus asc, a.contractcode desc
    order by a.CLIENT_ID asc, a.currentstatus asc, a.CONTRACT_ID desc
)
;


-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode in ('I9991');

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode in ('I9991');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode in ('I.000018187');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode in ('I.000009787');


select 'IV_PREP_BILLINGACCOUNT2' AS TABLENAME;


drop table if exists rcbill_extract.IV_PREP_BILLINGACCOUNT2;
create table rcbill_extract.IV_PREP_BILLINGACCOUNT2(index idxipba21(clientcode), index idxipba22(contractcode), index idxipba23(BillingKey), index idxipba24(BillingAccountNumber_STG)) as 
(
	select a.*
    from 
	(
		select 
		-- clientcode, currency, ratingplanname, billcycle , CreditPolicyName
		clientcode
		,
		cast(concat('BA_',clientcode,'_',currency, ratingplanname, billcycle , CreditPolicyName) as char(255)) as `BillingKey`
        -- cast(concat('BA_',clientcode,'_',currency, billcycle) as char(255)) as `BillingKey`

		-- , cast(concat('BA_',clientcode,'_',contractcode) as char(255)) as `BillingAccountNumber`
        , BillingAccountNumber_STG
		, contractcode
		, currency, ratingplanname, billcycle , CreditPolicyName
        , client_id
        , contract_id
        , currentstatus
		-- , clientname, contractcode
		-- , lastaction
		-- , creditpolicyname
		, count(contractcode) as ContractCount
		from 
		-- rcbill_extract.IV_PREP_BILLINGACCOUNT1 a 
        ( 
			select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 a order by a.client_id asc, a.currentstatus asc, a.contract_id desc 
        ) a 
        -- ( 
		-- 	select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 order by clientcode asc, currentstatus asc, contractcode desc
        -- ) a
        
        
        -- where a.clientcode='I.000009787'
		-- where a.currentstatus='Active'
		group by 1,2,3,4,5,6,7,8
		
        -- group by 1,2,3,4
        
        -- group by clientcode, currency, billcycle
        -- group by 1,2
        
		order by a.client_id asc
        -- , a.contractcode desc 
        , a.currentstatus asc
	) a
    where a.BillingKey is not null
    -- order by a.clientcode asc, a.CONTRACTCODE desc, a.billingkey desc
    order by a.client_id asc, a.currentstatus asc, a.contract_id desc, a.billingkey desc
)
;

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2;
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1;
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2;
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1;
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2;
 
 
 
select 'IV_PREP_BILLINGACCOUNT3' AS TABLENAME;

drop table if exists rcbill_extract.IV_PREP_BILLINGACCOUNT3;
create table rcbill_extract.IV_PREP_BILLINGACCOUNT3(index idxipba31(clientcode), index idxipba33(BillingKey)) as 
(
	select clientcode, BillingKey
    -- , cast(concat('BA_',clientcode,'_',contractcode) as char(255)) as `BillingAccountNumber`
    , BillingAccountNumber_STG
    , contractcode
        , client_id
        , contract_id
	, currency, ratingplanname, billcycle , CreditPolicyName
	from 
	rcbill_extract.IV_PREP_BILLINGACCOUNT2 a 
	-- where a.currentstatus='Active'
	group by 1,2
    -- order by a.currentstatus asc, a.contractcode desc
    order by a.clientcode asc, a.contract_id desc
    
)
;


-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT1 where clientcode in ('I.000011750');
-- select * from IV_PREP_clientcontractsservicepackagepricedevice where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where clientcode in ('I.000011750');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I.000011750');

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode in ('I.000009787');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where clientcode in ('I.000009787');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I.000009787');

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode in ('I.000018187');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where clientcode in ('I.000018187');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I.000018187');

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I9991');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode in ('I7');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where clientcode in ('I7');
 
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I7');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I9991');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in (@kod1);
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I.000018187');

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


drop table if exists rcbill_extract.IV_PREP_BILLINGACCOUNT4;

create table rcbill_extract.IV_PREP_BILLINGACCOUNT4 (index idxivba1(BillingAccountNumber_STG), index idxivba2(CUSTOMERACCOUNTNUMBER)) AS
(

	select 
	-- (@cnt := @cnt + 1) AS rowNumber1,
	 CASE CUSTOMERACCOUNTNUMBER 
		 WHEN @curType THEN @cnt := @cnt + 1 
		 ELSE @cnt := 1
	 END AS rowNumber,  
	 @curType := CUSTOMERACCOUNTNUMBER AS curtype
    
	,cast(concat(a.BillingAccountNumber_STG,'_',@cnt) as char(255)) as BILLINGACCOUNTNUMBER
    , a.*
    , cast(concat('BK4_',a.client_id,'_',a.billcycle, a.currency, a.chargingpattern) as char(255)) as `BK4`

    from 
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
		, case when (a.currency <> 'SCR' AND a.currency <> 'USD') then 'SCR'
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
		, cast(a.BillingAccountNumber_STG as char(255)) AS BillingAccountNumber_STG
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
		, a.client_id
		, a.contract_id

		from 
		rcbill_extract.IV_PREP_BILLINGACCOUNT3 a 
		left join 
		rcbill.rcb_tclients b 
		on a.clientcode=b.kod
		-- where a.clientcode='I.000009787'
		order by a.clientcode desc
	) a 
    CROSS JOIN (SELECT @cnt := 0, @curType := '') AS dummy
    
)
;



select 'BILLING ACCOUNT' AS TABLENAME;
drop table if exists rcbill_extract.IV_BILLINGACCOUNT;

create table rcbill_extract.IV_BILLINGACCOUNT (index idxivba1(BillingAccountNumber), index idxivba3(BillingAccountNumber_STG), index idxivba2(CUSTOMERACCOUNTNUMBER), index idxivba4(BK4)) AS
(

	select 
    -- * 
	BILLINGACCOUNTNUMBER, FIRSTNAME, LASTNAME, BILLCYCLE, BILLDELIVERYMODE, CURRENCY, CITY, DISTRICT, SUBDISTRICT, STATE, COUNTRY, ZIPCODE, EMAILID, BUSINESSEMAILID, MOBILENUMBER, PHONEHOME, PHONEOFFICE, FAXNUMBER, CUSTOMERACCOUNTNUMBER, ACCOUNTSTATUS, CREATEDDATE, ACTIVATIONDATE, STATUSCHANGEDATE, LASTACTION, BILLFORMATTYPE, BUILDINGNAME, BUILDINGTYPE, STREETNAME, PROPERTYTYPE, PARCELNUMBER, LANDMARK, LATITUDE, LONGITUDE, FLOOR, CHARGINGPATTERN, XCOORDINATE, YCOORDINATE, RATINGPLAN, CREDITCLASSNAME, client_id, contract_id, BillingAccountNumber_STG, BK4    
    from 
	-- rcbill_extract.IV_BILLINGACCOUNT 
	(
		select * 
        from rcbill_extract.IV_PREP_BILLINGACCOUNT4 
		group by CUSTOMERACCOUNTNUMBER, billcycle, currency, chargingpattern, accountstatus 
		order by  CUSTOMERACCOUNTNUMBER asc, accountstatus desc
	) a
	group by CUSTOMERACCOUNTNUMBER, billcycle, currency, chargingpattern
	

/*
	select a.* 
	, (@cnt := @cnt + 1) AS rowNumber
	,cast(concat(BillingAccountNumber_STG,'_',@cnt) as char(255)) as BILLINGACCOUNTNUMBER
	from 
	(
	select * from 
	-- rcbill_extract.IV_BILLINGACCOUNT 
	(
		select * from rcbill_extract.IV_PREP_BILLINGACCOUNT4 
		group by CUSTOMERACCOUNTNUMBER, billcycle, currency, chargingpattern, accountstatus 
		order by  CUSTOMERACCOUNTNUMBER asc, accountstatus desc
	) a
	group by CUSTOMERACCOUNTNUMBER, billcycle, currency, chargingpattern
	-- order by client_id asc, billcycle asc, chargingpattern asc , currency asc, billingaccountnumber_stg asc
	-- order by client_id asc, billcycle asc, chargingpattern asc , accountstatus desc, currency asc
	-- order by client_id asc, accountstatus desc, billcycle asc, currency asc, chargingpattern asc 
	) a 

	CROSS JOIN (SELECT @cnt := 0) AS dummy
*/
)
;


select 'BILLINGACCOUNT_KEY' AS TABLENAME;
drop table if exists rcbill_extract.BILLINGACCOUNT_KEY;

create table rcbill_extract.BILLINGACCOUNT_KEY(index idxivba1(BillingAccountNumber), index idxivba2(clientcode), index idxivba3(contractcode), index idxivba4(client_id), index idxivba5(contract_id)) AS
(


	select 
	a2.clientcode
	, a2.contractcode
	, a2.client_id
	, a2.contract_id
	, a2.BillingKey as a2_BillingKey
	, a2.BillingAccountNumber_STG as a2_BillingAccountNumber_STG

	, a3.BillingKey as a3_BillingKey
	, a3.BillingAccountNumber_STG as a3_BillingAccountNumber_STG

	, a4.BILLINGACCOUNTNUMBER as a4_BILLINGACCOUNTNUMBER
	, a4.BillingAccountNumber_STG as a4_BillingAccountNumber_STG
	, a4.BK4

	, a.BILLINGACCOUNTNUMBER
    , a.CUSTOMERACCOUNTNUMBER
    , a.BILLCYCLE

	from 
	rcbill_extract.IV_PREP_BILLINGACCOUNT2 a2
	inner join rcbill_extract.IV_PREP_BILLINGACCOUNT3 a3
	on a2.BillingKey = a3.BillingKey


	inner join rcbill_extract.IV_PREP_BILLINGACCOUNT4 a4
	on a3.BillingAccountNumber_STG = a4.BillingAccountNumber_STG


	inner join rcbill_extract.IV_BILLINGACCOUNT a 
	on a4.BK4 = a.BK4


)
;

-- select * from rcbill_extract.BILLINGACCOUNT_KEY;

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1;
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2;
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3;
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT4;

-- select * from rcbill_extract.IV_BILLINGACCOUNT;

/*
select *
-- firstname, lastname, customeraccountnumber, billcycle, currency, chargingpattern, accountstatus, client_id, contract_id, billingaccountnumber_stg
 
from 
(
select * from rcbill_extract.IV_BILLINGACCOUNT 
where CUSTOMERACCOUNTNUMBER in ('CA_I.000018187') 
group by CUSTOMERACCOUNTNUMBER, billcycle, currency, chargingpattern, accountstatus 
-- rcbill_extract.IV_BILLINGACCOUNT
order by  CUSTOMERACCOUNTNUMBER asc, accountstatus desc 
) a 
-- where CUSTOMERACCOUNTNUMBER in ('CA_I.000009787') 
group by CUSTOMERACCOUNTNUMBER, billcycle, currency, chargingpattern 
order by client_id asc, billcycle asc, chargingpattern asc , currency asc

*/


/*

-- select firstname, lastname, customeraccountnumber, billcycle, currency, chargingpattern, accountstatus, client_id, contract_id, billingaccountnumber
 from rcbill_extract.IV_BILLINGACCOUNT order by client_id asc, billcycle, currency, chargingpattern, accountstatus desc;

   
select 
-- *
firstname, lastname, customeraccountnumber, billcycle, currency, chargingpattern, accountstatus, client_id, contract_id, billingaccountnumber 
from 
-- rcbill_extract.IV_BILLINGACCOUNT
( select firstname, lastname, customeraccountnumber, billcycle, currency, chargingpattern, accountstatus, client_id, contract_id, billingaccountnumber
 from rcbill_extract.IV_BILLINGACCOUNT order by client_id asc, billcycle, currency, chargingpattern, accountstatus desc
 ) a 
group by CUSTOMERACCOUNTNUMBER, billcycle, currency, chargingpattern 
order by client_id asc, accountstatus desc;

*/



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

	, a.ID as CLIENT_ID
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
	-- where a.kod in (@kod1,@kod2,@kod3,@kod4,@kod5,@kod6,@kod7,@kod8,@kod9,@kod10,@kod11)
	
    -- where a.kod in ('I.000011750')

	ORDER BY a.ID DESC
)
;

-- select * from rcbill_extract.IV_SERVICEACCOUNT ;
-- select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I748');
###################################################################################


/*

select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where client_id=734460;
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where client_id=734460;
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where client_id=734460;
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where client_id=734460;
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT4 where client_id=734460;

select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where client_id=723711;
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where client_id=723711;
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where client_id=723711;
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where client_id=723711;
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT4 where client_id=723711;
select * from rcbill_extract.IV_BILLINGACCOUNT where client_id=723711;

select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where client_id=711581;
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where client_id=711581;
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where client_id=711581;
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where client_id=711581;
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT4 where client_id=711581;
select * from rcbill_extract.IV_BILLINGACCOUNT where client_id=711581;



select a.*, b.* from 
rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice a 
left join 
rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 b 
on 
-- a.clientcode=b.clientcode 
-- and 
a.contractcode=b.contractcode
where 
-- a.client_id=734460
a.client_id=723711
;

select
-- a1.*, 
a.*,
b.*,
c.*,
d.*
from 

-- rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice a1
-- left join 
-- rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 a 
-- on a1.clientcode=a.clientcode and a1.contractcode=a.contractcode




rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 a 

left join 
rcbill_extract.IV_PREP_BILLINGACCOUNT2 b
on a.BillingAccountNumber_STG=b.BillingAccountNumber_STG 

left join 
rcbill_extract.IV_PREP_BILLINGACCOUNT3 c 
on b.BillingKey=c.BillingKey 

left join 
rcbill_extract.IV_PREP_BILLINGACCOUNT4 d 
on c.BillingAccountNumber_STG=d.BillingAccountNumber_STG 

left join
rcbill_extract.IV_BILLINGACCOUNT e 
on d.BILLINGACCOUNTNUMBER=e.BILLINGACCOUNTNUMBER

where 
-- a.client_id=734460
a.client_id=723711
;


select * from rcbill_extract.IV_SERVICEACCOUNT ;

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
    , e.CLIENT_ID, e.CONTRACT_ID
	from 
	(
		select a.ACCOUNTNUMBER as CUSTOMERACCOUNTNUMBER, replace(a.ACCOUNTNUMBER,'CA_','') as clientcode
		, b.SERVICEACCOUNTNUMBER
		-- , c.contractcode
		-- , c.billingkey
		, d.BILLINGACCOUNTNUMBER
        , d.BILLINGACCOUNTNUMBER_STG
        , d.BK4
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
		group by 1,2,3,4,5,6


	) a 
    LEFT JOIN 
	rcbill_extract.IV_PREP_BILLINGACCOUNT4 f
	on a.BK4=f.BK4	
    
    
    LEFT JOIN 
	rcbill_extract.IV_PREP_BILLINGACCOUNT3 b
	on f.BILLINGACCOUNTNUMBER_STG=b.BillingAccountNumber_STG

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
-- select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where CUSTOMERACCOUNTNUMBER in ('CA_I7') ;
-- select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where CUSTOMERACCOUNTNUMBER in ('CA_I.000011750') ;
-- select * from rcbill.rcb_contracts where clid in (select id from rcbill.rcb_tclients where kod='I.000011750');
-- select * from rcbill.rcb_contractservices where cid in (select id from rcbill.rcb_contracts where clid in (select id from rcbill.rcb_tclients where kod='I.000011750'));
-- select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where clientcode in ('I.000011750') ;

####################################################################################################
drop table if exists rcbill_extract.CLIENTCONTRACTLASTSUBDATE;

create table rcbill_extract.CLIENTCONTRACTLASTSUBDATE (index idxccls1(CLID), index idxccls2(CID), index idxccls3(RSID))
(
	/*
	select CLID, CID, RSID, max(BEGDATE) as SUBLASTSTARTDATE, max(ENDDATE) as SUBLASTENDDATE, max(PAYDATE) as SUBLASTPAYDATE
	from 
	rcbill.rcb_casa

	-- where CLID in (select id from rcbill.rcb_tclients where kod='I9979')
	group by 
	CLID, CID, RSID
    */
    /*
			SELECT  a.CLID, a.CID, a.RSID, a.BEGDATE as SUBLASTSTARTDATE, a.ENDDATE as SUBLASTENDDATE, a.PAYDATE as SUBLASTPAYDATE 
			FROM    rcbill.rcb_casa a
			INNER JOIN
			(
				SELECT  CLID, CID, RSID, max(ID) as MAX_ID 
				FROM    rcbill.rcb_casa
				-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
				GROUP BY CLID, CID, RSID
			) b ON -- a.ID = b.ID AND 
			a.ID = b.max_ID    
    */
    /*
		SELECT  a.CLID, a.CID, a.RSID, a.BEGDATE as LASTSUBSTARTDATE, a.ENDDATE as LASTSUBENDDATE, a.PAYDATE as LASTSUBPAYDATE
		, (select begdate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) limit 1) as CURSUBSTARTDATE
		, (select enddate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) limit 1) as CURSUBENDDATE
		, (select paydate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) limit 1) as CURSUBPAYDATE
		FROM    rcbill.rcb_casa a
				INNER JOIN
				(
					SELECT  CLID, CID, RSID, max(ID) as MAX_ID 
					FROM    rcbill.rcb_casa
					-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
					GROUP BY CLID, CID, RSID
				) b ON -- a.ID = b.ID AND 
				a.ID = b.max_ID    
		*/
        
        
                
		select a.*, b.begdate as CURSUBSTARTDATE, b.enddate as CURSUBENDDATE, b.paydate as CURSUBPAYDATE 
		from 
		(

				SELECT  a.CLID, a.CID, a.RSID, a.BEGDATE as LASTSUBSTARTDATE, a.ENDDATE as LASTSUBENDDATE, a.PAYDATE as LASTSUBPAYDATE
				-- , (select begdate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) limit 1) as CURSUBSTARTDATE
				-- , (select enddate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) limit 1) as CURSUBENDDATE
				-- , (select paydate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) limit 1) as CURSUBPAYDATE
				FROM    rcbill.rcb_casa a
						INNER JOIN
						(
							SELECT  CLID, CID, RSID, max(ID) as MAX_ID 
							FROM    rcbill.rcb_casa
							-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
							-- where CLID in (718650) 
							
								-- and b.client_id=718650
								-- and b.CLIENT_ID=715432
								-- and b.CLIENT_ID=723711
							GROUP BY CLID, CID, RSID
							-- limit 10000
						) b ON -- a.ID = b.ID AND 
						a.ID = b.max_ID  


		) a 
		left join 
		(
		-- rcbill.rcb_casa 
							SELECT  CLID, CID, RSID, count(*) as cnt, BEGDATE, ENDDATE, PAYDATE 
							FROM    rcbill.rcb_casa
							-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
							-- where CLID in (718650) 
							
								-- and b.client_id=718650
								-- and b.CLIENT_ID=715432
								-- and b.CLIENT_ID=723711
							where  BegDate<=date(now()) and EndDate>=date(now())
							GROUP BY CLID, CID, RSID

		) b
		on a.clid=b.clid and a.cid=b.cid and a.rsid=b.rsid -- and b.begdate<=date(now()) and b.enddate>=date(now())

        
)
;




drop table if exists rcbill_extract.CLIENTCONTRACTLASTINVDATE;

create table rcbill_extract.CLIENTCONTRACTLASTINVDATE (index idxccls1(CLID), index idxccls2(CID), index idxccls3(RSID))
(
	/*
	select CLID, CID, RSID, max(FROMDATE) as INVLASTFROMDATE, max(TODATE) as INVLASTTODATE
	from 
	rcbill.rcb_invoicescontents

	-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000011750')
	group by 
	CLID, CID, RSID
    order by id desc
	*/
    /*
		SELECT  a.CLID, a.CID, a.RSID, a.FROMDATE as INVLASTFROMDATE, a.TODATE as INVLASTTODATE 
		FROM    rcbill.rcb_invoicescontents a
				INNER JOIN
				(
					SELECT  CLID, CID, RSID, max(ID) as MAX_ID 
					FROM    rcbill.rcb_invoicescontents
					-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
					GROUP BY CLID, CID, RSID
				) b ON -- a.ID = b.ID AND 
				a.ID = b.max_ID
				order by id desc
      */
      /*
		SELECT  a.CLID, a.CID, a.RSID, a.FROMDATE as LASTINVFROMDATE, a.TODATE as LASTINVTODATE 

		, (select fromdate from rcbill.rcb_invoicescontents where clid=a.clid and cid=a.cid and rsid=a.rsid and fromdate<=date(now()) and todate>=date(now()) limit 1) as CURINVFROMDATE
		, (select todate from rcbill.rcb_invoicescontents where clid=a.clid and cid=a.cid and rsid=a.rsid and fromdate<=date(now()) and todate>=date(now()) limit 1) as CURINVTODATE

		FROM    rcbill.rcb_invoicescontents a
				INNER JOIN
				(
					SELECT  CLID, CID, RSID, max(ID) as MAX_ID 
					FROM    rcbill.rcb_invoicescontents
					-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
					GROUP BY CLID, CID, RSID
				) b ON -- a.ID = b.ID AND 
				a.ID = b.max_ID
				order by id desc      
                
	*/
    
			select a.*, b.FromDate as CURINVFROMDATE, b.ToDate as CURINVTODATE
			from
			(

				SELECT  a.CLID, a.CID, a.RSID, a.FROMDATE as LASTINVFROMDATE, a.TODATE as LASTINVTODATE 

				-- , (select fromdate from rcbill.rcb_invoicescontents where clid=a.clid and cid=a.cid and rsid=a.rsid and fromdate<=date(now()) and todate>=date(now()) limit 1) as CURINVFROMDATE
				-- , (select todate from rcbill.rcb_invoicescontents where clid=a.clid and cid=a.cid and rsid=a.rsid and fromdate<=date(now()) and todate>=date(now()) limit 1) as CURINVTODATE

				FROM    rcbill.rcb_invoicescontents a
						INNER JOIN
						(
							SELECT  CLID, CID, RSID, max(ID) as MAX_ID 
							FROM    rcbill.rcb_invoicescontents
							-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
							GROUP BY CLID, CID, RSID
						) b ON -- a.ID = b.ID AND 
						a.ID = b.max_ID
						order by id desc  
			) a 
			left join 
			(

							SELECT  CLID, CID, RSID, count(*) as cnt, fromdate, ToDate 
							FROM    rcbill.rcb_invoicescontents
							-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
							-- where CLID in (718650) 
							
								-- and b.client_id=718650
								-- and b.CLIENT_ID=715432
								-- and b.CLIENT_ID=723711
							where  FromDate<=date(now()) and ToDate>=date(now())
							GROUP BY CLID, CID, RSID
			) b 
			on a.clid=b.clid and a.cid=b.cid and a.rsid=b.rsid
    
)	;



-- SERVICE INSTANCES
select 'SERVICE INSTANCE' AS TABLENAME;

drop table if exists rcbill_extract.IV_SERVICEINSTANCE;

create table rcbill_extract.IV_SERVICEINSTANCE(index idxipsi1(client_id), index idxipsi2(contract_id), index idxipsi3(SERVICEINSTANCENUMBER), index idxipsi4(BILLINGACCOUNTNUMBER), index idxipsi5(CUSTOMERACCOUNTNUMBER), index idxipsi6(SERVICEACCOUNTNUMBER), index idxipsi7(servicerateid), index idxipsi8(serviceid)) as
(

	select a.*

			, round(( TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO) +
			  DATEDIFF(
				a.SUBTO,
				a.SUBFROM + INTERVAL
				  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO)
				MONTH
			  ) /
			  DATEDIFF(
				a.SUBFROM + INTERVAL
				  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO) + 1
				MONTH,
				a.SUBFROM + INTERVAL
				  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO)
				MONTH
			  ) ) ,0) as SUBPERIOD  
			
         



	from 
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

			, a.CLIENT_ID
			, a.CONTRACT_ID
			-- , (select ips.CUSTOMERACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as CUSTOMERACCOUNTNUMBER
			-- , (select ips.BILLINGACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as BILLINGACCOUNTNUMBER
			-- , (select ips.SERVICEACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as SERVICEACCOUNTNUMBER
			-- , (select ips.currentstatus from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as SERVICESTATUS

			, b.LASTSUBSTARTDATE
			, b.LASTSUBENDDATE
			, b.LASTSUBPAYDATE
			, c.LASTINVFROMDATE
			, c.LASTINVTODATE

			, b.CURSUBSTARTDATE
			, b.CURSUBENDDATE
			, b.CURSUBPAYDATE    
			, c.CURINVFROMDATE
			, c.CURINVTODATE
			
			, if(ifnull(date(b.LASTSUBSTARTDATE),date(c.LASTINVFROMDATE))>b.CURSUBSTARTDATE,b.CURSUBSTARTDATE,ifnull(date(b.LASTSUBSTARTDATE),date(c.LASTINVFROMDATE))) as SUBFROM
			, if(ifnull(date(b.LASTSUBENDDATE),date(c.LASTINVTODATE))>b.CURSUBENDDATE,b.CURSUBENDDATE,ifnull(date(b.LASTSUBENDDATE),date(c.LASTINVTODATE))) as SUBTO
			
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
					, ips1.CLIENT_ID as CLIENT_ID
					, ips1.CONTRACT_ID as CONTRACT_ID


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

					CROSS JOIN (SELECT @cnt := 0, @curType := '') AS dummy


					-- where ips1.clientcode in  
					-- (select id from rcbill.rcb_tclients where kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR'))
					-- ('I.000011750') -- ,'I.000011750')) -- ('I.000009787','I.000011750','I.000018187'))
					-- ('I.000021409')

					ORDER BY ips1.clientcode desc
			) a 
			
			left join 
			rcbill_extract.CLIENTCONTRACTLASTSUBDATE b 
			on a.CLIENT_ID=b.CLID and a.CONTRACT_ID=b.CID and a.ServiceRateID=b.RSID
			
			left join 
			rcbill_extract.CLIENTCONTRACTLASTINVDATE c 
			on a.CLIENT_ID=c.CLID and a.CONTRACT_ID=c.CID and a.ServiceRateID=c.RSID
	) a 
)
;


-- select * from rcbill_extract.IV_SERVICEINSTANCE where clientcode in ('I.000021409');
-- select * from rcbill_extract.IV_SERVICEINSTANCE where clientcode in ('I9991');
-- select * from rcbill_extract.IV_SERVICEINSTANCE where clientcode in ('I.000011750') ;

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
    , si.CPE_TYPE
    
/*
CAPPED INTERNET	Modem
DTV	STBCONEX/STBBESTCAS
IPTV	STBRCBOSS
INTERNET	Modem
VOICE	Modem
GNET	ONT
CAPPED GNET	ONT
HOTSPOT ACCESS	
PREPAID INTERNET	
EMAIL	
NEXTTV	STBRCBOSS
GVOICE	ONT
MOBILE TV	
PREPAID TRAFFIC	
MISC SALES	
	
*/    
    , case 
			when si.CPE_TYPE = 'CAPPED INTERNET' then 'MODEM'
			when si.CPE_TYPE = 'INTERNET' then 'MODEM'
			when si.CPE_TYPE = 'VOICE' then 'MODEM'
			when si.CPE_TYPE = 'DTV' then 'STBCONAX/STBBESTCAS'
			when si.CPE_TYPE = 'IPTV' then 'STBRCBOSS'
			when si.CPE_TYPE = 'NEXTTV' then 'STBRCBOSS'
			when si.CPE_TYPE = 'CAPPED GNET' then 'ONT'
			when si.CPE_TYPE = 'GNET' then 'ONT'
			when si.CPE_TYPE = 'GVOICE' then 'ONT'
            else '' end as INVENTORYSUBTYPE
    
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
	, si.LASTSUBSTARTDATE
	, si.LASTSUBENDDATE
    , si.LASTINVFROMDATE
    , si.LASTINVTODATE
    , si.CURSUBSTARTDATE
    , si.CURSUBENDDATE
    , si.CURSUBPAYDATE
    , si.CURINVFROMDATE
    , si.CURINVTODATE
    
    , si.SUBFROM
    , si.SUBTO
    , si.SUBPERIOD
    -- , si.PACKAGENAME
    -- , si.CPE_TYPE
    -- , si.CPE_ID
    -- , si.FSAN
    -- , si.USERNAME
    , 'Y' as OVERRIDDEN


from rcbill_extract.IV_SERVICEINSTANCE si where 
-- CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390')  
-- and 
cpe_type like '%SUBSCRIPTION%' or cpe_type like '%PREPAID%'

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
cpe_type like '%SUBSCRIPTION%' or cpe_type like '%PREPAID%'

)
;


##################################################################################################################
-- PAYMENT HISTORY
select 'PAYMENT HISTORY' AS TABLENAME;

drop table if exists rcbill_extract.IV_PAYMENTHISTORY;

-- HARD= 101, 9999 (ANNULED)
-- HARD = 0 (CREDITED)
-- HARD = 1 (DEBIT)
-- TYPE = 11,21 (CREDIT OR DEBIT)
-- HARD NOT IN (100, 101, 102, 201, 999, 9999)

create table rcbill_extract.IV_PAYMENTHISTORY(index idxivbs1(CUSTOMERACCOUNTNUMBER),index idxivbs2(BILLINGACCOUNTNUMBER),index idxivbs3(DEBITDOCUMENTNUMBER), index idxivbs4(PAYMENTRECEIPTID))
(


	select 
			a.ID as PAYMENTRECEIPTID
			, ifnull((select BILLINGACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as BILLINGACCOUNTNUMBER
		-- , ifnull((select CUSTOMERACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER
			, ifnull((select ACCOUNTNUMBER from rcbill_extract.IV_CUSTOMERACCOUNT where client_id=a.CLID),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER
			, ifnull((select serviceinstancenumber from rcbill_extract.IV_SERVICEINSTANCE where client_id=a.CLID and contract_id=a.CID and servicerateid=a.RSID and serviceid=(a.PAYTYPE*-1) limit 1),'NOT PRESENT') as SERVICEINSTANCENUMBER

			, a.PAYDATE as PAYMENTDATE
            , a.BegDate as FROMDATE
            , a.EndDate as TODATE
			, a.UPDDATE as PAYMENTPROCESSEDDATE
			, a.ZAB as PAYMENTDESC
			, 'SCR' as PAYMENTCURRENCYALIAS
			, (select name from rcbill.rcb_payobjects where id=a.PAYOBJECTID) as PAYMENTMODE
			, a.MONEY as PAYMENTTRANSACTIONAMOUNT
			, a.ID as SERIALNUMBER
			, a.INVID as DEBITDOCUMENTNUMBER
			, a.CLID as CLIENT_ID
			, a.CID as CONTRACT_ID
			, a.MONEY as PAYMENTAMOUNT
			, a.BankReference as PAYMENTREASON
			, '' as EXCHANGERATE
			, a.DiscountMoney as DISCOUNT
			, a.hard as INVOICEHARD
			, a.USERID AS EMPLOYEEID
			, (SELECT `NAME` FROM rcbill.rcb_tickettechusers where RCBUSERID=a.USERID LIMIT 1) as EMPLOYEENAME
			, (SELECT `NAME` FROM rcbill.rcb_tickettechregions where ID = (select TechRegionID from rcbill.rcb_tickettechusers where RCBUSERID=a.USERID LIMIT 1) LIMIT 1) AS EMPLOYEEDEPARTMENT

	from rcbill.rcb_casa a 
	where CLID in (select rcbill.GetClientID(CLIENTCODE) from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')

);


##################################################################################################################
-- BILL SUMMARY
select 'BILL SUMMARY' AS TABLENAME;




drop table if exists rcbill_extract.IV_BILLSUMMARY;

-- HARD= 101, 9999 (ANNULED)
-- HARD = 0 (CREDITED)
-- HARD = 1 (DEBIT)
-- TYPE = 11,21 (CREDIT OR DEBIT)
-- HARD NOT IN (100, 101, 102, 201, 999, 9999)


create table rcbill_extract.IV_BILLSUMMARY(index idxivbs1(CUSTOMERACCOUNTNUMBER),index idxivbs2(BILLINGACCOUNTNUMBER),index idxivbs3(DEBITDOCUMENTNUMBER))
(
	select * 
	, concat(a.BILLINGACCOUNTNUMBER,'-',a.DEBITDOCUMENTNUMBER,'-','.pdf') as INVOICE_PDF_NAME

	from 
	(

		select 
		-- *, 
		a.ID as INVOICESUMMARYID
		, a.INVOICENO as DEBITDOCUMENTNUMBER
		, a.DATA as CREATEDATE
		, a.SUMA as SUBTOTAL
		, a.DDS as TAX
		, a.DEBT as UNPAID
		, 0 as WRITEOFF
		, a.REASON as REMARK
		, a.DUEDATE as DUEDATE
		, a.TOTAL as TOTALDUE
		, 'N' as DISPUTED
		, a.UPDDATE as BILLDATE
		, 0 as SURCHARGE
		, a.RATE as SYSCURRENCYEXCHANGERATE
		, a.TOTAL as TOTALAMOUNT
		, a.SUMA as DISCOUNTABLE
		, a.Avance as DISCOUNTED
		, a.SUMA as TAXABLE
		, a.BEGDATE as FROMDATE
		, a.ENDDATE as TODATE
		, 0 as DEPOSIT
		-- , ifnull((select BILLINGACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID),concat('BA_', rcbill.GetClientCode(a.CLID))) as BILLINGACCOUNTNUMBER
		, ifnull((select BILLINGACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID),'NOT PRESENT') as BILLINGACCOUNTNUMBER
		-- , ifnull((select CUSTOMERACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER
        , ifnull((select ACCOUNTNUMBER from rcbill_extract.IV_CUSTOMERACCOUNT where client_id=a.CLID),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER

		, a.TOTAL as ADJUSTEDAMOUNT 

		, ifnull((select BILLCYCLE from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID),'NOT PRESENT') as BILLCYCLE

		, a.Currency as CURRENCYALIAS
		, a.OriginalCurrency as ORIGINALCURRENCY
        , a.CREATOR as CREATEDBY
		, a.PROFORMANO as PROFORMAINVOICENUMBER
		, a.SRCNO as CREDITINVOICENUMBER
		, a.DKINO as DEBITINVOICENUMBER
		, a.TYPE as INVOICETYPE
		, a.HARD as INVOICEHARD
        , a.CLID as CLIENT_ID
        , a.CID as CONTRACT_ID
		from 

		rcbill.rcb_invoicesheader a 
		where a.clid in (select rcbill.GetClientID(CLIENTCODE) from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
		-- where clid in (@clid9)
		-- where a.clid in (@clid1,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11)

	) a 
)
;


##################################################################################################################
-- BILL DETAILS
select 'BILL DETAIL' AS TABLENAME;


drop table if exists rcbill_extract.IV_BILLDETAIL;

create table rcbill_extract.IV_BILLDETAIL(index idxivbd1(CUSTOMERACCOUNTNUMBER),index idxivbd2(BILLINGACCOUNTNUMBER),index idxivbd3(DEBITDOCUMENTNUMBER),index idxivbd4(SERVICEINSTANCENUMBER))
(
	select 
			ifnull((select BILLINGACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as BILLINGACCOUNTNUMBER
		-- , ifnull((select CUSTOMERACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER
			, ifnull((select ACCOUNTNUMBER from rcbill_extract.IV_CUSTOMERACCOUNT where client_id=a.CLID),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER
			, ifnull((select serviceinstancenumber from rcbill_extract.IV_SERVICEINSTANCE where client_id=a.CLID and contract_id=a.CID and servicerateid=a.RSID and serviceid=a.ServiceID limit 1),'NOT PRESENT') as SERVICEINSTANCENUMBER
			,
			a.ID as INVOICEDETAILID
			, a.InvoiceID as INVOICESUMMARYID
			, a.ID as SERIALNUMBER
			, a.INVOICENO as DEBITDOCUMENTNUMBER
			, a.TEXT as NAME
			, a.SCOST as RATE
			, a.NUMBER as ITEMCOUNT
			, a.COST as SUBTOTAL
			, a.CostVAT as TAX
			, a.DiscountCost as DISCOUNT
			, a.Discount as DISCOUNTPERCENT
			, a.CostTotal as TOTALAMOUNT
			, a.COST as DISCOUNTABLE
			, a.DiscountCost as DISCOUNTED
			, a.COST as TAXABLE
			, 0 as UNPAID
			, 0 as WRITEOFF
			, '' as REMARK
			, a.FROMDATE
			, a.TODATE
			
			/*
			, ifnull((select BILLINGACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as BILLINGACCOUNTNUMBER
			, ifnull((select CUSTOMERACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER
			, ifnull((select serviceinstancenumber from rcbill_extract.IV_SERVICEINSTANCE where client_id=a.CLID and contract_id=a.CID and servicerateid=a.RSID and serviceid=a.ServiceID limit 1),'NOT PRESENT') as SERVICEINSTANCENUMBER
			, ifnull((select BILLCYCLE from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as BILLCYCLE
			*/
			, ifnull((select BILLCYCLE from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as BILLCYCLE
			, case 
				   when (a.Discount <> 0 or a.DiscountCost <> 0) then 'PRT13' 
				   when a.TEXT like '%DISCOUNT%' then 'PRT13'
				   when a.TEXT like '%\%' then 'PRT13'
				   when trim(a.TEXT) = 'VOUCHERS' then 'PRT13'
				   when a.TEXT like '%SUBSCRIPTION%' then 'PRT00'
				   when a.TEXT like '%PREPAID%' then 'PRT00'
				   when a.TEXT like '%ADDON%' then 'PRT00'
				   when a.TEXT like '%VIDEO ON DEMAND%' then 'PRT00'
				   when a.TEXT like 'TURQUOISE%' then 'PRT00'
				   when trim(a.TEXT) = 'GVOICE' then 'PRT00'
				   when trim(a.TEXT) = 'INDIAN CORPORATE' then 'PRT00'
				   when trim(a.TEXT) = 'CAPPED INTERNET' then 'PRT00'
				   when trim(a.TEXT) = 'ITERMIZED BILL' then 'PRT00'
				   when a.TEXT like '%INSTALLATION%' then 'PRT06'
				   when a.TEXT like '%MATERIALS%' then 'PRT06'
				   when a.TEXT like '%HARDWARE%' then 'PRT06'
				   when a.TEXT like '%OTHER CHARGES%' then 'PRT06'
				   when a.TEXT like 'RELOCATION%' then 'PRT06'
				   when a.TEXT like '%USAGE%' then 'PRT10'
				   when a.TEXT like '%BUNDLE%' then 'PRT00'
				   when trim(a.TEXT) = 'CONVERT CONTRACT' then 'PRT00'
				   when trim(a.TEXT) = 'MQ BALANCE' then 'PRT00'
				   else '' end as `PRODUCTTYPEID`
			
			
			, case when a.TEXT like '%DEPOSIT%' then a.CostTotal
				else 0 end as DEPOSIT

			, case when ((a.Discount=0 and a.DiscountCost=0) and a.SCOST>a.COST) then 'Y' 
				else 'N' end as PRORATIONTYPE
			, 0 as ADJUSTEDAMOUNT
			, ifnull((select PACKAGENAME from rcbill_extract.IV_SERVICEINSTANCE where client_id=a.CLID and contract_id=a.CID and servicerateid=a.RSID and serviceid=a.ServiceID limit 1),'NOT PRESENT') as PACKAGENAME
			, a.UPDDATE as BILLDATE
			, ifnull((select CURRENCYALIAS from rcbill_extract.IV_BILLSUMMARY where DEBITDOCUMENTNUMBER=a.INVOICENO limit 1),'NOT PRESENT') as CURRENCYALIAS
			
			
			, case when a.Discount>0 then 'Y'
				else 'N' end as D_DISCOUNTPCT
			
			, a.Discount as D_PCTDISCOUNT
			, '' as D_DISCOUNTNAME
			, a.DiscountCost as D_ABSDISCOUNT
			
			, ifnull((select SYSCURRENCYEXCHANGERATE from rcbill_extract.IV_BILLSUMMARY where DEBITDOCUMENTNUMBER=a.INVOICENO limit 1),'NOT PRESENT') as D_SYSCURRENCYEXCHANGERATE
			, a.VAT as T_RATE
			, case when a.VAT>0 then 'VAT' else '' end as T_TAXNAME
			, 0 as T_EXEMPTIONRATE
			, 0 as T_UNPAID
			, 0 as T_WRITEOFF
			, 'PCT' as T_TAXRATETYPE
			, 'N' as T_TAXOVERRIDDEN
			, 0 as T_EXEMPTIONAMT
			, case when a.VAT>0 then 'NON' else 'BTH' end as T_EXEMPTIONAPPLICABILITY
			
			
			, a.CLID as CLIENT_ID
			, a.CID as CONTRACT_ID
			, a.RSID
			, a.ServiceID

	from 
	rcbill.rcb_invoicescontents a 

	where a.InvoiceID in (select INVOICESUMMARYID from rcbill_extract.IV_BILLSUMMARY) -- where CLIENT_ID in (@clid2, @clid3)) -- ,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11))
	-- limit 1000
	-- where a.clid in (701369)
	-- where clid in (select rcbill.GetClientID(CLIENTCODE) from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
	-- where a.clid in (@clid1) -- ,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11)



)
;





##################################################################################################################
-- NBD
select 'NBD' AS TABLENAME;

drop table if exists rcbill_extract.IV_NBD;

drop temporary table if exists tempt1;

create temporary table tempt1 (index idx1(id))
(
	select id, invoicingdate from rcbill.rcb_contracts 
)
;

drop temporary table if exists tempt2;

create temporary table tempt2 (index idx1(cid))
(
	select id, cid, data as INVOICEDATE from rcbill.rcb_invoicesheader 
)
;


create table rcbill_extract.IV_NBD (index idxnbd1(BILLINGACCOUNTNUMBER),index idxnbd2(CUSTOMERACCOUNTNUMBER))
(
	select 
    a.CUSTOMERACCOUNTNUMBER
	, a.BILLINGACCOUNTNUMBER
	, a.LASTBILLINGDATE
	, case when a.ACCOUNTSTATUS=1 and a.BILLCYCLE<>'DEFAULT' then date_add(LASTBILLINGDATE, interval 1 month) end as NEXTBILLINGDATE
	, a.BILLCYCLE
	, a.ACCOUNTSTATUS
	, a.BILLINGDAY
	from 
	(
		select 
		a.BILLINGACCOUNTNUMBER
        , a.CUSTOMERACCOUNTNUMBER
		, a.BILLCYCLE, a.ACCOUNTSTATUS
		-- , (select InvoicingDate from rcbill.rcb_contracts where id=a.contract_id order by id desc limit 1) as BILLINGDAY
		, (select InvoicingDate from tempt1 where id=a.contract_id order by id desc limit 1) as BILLINGDAY
		-- , (select data from rcbill.rcb_invoicesheader where cid=a.contract_id order by id desc limit 1) as LASTBILLINGDATE
		, (select INVOICEDATE from tempt2 where cid=a.contract_id order by id desc limit 1) as LASTBILLINGDATE
		  

		from rcbill_extract.IV_BILLINGACCOUNT a 
		-- where client_id in (@clid1,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11)
	) a 
)
;



##################################################################################################################

-- DSCOUNT
select 'DISCOUNT' AS TABLENAME;

drop table if exists rcbill_extract.IV_DISCOUNT;


create table rcbill_extract.IV_DISCOUNT
(
	select a.*
	, d.SERVICEINSTANCENUMBER
	from 
	(
		select
		-- a.*,
		a.BILLINGACCOUNTNUMBER
		, a.CUSTOMERACCOUNTNUMBER
		-- , d.SERVICEINSTANCENUMBER
		, a.BILLCYCLE, a.ACCOUNTSTATUS
		, b.servicename as SERVICENAME, b.percent as DISCOUNTPERCENT, b.amount as DISCOUNTAMOUNT, b.approved as APPROVEDSTATUS, b.approvalreason as APPROVALREASON
		, 0 as CYCLECOUNT
		, c.client_id, c.contract_id
		from rcbill_extract.IV_BILLINGACCOUNT a 
		-- where client_id in (@clid1,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11)
		inner join rcbill_extract.BILLINGACCOUNT_KEY c 
		on a.BILLINGACCOUNTNUMBER=c.BILLINGACCOUNTNUMBER
		inner join
		rcbill.clientcontractdiscounts b 
		on c.client_id=b.clientid and c.contract_id=b.contractid
		
		-- where a.CUSTOMERACCOUNTNUMBER in (@custid1)
	) a 
	inner join 
	 rcbill_extract.IV_SERVICEINSTANCE d
		on a.client_id=d.CLIENT_ID and a.contract_id=d.CONTRACT_ID
		and a.SERVICENAME=d.CPE_TYPE
)
;
    




##################################################################################################################

-- BALANCE
select 'BALANCE' AS TABLENAME;

drop table if exists rcbill_extract.IV_BALANCE;


create table rcbill_extract.IV_BALANCE(index idxbal1(SERVICEINSTANCENUMBER),index idxbal2(CUSTOMERACCOUNTNUMBER),index idxbal3(BILLINGACCOUNTNUMBER),index idxbal4(SERVICEINSTANCEIDENTIFIER))
(

		SELECT a.*


		, case when a.SUBTO>date(SUBDATE(NOW(),1)) then round( ( TIMESTAMPDIFF(MONTH, date(SUBDATE(NOW(),1)) , a.SUBTO) +
		  DATEDIFF(
			a.SUBTO,
			date(SUBDATE(NOW(),1))  + INTERVAL
			  TIMESTAMPDIFF(MONTH, date(SUBDATE(NOW(),1)) , a.SUBTO)
			MONTH
		  ) /
		  DATEDIFF(
			date(SUBDATE(NOW(),1))  + INTERVAL
			  TIMESTAMPDIFF(MONTH, date(SUBDATE(NOW(),1)) , a.SUBTO) + 1
			MONTH,
			date(SUBDATE(NOW(),1))  + INTERVAL
			  TIMESTAMPDIFF(MONTH, date(SUBDATE(NOW(),1)) , a.SUBTO)
			MONTH
		  ) ),0) end as REMAININGSUBPERIOD  

		, ((a.PACKAGEQUOTA_GB)*CEIL(a.SUBPERIOD)) as TOTAL_PACKAGEQUOTA_GB
		, case when a.SERVICESTATUS='Active' then ((a.PACKAGEQUOTA_GB)*CEIL(a.SUBPERIOD) - a.TOTAL_USAGE_GB) 
			else 0 end as BALANCE_GB
		from 
		(
				select 
					a.SERVICEINSTANCENUMBER
					, a.PACKAGENAME
					, case when a.PACKAGENAME='STARTER' then 1
							when a.PACKAGENAME='VALUE' then 3
							when a.PACKAGENAME='ELITE' then 20
							when a.PACKAGENAME='EXTREME' then 40
							when a.PACKAGENAME='EXTREME PLUS' then 80
							when a.PACKAGENAME='PERFORMANCE' then 150
							when a.PACKAGENAME='PERFORMANCE PLUS' then 300
							end as PACKAGEQUOTA_GB
							
					
					, a.SUBFROM
					, a.SUBTO
					, a.SUBPERIOD
					/*
					,  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO) +
					  DATEDIFF(
						a.SUBTO,
						a.SUBFROM + INTERVAL
						  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO)
						MONTH
					  ) /
					  DATEDIFF(
						a.SUBFROM + INTERVAL
						  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO) + 1
						MONTH,
						a.SUBFROM + INTERVAL
						  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO)
						MONTH
					  ) as SUBPERIOD  
					  
					  */
					, a.CUSTOMERACCOUNTNUMBER
					, a.BILLINGACCOUNTNUMBER
					, a.SERVICEACCOUNTNUMBER
					, a.SERVICEINSTANCEIDENTIFIER
					, a.SERVICESTATUS
					, a.CPE_TYPE
					, a.PACKAGEAMOUNT
					, a.LASTACTION
					, a.clientcode
					, a.contractcode
					, a.client_id
					, a.contract_id
					
					, max(a.LASTUSAGEDATE) as LASTUSAGEDATE
					, ifnull(sum(a.MB_TOTAL_USAGE),0) as TOTAL_USAGE_PREADDON_MB
					, max(a.LAST_ADD_ON_DATE) as LAST_ADD_ON_DATE
					, ifnull(sum(a.ADD_ON_TOTAL),0) as ADD_ON_TOTAL_MB
					
					, (ifnull(sum(a.MB_TOTAL_USAGE),0) + ifnull(sum(a.ADD_ON_TOTAL),0)) as TOTAL_USAGE_MB
					, (ifnull(sum(a.MB_TOTAL_USAGE),0) + ifnull(sum(a.ADD_ON_TOTAL),0))/1024 as TOTAL_USAGE_GB
					from 
					(
						select 
						a.SERVICEINSTANCENUMBER
						, a.PACKAGENAME
						, a.SUBFROM
						, a.SUBTO
						, a.SUBPERIOD
						, a.CUSTOMERACCOUNTNUMBER
						, a.BILLINGACCOUNTNUMBER
						, a.SERVICEACCOUNTNUMBER
						, a.SERVICEINSTANCEIDENTIFIER
						, a.SERVICESTATUS
						, a.CPE_TYPE
						, a.PACKAGEAMOUNT
						, a.LASTACTION
						, a.clientcode
						, a.contractcode
						, a.client_id
						, a.contract_id
						, a.PROCESSEDCLIENTIP
						, a.TRAFFICTYPE
						-- , max(a.USAGEDATE) as LASTUSAGEDATE
						, sum(a.MB_UL) as MB_UL
						, sum(a.MB_DL) as MB_DL
						-- , sum(a.MB_TOTAL) as MB_TOTAL_USAGE
						-- , sum(a.GB_TOTAL) as GB_TOTAL_USAGE
						, case when a.PROCESSEDCLIENTIP = '0.0.0.0' then max(a.USAGEDATE) end as LAST_ADD_ON_DATE
						, case when a.PROCESSEDCLIENTIP = '0.0.0.0' then sum(a.MB_DL) end as ADD_ON_TOTAL
						, case when a.PROCESSEDCLIENTIP <> '0.0.0.0' then max(a.USAGEDATE) end as LASTUSAGEDATE
						, case when a.PROCESSEDCLIENTIP <> '0.0.0.0' then sum(a.MB_TOTAL) end as MB_TOTAL_USAGE
						from 
						(
								select 
								a.*
								, '' as `|`
								-- , b.*
								, b.PROCESSEDCLIENTIP
								, b.TRAFFICTYPE
								
								, b.MB_UL
								, b.MB_DL
								, b.MB_TOTAL
								, ((b.MB_TOTAL)/1024) as GB_TOTAL
								, b.USAGEDATE

								from 
								(

										select 
										a.SERVICEINSTANCENUMBER, a.PACKAGENAME
										, a.SUBFROM
										, a.SUBTO
										, a.SUBPERIOD
										-- , if(ifnull(date(a.LASTSUBSTARTDATE),date(a.LASTINVFROMDATE))>a.CURSUBSTARTDATE,a.CURSUBSTARTDATE,ifnull(date(a.LASTSUBSTARTDATE),date(a.LASTINVFROMDATE))) as SUB_FROM
										-- , if(ifnull(date(a.LASTSUBENDDATE),date(a.LASTINVTODATE))>a.CURSUBENDDATE,a.CURSUBENDDATE,ifnull(date(a.LASTSUBENDDATE),date(a.LASTINVTODATE))) as SUB_TO
										-- , ifnull(date(a.LASTSUBENDDATE),date(a.LASTINVTODATE)) as SUBTO
										, a.CUSTOMERACCOUNTNUMBER
										, a.BILLINGACCOUNTNUMBER
										, a.SERVICEACCOUNTNUMBER
										, a.SERVICEINSTANCEIDENTIFIER
										, a.SERVICESTATUS
										, a.CPE_TYPE
										, a.PACKAGEAMOUNT
										, a.LASTACTION
										, a.clientcode
										, a.contractcode
										, a.client_id
										, a.contract_id

										from 
										(

												select 

												--  a.* 
												-- , '' as `SEP1`
												-- , b.*



												a.*
												, b.CUSTOMERACCOUNTNUMBER
												, b.BILLINGACCOUNTNUMBER
												, b.SERVICEACCOUNTNUMBER
												, b.SERVICEINSTANCEIDENTIFIER
												, b.SERVICESTATUS
												, b.PACKAGEAMOUNT
												, b.CPE_TYPE
												, b.LASTACTION
												, b.clientcode
												, b.contractcode
												, b.CLIENT_ID
												, b.CONTRACT_ID



												from rcbill_extract.IV_ADDON a
												left join 
												rcbill_extract.IV_SERVICEINSTANCE b 
												on 
												a.SERVICEINSTANCENUMBER=b.SERVICEINSTANCENUMBER

												-- left join 
												-- rcbill_extract.IV_BILLINGACCOUNT c
												-- on b.BILLINGACCOUNTNUMBER=c.BILLINGACCOUNTNUMBER
												where 0=0
												and (b.CPE_TYPE like ('%CAPPED%') or b.CPE_TYPE like ('%PREPAID%'))
												
												-- and b.SERVICESTATUS='Active'
												-- and b.client_id=718650 -- nelson lalande
												-- and b.CLIENT_ID=715432 -- russian embassy
												-- and b.CLIENT_ID=723711
												-- and b.CLIENT_ID=721030
												-- and b.clientcode='I8002'
												-- and b.clientcode='I7571'
												-- and b.clientcode='I6415' -- farouk baptist (PROBLEM ACCOUNT)
												-- and b.clientcode='I.000000852' -- Julianne Monique Marie
												-- and b.clientcode='I.000012979' -- Selma Lesperance Sey Police Bulk
												-- and b.clientcode='I.000008120' -- Four Seasons IPTV Housing - Block No 6 (PROBLEM)
												-- and b.clientcode='I.000003756'
												-- and b.clientcode='I.000009391' -- surman apartment
										) a 
								) a
								left join 
								rcbill.clientcontractipusage b
								on a.client_id=b.client_id and a.contract_id=b.contract_id and (b.usagedate>=a.subfrom and b.usagedate<=a.subto) and b.TRAFFICTYPE='Default'


						) a 
						group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
					) a 
					group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
		) a

)
;
##################################################################################################################



-- select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390')  order by ACCOUNTNUMBER;
-- select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390')  order by CUSTOMERACCOUNTNUMBER;
-- select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390') 
 -- and ACCOUNTSTATUS=1
-- order by CUSTOMERACCOUNTNUMBER;
 
-- select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390') ;

-- select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390') );

-- select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390') );

-- select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390') );

-- select * from rcbill_extract.IV_ADDONCHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in ('CA_I14','CA_I.000009787','CA_I.000011750','CA_I.000018187','CA_I.000011998','CA_I7','CA_I.000021409','CA_I.000021390') );

##################################################################################################################



select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (@custid1,@custid2,@custid3,@custid4,@custid5,@custid6,@custid7,@custid8,@custid9,@custid10,@custid11)  order by ACCOUNTNUMBER;
select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3,@custid4,@custid5,@custid6,@custid7,@custid8,@custid9, @custid10,@custid11) order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3,@custid4,@custid5,@custid6,@custid7,@custid8,@custid9, @custid10,@custid11)  order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3,@custid4,@custid5,@custid6,@custid7,@custid8,@custid9, @custid10,@custid11);
select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3,@custid4,@custid5,@custid6,@custid7,@custid8,@custid9, @custid10,@custid11) );
select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3,@custid4,@custid5,@custid6,@custid7,@custid8,@custid9, @custid10,@custid11) );
select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3,@custid4,@custid5,@custid6,@custid7,@custid8,@custid9, @custid10,@custid11) );
select * from rcbill_extract.IV_ADDONCHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3,@custid4,@custid5,@custid6,@custid7,@custid8,@custid9, @custid10,@custid11) );
select * from rcbill_extract.IV_BILLSUMMARY where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3,@custid4,@custid5,@custid6,@custid7,@custid8,@custid9, @custid10,@custid11) order by INVOICESUMMARYID;
select * from rcbill_extract.IV_PAYMENTHISTORY where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3,@custid4,@custid5,@custid6,@custid7,@custid8,@custid9, @custid10,@custid11) order by PAYMENTRECEIPTID;
select * from rcbill_extract.IV_NBD where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3,@custid4,@custid5,@custid6,@custid7,@custid8,@custid9, @custid10,@custid11) order by BILLINGACCOUNTNUMBER;
select * from rcbill_extract.IV_DISCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3,@custid4,@custid5,@custid6,@custid7,@custid8,@custid9, @custid10,@custid11) order by BILLINGACCOUNTNUMBER;


set @custid1 = 'CA_I14';
set @custid1 = 'CA_I.000009787';
set @custid1 = 'CA_I.000011750';
set @custid4 = 'CA_I.000018187';
set @custid5 = 'CA_I.000011998';
set @custid6 = 'CA_I7';
set @custid7 = 'CA_I.000021409';
set @custid8 = 'CA_I.000021390';
set @custid9 = 'CA_I9991';
set @custid10 = 'CA_I.000021467';
set @custid11 = 'CA_I.000020888';
set @custid1 = 'CA_I16192';


set @custid1 = 'CA_I.000021854';
set @custid1 = 'CA_I.000008363';
set @custid1 = 'CA_I9979';
set @custid1 = 'CA_I.000009596';
set @custid1 = 'CA_I.000017595';
set @custid1 = 'CA_I9452';
set @custid1 = 'CA_I9589';
set @custid1 = 'CA_I.000003551'; -- russian embassy
set @custid11 = 'CA_I7571'; -- maxwell philoe

set @custid1 = 'CA_I19819'; 
set @custid1 = 'CA_I6415'; -- Farouk Jean Baptiste
set @custid1 = 'CA_I.000000852'; -- Julianne Monique Marie

set @custid1 = 'CA_I23018'; -- amazon betting

set @custid1 = 'CA_I9695';  -- Marlene Rassool


select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (@custid1)  order by ACCOUNTNUMBER;
select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1) order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1)  order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1);
select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_ADDONCHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );


select * from rcbill_extract.IV_BILLSUMMARY where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_BILLDETAIL where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;

select * from rcbill_extract.IV_PAYMENTHISTORY where CUSTOMERACCOUNTNUMBER in (@custid1) order by PAYMENTRECEIPTID desc;
select * from rcbill_extract.IV_NBD where CUSTOMERACCOUNTNUMBER in (@custid1) order by BILLINGACCOUNTNUMBER;
select * from rcbill_extract.IV_DISCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1) order by BILLINGACCOUNTNUMBER;
select * from rcbill_extract.IV_BALANCE where CUSTOMERACCOUNTNUMBER in (@custid1) order by SERVICEINSTANCENUMBER desc;


select * from rcbill_extract.IV_PAYMENTHISTORY where customeraccountnumber ='NOT PRESENT';

/*


select * from rcbill_extract.IV_BILLINGACCOUNT where BillingAccountNumber='BA_I23018_I245713.1_1';

select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid11) and ServiceStatus='Active';
select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid11) );


select billcycle, count(*) from rcbill_extract.IV_NBD group by billcycle


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

