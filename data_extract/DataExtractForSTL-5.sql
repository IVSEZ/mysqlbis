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
, a.CLCLASS    
, a.FIZLICE
    
from rcbill.rcb_tclients a 
where
0=0
-- and a.CLClass in (13)


-- and kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
and kod in (@kod1,@kod2,@kod3,@kod4,@kod5,@kod6,@kod7,@kod8,@kod9,@kod10, @kod11)


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


###################################################################################

####	BILLING ACCOUNT

-- select * from rcbill.clientcontractsservicepackageprice where clientcode='I7';
-- select * from rcbill_my.rep_clientcontractdevices where client_code='I7';


select 'IV_PREP_clientcontractsservicepackagepricedevice' AS TABLENAME;

drop table if exists rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice;

create table rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice(index idxipccsppd1(clientcode), index idxipccsppd2(contractcode)) as 
(
			select a.*
            , rcbill.GetClientID(a.clientcode) as CLIENT_ID
            , rcbill.GetContractID(a.contractcode) as CONTRACT_ID
            
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
             
             -- where a.clientcode in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
             where a.clientcode in (@kod1,@kod2,@kod3,@kod4,@kod5,@kod6,@kod7,@kod8,@kod9,@kod10,@kod11)

             
        
             -- order by a.clientcode asc, a.contractstatus desc, a.contractcode desc
             order by CLIENT_ID asc, a.contractstatus desc, CONTRACT_ID desc
);


-- select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where clientcode in ('I.000011750') order by contractenddate desc;
-- select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where clientcode in ('I9991') order by contractenddate desc;
-- select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where clientcode in ('I7') order by contractenddate desc;

select 'IV_PREP_BILLINGACCOUNT_A1' AS TABLENAME;


drop table if exists rcbill_extract.IV_PREP_BILLINGACCOUNT_A1;
create table rcbill_extract.IV_PREP_BILLINGACCOUNT_A1(index idxipba1(clientcode), index idxipba2(contractcode)) as 
(
	select a.clientcode, a.clientname, a.contractcode, a.currentstatus, a.currency, a.ratingplanname, a.creditpolicyname
    , a.MaxInvDate, a.MinInvDate
    , a.package, a.service, a.lastcontractdate, a.lastaction
--    , case when MaxInvDate=0 and MinInvDate=0 then 'PREPAID'
-- 	else 'POSTPAID' end as `BILLCYCLE`
    , case when a.MinInvDate=0 then 'PREPAID'
     when a.MinInvDate is null then 'PREPAID'
	else 'POSTPAID' end as `BILLCYCLE`
    , cast(concat('BA_',a.clientcode,'_',a.contractcode) as char(255)) as `BillingAccountNumber`
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

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 a where a.clientcode in ('I7') order by a.client_id asc, a.currentstatus asc, a.contract_id desc ;




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
		-- cast(concat('BA_',clientcode,'_',currency, ratingplanname, billcycle , CreditPolicyName) as char(255)) as `BillingKey`
        cast(concat('BA_',clientcode,'_',currency,'_', billcycle) as char(255)) as `BillingKey`

		-- , cast(concat('BA_',clientcode,'_',contractcode) as char(255)) as `BillingAccountNumber`
        , BillingAccountNumber
		, contractcode
        , client_id
        , contract_id
		, currency, ratingplanname, billcycle , CreditPolicyName
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
		-- group by 1,2,3,4,5,6,7
		-- group by 1,2,3,4
        -- group by clientcode, currency, billcycle
        group by 1,2
        -- order by a.client_id asc , a.currentstatus asc, a.contract_id desc
        -- order by a.client_id asc, a.contract_id desc , a.currentstatus asc
		-- order by a.contractcode desc , a.currentstatus asc
	) a
    where a.BillingKey is not null
    -- order by a.clientcode asc, a.CONTRACTCODE desc, a.billingkey desc
    order by a.client_id asc, a.contract_id desc, a.billingkey desc
)
;

-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2;
 select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1;
 select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2;

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
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I9991');
 select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where clientcode in ('I7');
 select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where clientcode in ('I7');
 select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I7');
-- select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where clientcode in ('I.000018187');




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
    -- where a.clientcode='I.000009787'
	order by a.clientcode desc
)
;

-- select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I7') order by CUSTOMERACCOUNTNUMBER;
-- select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I.000011750') order by CUSTOMERACCOUNTNUMBER;
