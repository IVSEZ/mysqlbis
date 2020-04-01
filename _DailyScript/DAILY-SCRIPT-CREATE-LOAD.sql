#CLIENT SCRIPT
use rcbill;

#SET DATE
-- SET @REPORTDATE=str_to_date('2018-09-20','%Y-%m-%d');

-- SET @rundate='2018-09-20';

-- SET @COLNAME1='CLIENTDEBT_REPORTDATE';


## change all the csv dates (13 files in total)

###################################
# CLIENTS TABLE

use rcbill;

drop table if exists rcb_tclients;

CREATE TABLE `rcb_tclients` (

`ID` int(11) DEFAULT NULL	,
`FIRM` varchar(255) DEFAULT NULL	,
`KOD` varchar(255) DEFAULT NULL	,
`BULSTAT` varchar(255) DEFAULT NULL	,
`PASSNo` varchar(255) DEFAULT NULL	,
`PASSIssueDate` datetime DEFAULT NULL	,
`PASSIssueFrom` varchar(255) DEFAULT NULL	,
`DANNO` varchar(255) DEFAULT NULL	,
`BANK` varchar(255) DEFAULT NULL	,
`BANKNO` int(11) DEFAULT NULL	,
`ACCOUNT` varchar(255) DEFAULT NULL	,
`DDSACCOUNT` varchar(255) DEFAULT NULL	,
`DDS` int(11) DEFAULT NULL	,
`ADDRESS` varchar(255) DEFAULT NULL	,
`CITY` varchar(255) DEFAULT NULL	,
`Country` varchar(255) DEFAULT NULL	,
`POSTALCODE` varchar(255) DEFAULT NULL	,
`FAX` varchar(255) DEFAULT NULL	,
`BOSS` varchar(255) DEFAULT NULL	,
`BPHONE` varchar(255) DEFAULT NULL	,
`BEMAIL` varchar(255) DEFAULT NULL	,
`MOL` varchar(255) DEFAULT NULL	,
`MOLADDRESS` varchar(255) DEFAULT NULL	,
`MEGN` varchar(255) DEFAULT NULL	,
`MPHONE` varchar(255) DEFAULT NULL	,
`MEMAIL` varchar(255) DEFAULT NULL	,
`RECIPIENT` varchar(255) DEFAULT NULL	,
`NOTE` varchar(255) DEFAULT NULL	,
`DISCOUNT` decimal(12,5) DEFAULT NULL	,
`FIZLICE` int(11) DEFAULT NULL	,
`BEGDATE` datetime DEFAULT NULL	,
`ENDDATE` datetime DEFAULT NULL	,
`CLTYPE` int(11) DEFAULT NULL	,
`CLClass` int(11) DEFAULT NULL	,
`ParentID` int(11) DEFAULT NULL	,
`DeliveryCLID` int(11) DEFAULT NULL	,
`DeliveryDepoID` int(11) DEFAULT NULL	,
`RegionID` int(11) DEFAULT NULL	,
`Active` int(11) DEFAULT NULL	,
`ActiveTill` datetime DEFAULT NULL	,
`CompanyGroupID` int(11) DEFAULT NULL	,
`IssuesProformaInv` int(11) DEFAULT NULL	,
`IssuesVATInv` int(11) DEFAULT NULL	,
`ID_OLD` varchar(255) DEFAULT NULL	,
`UPDDATE` datetime DEFAULT NULL	,
`USERID` int(11) DEFAULT NULL	,
`MOLRegistrationAddress` varchar(255) DEFAULT NULL	,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;


# FILL IN DATA
-- SET SESSION sql_mode = 'STRICT_ALL_TABLES';
use rcbill;
-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTClients-31032020.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_tclients` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_tclients` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID	,
@FIRM	,
@KOD	,
@BULSTAT	,
@PASSNo	,
@PASSIssueDate	,
@PASSIssueFrom	,
@DANNO	,
@BANK	,
@BANKNO	,
@ACCOUNT	,
@DDSACCOUNT	,
@DDS	,
@ADDRESS	,
@CITY	,
@Country	,
@POSTALCODE	,
@FAX	,
@BOSS	,
@BPHONE	,
@BEMAIL	,
@MOL	,
@MOLADDRESS	,
@MEGN	,
@MPHONE	,
@MEMAIL	,
@RECIPIENT	,
@NOTE	,
@DISCOUNT	,
@FIZLICE	,
@BEGDATE	,
@ENDDATE	,
@CLTYPE	,
@CLClass	,
@ParentID	,
@DeliveryCLID	,
@DeliveryDepoID	,
@RegionID	,
@Active	,
@ActiveTill	,
@CompanyGroupID	,
@IssuesProformaInv	,
@IssuesVATInv	,
@ID_OLD	,
@UPDDATE	,
@USERID	,
@MOLRegistrationAddress
) 
set 
ID=@ID,
FIRM=upper(trim(@FIRM)),
KOD=upper(trim(@KOD)),
BULSTAT=@BULSTAT,
PASSNo=@PASSNo,
-- PASSIssueDate=str_to_date(@PASSIssueDate,'%d-%m-%y %k:%i'),
-- PASSIssueFrom=str_to_date(@PASSIssueFrom,'%d-%m-%y %k:%i'),
PASSIssueDate=@PASSIssueDate,
PASSIssueFrom=@PASSIssueFrom,
DANNO=@DANNO,
BANK=@BANK,
BANKNO=@BANKNO,
ACCOUNT=@ACCOUNT,
DDSACCOUNT=@DDSACCOUNT,
DDS=@DDS,
ADDRESS=upper(trim(@ADDRESS)),
CITY=upper(trim(@CITY)),
Country=upper(trim(@Country)),
POSTALCODE=@POSTALCODE,
FAX=@FAX,
BOSS=upper(trim(@BOSS)),
BPHONE=@BPHONE,
BEMAIL=upper(trim(@BEMAIL)),
MOL=upper(trim(@MOL)),
MOLADDRESS=upper(trim(@MOLADDRESS)),
MEGN=@MEGN,
MPHONE=@MPHONE,
MEMAIL=@MEMAIL,
RECIPIENT=@RECIPIENT,
NOTE=@NOTE,
DISCOUNT=@DISCOUNT,
FIZLICE=@FIZLICE,
BEGDATE=@BEGDATE,
ENDDATE=@ENDDATE,
CLTYPE=@CLTYPE,
CLClass=@CLClass,
ParentID=@ParentID,
DeliveryCLID=@DeliveryCLID,
DeliveryDepoID=@DeliveryDepoID,
RegionID=@RegionID,
Active=@Active,
ActiveTill=@ActiveTill,
CompanyGroupID=@CompanyGroupID,
IssuesProformaInv=@IssuesProformaInv,
IssuesVATInv=@IssuesVATInv,
ID_OLD=@ID_OLD,
UPDDATE=@UPDDATE,
USERID=@USERID,
MOLRegistrationAddress=upper(trim(@MOLRegistrationAddress)),
INSERTEDON=now(),
REPORTDATE=@REPORTDATE
;

-- select * from rcbill.rcb_tclients where firm like 'rahul%'
-- select count(*) from rcb_tclients;



CREATE INDEX IDXTClients1
ON rcb_tclients (ID);

CREATE INDEX IDXTClients2
ON rcb_tclients (KOD);

CREATE INDEX IDXTClients3
ON rcb_tclients (FIRM);

CREATE INDEX IDXTClients4
ON rcb_tclients (DANNO);

#==============================================================================
#PARCEL NUMBERS
select count(*) as clients from rcbill.rcb_tclients;

drop table if exists rcbill.rcb_clientparcels;

create table rcbill.rcb_clientparcels as 
(
	select * from 
    (
			select id as clientid, firm as clientname, kod as clientcode
			, address, moladdress, molregistrationaddress
			, a1_parcel1 as a1_parcel
			, a2_parcel1 as a2_parcel
			, a3_parcel1 as a3_parcel
			, ifnull(NULLIF(a1_parcel1,''),ifnull(NULLIF(a2_parcel1,''),NULLIF(a3_parcel1,''))) as clientparcel        
			from 
			(
				select *
				, trim(replace(replace(replace(regex_replace('[^a-zA-Z0-9/\d\s ]','',a1_parcel),'NO',''),'NUMBER',''),'NUM','')) as a1_parcel1
				-- , regex_replace('[^A-Za-z0-9]+', '', a1_parcel) as a1_parcel1
				, trim(replace(replace(replace(regex_replace('[^a-zA-Z0-9/\d\s ]','',a2_parcel),'NO',''),'NUMBER',''),'NUM','')) as a2_parcel1
				, trim(replace(replace(replace(regex_replace('[^a-zA-Z0-9/\d\s ]','',a3_parcel),'NO',''),'NUMBER',''),'NUM','')) as a3_parcel1

				from
				(
					select id, firm, kod, address, moladdress, MOLRegistrationAddress 
					,locate('PARCEL',upper(address)) as a1_location
					,locate('PARCEL',upper(moladdress)) as a2_location
					,locate('PARCEL',upper(MOLRegistrationAddress)) as a3_location
					, if(locate('PARCEL',upper(address))>0,substring_index(upper(address),'PARCEL',-1),'') as a1_parcel
					, if(locate('PARCEL',upper(moladdress))>0,substring_index(upper(moladdress),'PARCEL',-1),'') as a2_parcel
					, if(locate('PARCEL',upper(MOLRegistrationAddress))>0,substring_index(upper(MOLRegistrationAddress),'PARCEL',-1),'') as a3_parcel
					from rcbill.rcb_tclients 
					where 
					upper(address) like '%PARCEL%'
					or
					upper(moladdress) like '%PARCEL%'
					or
					upper(MOLRegistrationAddress) like '%PARCEL%'
				) a
			) a 
		) a 
        where clientparcel is not null
)
;

CREATE INDEX IDXcparcel1
ON rcbill.rcb_clientparcels (clientcode);

select count(*) as rcb_clientparcels from rcbill.rcb_clientparcels;
-- select * from rcbill.rcb_clientparcels;

#===============================================================================

#Load phone details in different table
DROP TABLE IF EXISTS rcbill.rcb_clientphones;
        
create table rcbill.rcb_clientphones as 
(
SELECT distinct id, firm, kod, trim(SUBSTRING_INDEX(SUBSTRING_INDEX(t.mphone, ',', n.n), ',', -1)) as mphone
  FROM rcbill.rcb_tclients t CROSS JOIN 
(
   SELECT a.N + b.N * 10 + 1 n
     FROM 
    (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
   ,(SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
    ORDER BY n
) n
 WHERE n.n <= 1 + (LENGTH(t.mphone) - LENGTH(REPLACE(t.mphone, ',', '')))
 ORDER BY id
);

CREATE INDEX IDXcphone1
ON rcbill.rcb_clientphones (mphone);

-- select * from rcbill.rcb_clientphones;
-- show index from rcbill.rcb_clientphones;


############################################################################
drop table if exists rcbill.rcb_clientaddress;
create table rcbill.rcb_clientaddress as
(

-- CHANGED ON 13/02/2020 TO CATER FOR DISTRICT AND SUBDISTRICT
/*
select distinct a.id as ClientId, a.firm as ClientName, a.kod as ClientCode, a.MOLADDRESS as ClientAddress, min(ifnull(b.SettlementName,'SILHOUETTE ISLAND')) as ClientLocation, 
min(ifnull(b.areaname,'SILHOUETTE ISLAND')) as ClientArea
from 
rcbill.rcb_tclients a
left join
(
-- 
select distinct settlementname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD')
group by settlementname
-- 

select distinct settlementname, areaname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD') 
-- and settlementname not in ('VICTORIA')
group by settlementname, areaname
order by SETTLEMENTNAME, areaname
) b
on
(a.moladdress like concat('%', b.SETTLEMENTNAME , '%') and a.moladdress like concat('%', b.areaname , '%'))
group by clientid, clientname, clientcode, clientaddress
*/

select distinct a.id as ClientId, a.firm as ClientName, a.kod as ClientCode, a.MOLADDRESS as ClientAddress
, min(ifnull(b.SettlementName,'SILHOUETTE ISLAND')) as ClientLocation
, min(ifnull(b.areaname,'SILHOUETTE ISLAND')) as ClientArea
, min(ifnull(b.districtname,'SILHOUETTE ISLAND')) as ClientSubDistrict
from 
rcbill.rcb_tclients a
left join
(
/*
select distinct settlementname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD')
group by settlementname
*/

/*
select distinct settlementname, areaname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD') 
-- and settlementname not in ('VICTORIA')
group by settlementname, areaname
order by SETTLEMENTNAME, areaname
*/

select distinct settlementname, areaname, districtname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD') 
-- and settlementname not in ('VICTORIA')
group by settlementname, areaname, districtname
order by SETTLEMENTNAME, areaname, districtname


) b
on
(a.moladdress like concat('%', b.SETTLEMENTNAME , '%') and a.moladdress like concat('%', b.areaname , '%') and a.moladdress like concat('%', b.districtname , '%'))
group by clientid, clientname, clientcode, clientaddress

)
;

CREATE INDEX IDXcaddress1
ON rcbill.rcb_clientaddress (ClientCode);

CREATE INDEX IDXcaddress2
ON rcbill.rcb_clientaddress (ClientName);

CREATE INDEX IDXcaddress3
ON rcbill.rcb_clientaddress (ClientLocation);



select count(*) as clientaddress from rcbill.rcb_clientaddress;

-- select * from rcbill.rcb_clientaddress;


###################################################################################
# CONTRACTS TABLE

use rcbill;

drop table if exists rcb_contracts;



CREATE TABLE `rcb_contracts` (

`ID` int(11) DEFAULT NULL ,
`KOD` varchar(255) DEFAULT NULL ,
`DATA` datetime DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`DirstributorID` int(11) DEFAULT NULL ,
`StartDate` datetime DEFAULT NULL ,
`EndDate` datetime DEFAULT NULL ,
`ValidityPeriod` int(11) DEFAULT NULL ,
`Discount` decimal(12,5) DEFAULT NULL ,
`RatingPlanID` int(11) DEFAULT NULL ,
`InvoicingDate` int(11) DEFAULT NULL ,
`CreditPolicyID` int(11) DEFAULT NULL ,
`Credit` decimal(12,5) DEFAULT NULL ,
`Active` int(11) DEFAULT NULL ,
`Activated` int(11) DEFAULT NULL ,
`ActivatedDate` datetime DEFAULT NULL ,
`Invoicing` int(11) DEFAULT NULL ,
`CommChanelID` int(11) DEFAULT NULL ,
`LastActionID` int(11) DEFAULT NULL ,
`PPCard` int(11) DEFAULT NULL ,
`Template` int(11) DEFAULT NULL ,
`ParentID` int(11) DEFAULT NULL ,
`ParentPercent` decimal(12,5) DEFAULT NULL ,
`ParentAmount` decimal(12,5) DEFAULT NULL ,
`LanguageID` int(11) DEFAULT NULL ,
`Comment` varchar(255) DEFAULT NULL ,
`TechUserID` int(11) DEFAULT NULL ,
`Currency` varchar(255) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`TempActivateStartDate` datetime DEFAULT NULL ,
`TempActivateEndDate` datetime DEFAULT NULL ,
`ContractType` varchar(255) DEFAULT NULL ,
`RegionID` int(11) DEFAULT NULL ,
`Address` varchar(255) DEFAULT NULL ,
`TechRegionID` int(11) DEFAULT NULL ,
`KeyAccountManagerID` int(11) DEFAULT NULL ,
`ParentExcludeServiceClasses` varchar(255) DEFAULT NULL ,
`Locked` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;

use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContracts-31032020.csv'
-- REPLACE INTO TABLE `rcbill`.`rcb_contracts` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_contracts` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@KOD ,
@DATA ,
@CLID ,
@DirstributorID ,
@StartDate ,
@EndDate ,
@ValidityPeriod ,
@Discount ,
@RatingPlanID ,
@InvoicingDate ,
@CreditPolicyID ,
@Credit ,
@Active ,
@Activated ,
@ActivatedDate ,
@Invoicing ,
@CommChanelID ,
@LastActionID ,
@PPCard ,
@Template ,
@ParentID ,
@ParentPercent ,
@ParentAmount ,
@LanguageID ,
@Comment ,
@TechUserID ,
@Currency ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@TempActivateStartDate ,
@TempActivateEndDate ,
@ContractType ,
@RegionID ,
@Address ,
@TechRegionID ,
@KeyAccountManagerID ,
@ParentExcludeServiceClasses ,
@Locked 
) 
set 
ID=@ID ,
KOD=upper(trim(@KOD)) ,
-- DATA=str_to_date(@DATA,'%d-%m-%y %k:%i') ,
DATA=@DATA ,
CLID=@CLID ,
DirstributorID=@DirstributorID ,
-- StartDate=str_to_date(@StartDate,'%d-%m-%y %k:%i') ,
-- EndDate=str_to_date(@EndDate,'%d-%m-%y %k:%i') ,

StartDate=@StartDate ,
EndDate=@EndDate ,
ValidityPeriod=@ValidityPeriod ,
Discount=@Discount ,
RatingPlanID=@RatingPlanID ,
InvoicingDate=@InvoicingDate ,
CreditPolicyID=@CreditPolicyID ,
Credit=@Credit ,
Active=@Active ,
Activated=@Activated ,
ActivatedDate=@ActivatedDate ,
Invoicing=@Invoicing ,
CommChanelID=@CommChanelID ,
LastActionID=@LastActionID ,
PPCard=@PPCard ,
Template=@Template ,
ParentID=@ParentID ,
ParentPercent=@ParentPercent ,
ParentAmount=@ParentAmount ,
LanguageID=@LanguageID ,
Comment=@Comment ,
TechUserID=@TechUserID ,
Currency=@Currency ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
TempActivateStartDate=@TempActivateStartDate ,
TempActivateEndDate=@TempActivateEndDate ,
ContractType=upper(trim(@ContractType)) ,
RegionID=@RegionID ,
Address=upper(trim(@Address)) ,
TechRegionID=@TechRegionID ,
KeyAccountManagerID=@KeyAccountManagerID ,
ParentExcludeServiceClasses=@ParentExcludeServiceClasses ,
Locked=@Locked ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE 

;


CREATE INDEX IDXContracts1
ON rcb_contracts (ID);
CREATE INDEX IDXContracts2
ON rcb_contracts (KOD);

CREATE INDEX IDXContractsClient
ON rcb_contracts (CLID);

-- select * from rcb_contracts where KOD like 'I.000011750';

-- select * from rcb_contracts where CLID=723711;
-- select * from rcbill.rcb_contracts where id=1304924;



drop table if exists rcbill.rcb_contractaddress;
create table rcbill.rcb_contractaddress as
(
select distinct a.id as ContractId, a.kod as ContractCode, a.Address as ContractAddress
, rcbill.GetClientCode(clid) as ClientCode, min(ifnull(b.SettlementName,'SILHOUETTE ISLAND')) as ContractLocation, 
min(ifnull(b.areaname,'SILHOUETTE ISLAND')) as ContractArea

from 
rcbill.rcb_contracts a
left join
(
/*
select distinct settlementname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD') 
-- and settlementname not in ('VICTORIA')
group by settlementname
order by SETTLEMENTNAME
*/
select distinct settlementname, areaname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD') 
-- and settlementname not in ('VICTORIA')
group by settlementname, areaname
order by SETTLEMENTNAME, areaname
) b
on
a.Address like concat('%', b.SETTLEMENTNAME , '%') and a.Address like concat('%', b.areaname , '%')
group by ContractId, ContractCode, ContractAddress, 4
)
;

CREATE INDEX IDXconaddress1
ON rcbill.rcb_contractaddress (ContractCode);

CREATE INDEX IDXconaddress3
ON rcbill.rcb_contractaddress (ContractLocation);


select count(*) as contracts from rcbill.rcb_contracts;

select count(*) as contractaddress from rcbill.rcb_contractaddress;


#######################################################

# CONTRACT DISCOUNTS

use rcbill;

drop table if exists rcb_contractdiscounts;



CREATE TABLE `rcb_contractdiscounts` (

`ID` int(11) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`DISCTYPE` int(11) DEFAULT NULL ,
`TYPEID` int(11) DEFAULT NULL ,
`TYPEID1` int(11) DEFAULT NULL ,
`TYPEID2` int(11) DEFAULT NULL ,
`TYPEID3` int(11) DEFAULT NULL ,
`PERCENT` decimal(12,5) DEFAULT NULL ,
`AMOUNT` decimal(12,5) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`APPROVED` int(11) DEFAULT NULL ,
`APPROVEDBY` int(11) DEFAULT NULL ,
`APPROVEDTS` datetime DEFAULT NULL ,
`APPROVALREASON` varchar(255) DEFAULT NULL ,

`CONTRACTCODE` varchar(255) DEFAULT NULL ,
`CLIENTCODE` varchar(255) DEFAULT NULL ,

`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;



LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractDiscounts-31032020.csv'
-- REPLACE INTO TABLE `rcbill`.`rcb_contractdiscounts` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_contractdiscounts` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@CID ,
@DiscType ,
@TypeID ,
@TypeID1 ,
@TypeID2 ,
@TypeID3 ,
@Percent ,
@Amount ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@Approved ,
@ApprovedBy ,
@ApprovedTS ,
@ApprovalReason 
) 
set 
ID=@ID ,
CID=@CID ,
DISCTYPE=@DiscType ,
TYPEID=@TypeID ,
TYPEID1=@TypeID1 ,
TYPEID2=@TypeID2 ,
TYPEID3=@TypeID3 ,
PERCENT=@Percent ,
AMOUNT=@Amount ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,
APPROVED=@Approved ,
APPROVEDBY=@ApprovedBy ,
APPROVEDTS=@ApprovedTS ,
APPROVALREASON=@ApprovalReason ,

INSERTEDON=now(),
REPORTDATE=@REPORTDATE 

;


-- CREATE INDEX IDXcd1
-- ON rcb_contractdiscounts (CID);

-- select * from rcbill.rcb_contractdiscounts;
-- select distinct typeid from rcbill.rcb_contractdiscounts order by typeid;

-- select cid, typeid,percent,amount,upddate,approved,approvalreason from rcbill.rcb_contractdiscounts;

## CREATE CLIENT CONTRACT TABLE
drop table if exists rcbill.clientcontractdiscounts;
create table rcbill.clientcontractdiscounts as
(
SELECT a.id as clientid, a.kod as clientcode, b.id as contractid, b.kod as contractcode
, c.cid as d_contractid, c.typeid as serviceid, d.Name as servicename, c.percent, c.amount, c.upddate, c.approved, c.approvalreason
, now() as InsertedOn
FROM
rcbill.rcb_tclients a 
inner join 
rcbill.rcb_contracts b 
on 
a.id=b.clid

left join
rcbill.rcb_contractdiscounts c 
on 
b.id=c.CID

inner join rcbill.rcb_services d 
on c.TYPEID=d.id
)
;
CREATE INDEX IDXCCD1
ON rcbill.clientcontractdiscounts (clientcode, contractcode);


## CREATE LAST DISCOUNT ENTRY TABLE
drop table if exists rcbill.clientcontractlastdiscount;
create table rcbill.clientcontractlastdiscount as 
(
	select max(upddate) as b_upddate, clientcode as b_clientcode, contractcode as b_contractcode
    , now() as InsertedOn
	from rcbill.clientcontractdiscounts
 	group by clientcode, contractcode
	-- order by clientcode, contractcode
	HAVING MAX(upddate) is not null
)
;
CREATE INDEX IDXCCLD1
ON rcbill.clientcontractlastdiscount (b_clientcode, b_contractcode);

select count(*) as contractdiscounts from rcbill.rcb_contractdiscounts;
select count(*) as clientcontractdiscounts from rcbill.clientcontractdiscounts;
select count(*) as clientcontractlastdiscount from rcbill.clientcontractlastdiscount;

-- select * from rcbill.clientcontractdiscounts where clientid=723711 order by clientcode, contractcode, upddate;
-- select * from rcbill.clientcontractlastdiscount;

######################################################################

# DEVICES

use rcbill;

drop table if exists rcb_devices;

/*
ID,ContractID,SERVICEID,CSID,DevTypeID,
PhoneNo,UserName,Password,Address,
IP,NATIP,DeviceName,MAC,SerNo,GKID,
ProtNo,CreditLimit,ID_OLD,UpdDate,USERID,ActivatedDate,
NoTrigger,AddressID,CustomConfig,OutVLAN
*/
CREATE TABLE `rcb_devices` (
`ID` int(11) DEFAULT NULL ,
`ContractID` int(11) DEFAULT NULL ,
`SERVICEID` int(11) DEFAULT NULL ,
`CSID` int(11) DEFAULT NULL ,
`DevTypeID` int(11) DEFAULT NULL ,
`PhoneNo` varchar(255) DEFAULT NULL ,
`UserName` varchar(255) DEFAULT NULL ,
`Password` varchar(255) DEFAULT NULL ,
`Address` varchar(255) DEFAULT NULL ,
`IP` varchar(255) DEFAULT NULL ,
`NATIP` varchar(255) DEFAULT NULL ,
`DeviceName` varchar(255) DEFAULT NULL ,
`MAC` varchar(255) DEFAULT NULL ,
`SerNo` varchar(255) DEFAULT NULL ,
`GKID` int(11) DEFAULT NULL ,
`ProtNo` varchar(255) DEFAULT NULL ,
`CreditLimit` decimal(12,5) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`ActivatedDate` datetime DEFAULT NULL ,
`NoTrigger` smallint(1) DEFAULT NULL ,
`AddressID` int(11) DEFAULT NULL ,
`CustomConfig` varchar(700) DEFAULT NULL ,
`OutVLAN` varchar(255) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	

) ENGINE=InnoDB CHARSET UTF8;


use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevices-31032020.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_devices` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_devices` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@ContractID ,
@SERVICEID ,
@CSID ,
@DevTypeID ,
@PhoneNo ,
@UserName ,
@Password ,
@Address ,
@IP ,
@NATIP ,
@DeviceName ,
@MAC ,
@SerNo ,
@GKID ,
@ProtNo ,
@CreditLimit ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@ActivatedDate ,
@NoTrigger ,
@AddressID ,
@CustomConfig ,
@OutVLAN 
) 
set 

ID=@ID ,
ContractID=@ContractID ,
SERVICEID=@SERVICEID ,
CSID=@CSID ,
DevTypeID=@DevTypeID ,
PhoneNo=@PhoneNo ,
UserName=@UserName ,
Password=@Password ,
Address=upper(trim(@Address)) ,
IP=@IP ,
NATIP=@NATIP ,
DeviceName=@DeviceName ,
MAC=@MAC ,
SerNo=@SerNo ,
GKID=@GKID ,
ProtNo=@ProtNo ,
CreditLimit=@CreditLimit ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
ActivatedDate=@ActivatedDate ,
NoTrigger=@NoTrigger ,
AddressID=@AddressID ,
CustomConfig=@CustomConfig ,
OutVLAN=@OutVLAN ,

INSERTEDON=now(),
REPORTDATE=@REPORTDATE 


;

CREATE INDEX IDXDevices1
ON rcb_devices (ID);

CREATE INDEX IDXDevices2
ON rcb_devices (ContractID);

CREATE INDEX IDXDevices3
ON rcb_devices (SERVICEID);

CREATE INDEX IDXDevices4
ON rcb_devices (CSID);

CREATE INDEX IDXDevices5
ON rcb_devices (MAC);

CREATE INDEX IDXDevices6
ON rcb_devices (PhoneNo);

-- select * from rcb_devices;
-- select * from rcb_devices where mac = '88.f7.c7.20.f7.30' order by upddate;


/*
create table client contract devices
*/

drop table if exists rcbill.clientcontractdevices;
create table rcbill.clientcontractdevices(INDEX idxccd1 (mac), INDEX idxccd2 (contractcode), INDEX idxccd3 (clientcode), INDEX idxccd4 (phoneno), INDEX idxccd5(CSID)) as 
(
/*
select a.id as DeviceId, a.contractid as CONID, a.phoneno, a.mac, a.address, b.id as ContractId,b.kod as ContractCode, b.ContractType
, d.Name as ServiceType
, b.clid, c.id as ClientId, c.kod as ClientCode, c.firm as ClientName, c.address as ClientAddress
from 
rcbill.rcb_devices a 
inner join 
rcbill.rcb_contracts b 
on a.contractid=b.id

inner join 
rcbill.rcb_tclients c

on b.clid=c.id

inner join 
rcbill.rcb_services d
on a.ServiceId=d.Id
*/

/*UPDATED 2/5/2018*/

/*
select a.id as DeviceId, a.contractid as CONID, a.phoneno, a.mac, a.address, b.id as ContractId,b.kod as ContractCode, b.ContractType
,d.ID as ServiceId, d.Name as ServiceType
, b.clid, c.id as ClientId, c.kod as ClientCode, c.firm as ClientName, c.address as ClientAddress
from
rcbill.rcb_tclients c
inner join 
rcbill.rcb_contracts b 
on b.clid=c.id

left join
rcbill.rcb_devices a 
on a.contractid=b.id

left join 
rcbill.rcb_services d
on a.ServiceId=d.Id
*/


/*UPDATED 3/5/2018*/

/*UPDATED 26/7/2018 change inner join to left join*/
select 

a.id as DeviceId, a.contractid as CONID, a.phoneno, a.mac, a.address, a.NATIP
, a.UserName
, b.id as ContractId,b.kod as ContractCode, b.ContractType
, cs.ID as CSID
 , d.ID as ServiceId, d.Name as ServiceType
, b.clid
, c.id as ClientId, c.kod as ClientCode, c.firm as ClientName, c.address as ClientAddress
from
rcbill.rcb_tclients c
-- inner join 
left join 
rcbill.rcb_contracts b 
on c.id=b.clid
left join 
rcbill.rcb_contractservices cs
on b.id=cs.cid

left join
rcbill.rcb_devices a 
-- on a.contractid=b.id
on cs.id=a.CSID

left join 
rcbill.rcb_services d
on cs.ServiceId=d.Id

/*
a.id as DeviceId, a.contractid as CONID, a.phoneno, a.mac, a.address, a.NATIP
, a.UserName
, b.id as ContractId,b.kod as ContractCode, b.ContractType
, cs.ID as CSID
 , d.ID as ServiceId, d.Name as ServiceType
, b.clid
, c.id as ClientId, c.kod as ClientCode, c.firm as ClientName, c.address as ClientAddress
from
rcbill.rcb_tclients c
-- inner join 
left join 
rcbill.rcb_contracts b 
on b.clid=c.id
left join 
rcbill.rcb_contractservices cs
on b.id=cs.cid

left join
rcbill.rcb_devices a 
-- on a.contractid=b.id
on cs.id=a.CSID

left join 
rcbill.rcb_services d
on cs.ServiceId=d.Id
*/
)
;

select count(*) as devices from rcbill.rcb_devices;
select count(*) as clientcontractdevices from rcbill.clientcontractdevices;
-- select * from rcbill.clientcontractdevices where clientcode='I.000009236' limit 100

-- use rcbill_my;


drop table if exists rcbill_my.rep_clientcontractdevices;

create table rcbill_my.rep_clientcontractdevices(INDEX idxrccd1 (MAC), INDEX idxrccd2 (UID), INDEX idxrccd3 (CLIENT_CODE), INDEX idxrccd4 (CONTRACT_CODE), INDEX idxrccd5 (FSAN)) as 
(

	select 
	clientid as CLIENT_ID,
	clientcode as CLIENT_CODE,
	trim(upper(clientname)) as CLIENT_NAME,
	trim(upper(ClientAddress)) as CLIENT_ADDRESS,
	ContractId as CONTRACT_ID,
	ContractCode as CONTRACT_CODE,
	ContractType as CONTRACT_TYPE,
	ServiceType as SERVICE_TYPE,
	NATIP as FSAN,
	mac as MAC,
	phoneno as UID,
    username as username
	from rcbill.clientcontractdevices where deviceid is not null
	order by ClientId
    
);

select count(*) as rep_clientcontractdevices from rcbill_my.rep_clientcontractdevices;

-- select * from rcbill_my.rep_clientcontractdevices where client_code='I.000003635';
-- select * from rcbill.rcb_contractservices;
##############################################################


#TICKETS

use rcbill;

drop table if exists rcb_tickets;


CREATE TABLE `rcb_tickets` (
`ID` int(11) DEFAULT NULL ,
`OPENDATE` datetime DEFAULT NULL ,
`OPENUSERID` int(11) DEFAULT NULL ,
`OPENREASONID` int(11) DEFAULT NULL ,
`TECHDEPTID` int(11) DEFAULT NULL ,
`TECHREGIONID` int(11) DEFAULT NULL ,
`TECHGROUPID` int(11) DEFAULT NULL ,
`VISITDATE` datetime DEFAULT NULL ,
`STAGETECHREGIONID` int(11) DEFAULT NULL ,
`EXECUTEDDATE` datetime DEFAULT NULL ,
`CLOSEDATE` datetime DEFAULT NULL ,
`CLOSEUSERID` int(11) DEFAULT NULL ,
`CLOSEREASONID` int(11) DEFAULT NULL ,
`CLOSETECHDEPTID` int(11) DEFAULT NULL ,
`CLOSETECHREGIONID` int(11) DEFAULT NULL ,
`CLOSETECHGROUPID` int(11) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`DEVID` int(11) DEFAULT NULL ,
`SEVERITYID` int(11) DEFAULT NULL ,
`SERVICEID` int(11) DEFAULT NULL ,
`TYPEID` int(11) DEFAULT NULL ,
`TYPE` varchar(255) DEFAULT NULL ,
`STATE` varchar(255) DEFAULT NULL ,
`VISITCOUNT` int(11) DEFAULT NULL ,
`WORKTIME` decimal(12,5) DEFAULT NULL ,
`SUBJECT` varchar(255) DEFAULT NULL ,
`DEVICESTATE` varchar(255) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`NAS` varchar(255) DEFAULT NULL ,
`PARENTID` int(11) DEFAULT NULL ,
`INTERFACE` varchar(255) DEFAULT NULL ,
`TESTDATE` datetime DEFAULT NULL ,
`TESTSTATE` varchar(255) DEFAULT NULL ,
`ACTIVITYID` int(11) DEFAULT NULL ,
`GLOBALTICKET` int(11) DEFAULT NULL ,

`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;



LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTickets-31032020.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_tickets` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_tickets` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@OpenDate ,
@OpenUserID ,
@OpenReasonID ,
@TechDeptID ,
@TechRegionID ,
@TechGroupID ,
@VisitDate ,
@StageTechRegionID ,
@ExecutedDate ,
@CloseDate ,
@CloseUserID ,
@CloseReasonID ,
@CloseTechDeptID ,
@CloseTechRegionID ,
@CloseTechGroupID ,
@CLID ,
@CID ,
@DEVID ,
@SeverityID ,
@ServiceID ,
@TypeID ,
@Type ,
@State ,
@VisitCount ,
@WorkTime ,
@Subject ,
@DeviceState ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@NAS ,
@ParentID ,
@Interface ,
@TestDate ,
@TestState ,
@ActivityID ,
@GlobalTicket 

) 
set 
ID=@ID ,
OPENDATE=@OpenDate ,
OPENUSERID=@OpenUserID ,
OPENREASONID=@OpenReasonID ,
TECHDEPTID=@TechDeptID ,
TECHREGIONID=@TechRegionID ,
TECHGROUPID=@TechGroupID ,
VISITDATE=@VisitDate ,
STAGETECHREGIONID=@StageTechRegionID ,
EXECUTEDDATE=@ExecutedDate ,
CLOSEDATE=@CloseDate ,
CLOSEUSERID=@CloseUserID ,
CLOSEREASONID=@CloseReasonID ,
CLOSETECHDEPTID=@CloseTechDeptID ,
CLOSETECHREGIONID=@CloseTechRegionID ,
CLOSETECHGROUPID=@CloseTechGroupID ,
CLID=@CLID ,
CID=@CID ,
DEVID=@DEVID ,
SEVERITYID=@SeverityID ,
SERVICEID=@ServiceID ,
TYPEID=@TypeID ,
TYPE=@Type ,
STATE=@State ,
VISITCOUNT=@VisitCount ,
WORKTIME=@WorkTime ,
SUBJECT=@Subject ,
DEVICESTATE=@DeviceState ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,
NAS=@NAS ,
PARENTID=@ParentID ,
INTERFACE=@Interface ,
TESTDATE=@TestDate ,
TESTSTATE=@TestState ,
ACTIVITYID=@ActivityID ,
GLOBALTICKET=@GlobalTicket ,

INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;



CREATE INDEX IDXtick1
ON rcb_tickets (CLID,CID);

CREATE INDEX IDXtick2
ON rcb_tickets (CLID);

CREATE INDEX IDXtick3
ON rcb_tickets (CID);

CREATE INDEX IDXtick4
ON rcb_tickets (ID);

/*
CREATE INDEX IDXtick5
ON rcb_tickets (CID);
*/

select count(*) as tickets from rcb_tickets;


##############################################

##############################################
#TICKET TECH USERS

use rcbill;

drop table if exists rcb_tickettechusers;



CREATE TABLE `rcb_tickettechusers` (
  `ID` int(11) DEFAULT NULL,
  `KOD` varchar(255) DEFAULT NULL ,
  `NAME` varchar(255) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `PHONE` varchar(255) DEFAULT NULL,
  `RCBUSERID` varchar(255) DEFAULT NULL,
  `TECHGROUPID` varchar(255) DEFAULT NULL,
  `TECHREGIONID` int(11) DEFAULT NULL,
  `NOTIFY` varchar(255) DEFAULT NULL,
  `USERID` int(11) DEFAULT NULL,
  `ID_OLD` int(11) DEFAULT NULL,
  `UPDDATE` datetime DEFAULT NULL,
  `SUPERUSER` int(11) DEFAULT NULL,
  `INSERTEDON` datetime DEFAULT NULL	
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;


show index from rcbill.rcb_tickettechusers;

create index IDXttu1 on rcbill.rcb_tickettechusers (RCBUSERID);


LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketTechUsers-31032020.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_tickettechusers` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
(
@ID,
@KOD,
@NAME,
@EMAIL,
@PHONE,
@RCBUSERID,
@TECHGROUPID,
@TECHREGIONID,
@NOTIFY,
@USERID,
@ID_OLD,
@UPDDATE,
@SUPERUSER

) 
set 
ID=@ID,
KOD=@KOD,
NAME=@NAME,
EMAIL=@EMAIL,
PHONE=@PHONE,
RCBUSERID=@RCBUSERID,
TECHGROUPID=@TECHGROUPID,
TECHREGIONID=@TECHREGIONID,
NOTIFY=@NOTIFY,
USERID=@USERID,
ID_OLD=@ID_OLD,
UPDDATE=@UPDDATE,
SUPERUSER=@SUPERUSER,


INSERTEDON=now()

;


select count(*) as tickettechusers from rcb_tickettechusers;


##############################################################


#TICKET ASSIGNMENTS

use rcbill;

drop table if exists rcb_ticketassignments;


CREATE TABLE `rcb_ticketassignments` (
`ID` int(11) DEFAULT NULL ,
`TICKETID` int(11) DEFAULT NULL ,
`TECHLEVELID` int(11) DEFAULT NULL ,
`TECHDEPTID` int(11) DEFAULT NULL ,
`TECHREGIONID` int(11) DEFAULT NULL ,
`TECHGROUPID` int(11) DEFAULT NULL ,
`TECHUSERID` int(11) DEFAULT NULL ,
`REQUIRED` int(11) DEFAULT NULL ,
`PARTICIPATION` int(11) DEFAULT NULL ,
`STATE` varchar(255) DEFAULT NULL ,
`COMMENT` varchar(255) DEFAULT NULL ,
`COMPLETE` int(11) DEFAULT NULL ,
`OPENDATE` datetime DEFAULT NULL ,
`CLOSEDATE` datetime DEFAULT NULL ,
`CLOSEREASONID` int(11) DEFAULT NULL ,
`WORKTIME` decimal(12,5) DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`SEVERITYID` int(11) DEFAULT NULL ,
`DURATION_HOUR` decimal(12,5) DEFAULT NULL ,


`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;


CREATE INDEX IDXtxtass1
ON rcb_ticketassignments (TICKETID);


LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketAssignments-31032020.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_tickets` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_ticketassignments` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@TicketID ,
@TechLevelID ,
@TechDeptID ,
@TechRegionID ,
@TechGroupID ,
@TechUserID ,
@Required ,
@Participation ,
@State ,
@Comment ,
@Complete ,
@OpenDate ,
@CloseDate ,
@CloseReasonID ,
@WorkTime ,
@UserID ,
@ID_OLD ,
@UpdDate ,
@SeverityID ,
@Duration_Hour 

) 
set 
ID=@ID ,
TICKETID=@TicketID ,
TECHLEVELID=@TechLevelID ,
TECHDEPTID=@TechDeptID ,
TECHREGIONID=@TechRegionID ,
TECHGROUPID=@TechGroupID ,
TECHUSERID=@TechUserID ,
REQUIRED=@Required ,
PARTICIPATION=@Participation ,
STATE=@State ,
COMMENT=@Comment ,
COMPLETE=@Complete ,
OPENDATE=@OpenDate ,
CLOSEDATE=@CloseDate ,
CLOSEREASONID=@CloseReasonID ,
WORKTIME=@WorkTime ,
USERID=@UserID ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
SEVERITYID=@SeverityID ,
DURATION_HOUR=@Duration_Hour ,


INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;



select count(*) as ticketassignments from rcbill.rcb_ticketassignments;



##############################################

# TICKET COMMENTS

use rcbill;

drop table if exists rcb_ticketcomments;


CREATE TABLE `rcb_ticketcomments` (
`ID` int(11) DEFAULT NULL ,
`TICKETID` int(11) DEFAULT NULL ,
`COMMENT` text DEFAULT NULL ,
`TECHUSERID` int(11) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,

`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,


`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;



LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketComments-31032020.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_ticketcomments` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_ticketcomments` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES
IGNORE 2 LINES 
(
@ID ,
@TicketID ,
@Comment ,
@TechUserID ,
@ID_OLD ,
@UpdDate ,
@USERID 


) 
set 
ID=@ID ,
TICKETID=@TicketID ,
COMMENT=@Comment ,
TECHUSERID=@TechUserID ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,


INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;



CREATE INDEX IDXtc1
ON rcb_ticketcomments (ID,TICKETID);

CREATE INDEX IDXtc2
ON rcb_ticketcomments (TICKETID);

CREATE INDEX IDXtc3
ON rcb_ticketcomments (ID);

CREATE INDEX IDXtc4
ON rcb_ticketcomments (USERID);

/*
CREATE INDEX IDXtick5
ON rcb_ticketcomments (CID);
*/

select count(*) as ticketcomments from rcb_ticketcomments;

####################################################################

# COMMENTS

use rcbill;

drop table if exists rcb_comments;


CREATE TABLE `rcb_comments` (
`ID` int(11) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`CLIENTCODE` varchar(255) DEFAULT NULL ,

`CID` int(11) DEFAULT NULL ,
`CONTRACTCODE` varchar(255) DEFAULT NULL ,

`COMMENTDATE` datetime DEFAULT NULL ,
`COMMENT` text DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,



`INSERTEDON` datetime DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;



LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllComments-31032020.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_comments` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_comments` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@CLID ,
@CID ,
@CommentDate ,
@Comment ,
@ID_OLD ,
@UpdDate ,
@USERID 


) 
SET
ID=@ID ,
CLID=@CLID ,
CLIENTCODE = GetClientCode(@CLID),
CID=@CID ,
CONTRACTCODE = GetContractCode(@CID),


COMMENTDATE=@CommentDate ,
COMMENT=@Comment ,
UPDDATE=@UpdDate ,
USERID=@USERID ,

INSERTEDON=now()

;



CREATE INDEX IDXccc1
ON rcb_comments (ClientCode, ContractCode);


/*
CREATE INDEX IDXtick5
ON rcb_ticketcomments (CID);

drop index IDXtc4 on rcb_comments;

*/
-- show index from rcb_comments;

select count(*) as comments from rcb_comments;


###########################################################

# DEVICES OLD

use rcbill;

drop table if exists rcb_devicesold;



CREATE TABLE `rcb_devicesold` (
`ID` int(11) DEFAULT NULL ,
`ContractID` int(11) DEFAULT NULL ,
`SERVICEID` int(11) DEFAULT NULL ,
`CSID` int(11) DEFAULT NULL ,
`DevTypeID` int(11) DEFAULT NULL ,
`PhoneNo` varchar(255) DEFAULT NULL ,
`UserName` varchar(255) DEFAULT NULL ,
`Password` varchar(255) DEFAULT NULL ,
`Address` varchar(255) DEFAULT NULL ,
`IP` varchar(255) DEFAULT NULL ,
`NATIP` varchar(255) DEFAULT NULL ,
`DeviceName` varchar(255) DEFAULT NULL ,
`MAC` varchar(255) DEFAULT NULL ,
`SerNo` varchar(255) DEFAULT NULL ,
`GKID` int(11) DEFAULT NULL ,
`ProtNo` varchar(255) DEFAULT NULL ,
`CreditLimit` decimal(12,5) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`ActivatedDate` datetime DEFAULT NULL ,
`NoTrigger` smallint(1) DEFAULT NULL ,
`AddressID` int(11) DEFAULT NULL ,
`CustomConfig` varchar(700) DEFAULT NULL ,
`OutVLAN` varchar(255) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	

) ENGINE=InnoDB CHARSET UTF8;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevicesOld-31032020.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_devicesold` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_devicesold` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@ContractID ,
@SERVICEID ,
@CSID ,
@DevTypeID ,
@PhoneNo ,
@UserName ,
@Password ,
@Address ,
@IP ,
@NATIP ,
@DeviceName ,
@MAC ,
@SerNo ,
@GKID ,
@ProtNo ,
@CreditLimit ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@ActivatedDate ,
@NoTrigger ,
@AddressID ,
@CustomConfig ,
@OutVLAN 
) 
set 

ID=@ID ,
ContractID=@ContractID ,
SERVICEID=@SERVICEID ,
CSID=@CSID ,
DevTypeID=@DevTypeID ,
PhoneNo=@PhoneNo ,
UserName=@UserName ,
Password=@Password ,
Address=upper(trim(@Address)) ,
IP=@IP ,
NATIP=@NATIP ,
DeviceName=@DeviceName ,
MAC=@MAC ,
SerNo=@SerNo ,
GKID=@GKID ,
ProtNo=@ProtNo ,
CreditLimit=@CreditLimit ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
ActivatedDate=@ActivatedDate ,
NoTrigger=@NoTrigger ,
AddressID=@AddressID ,
CustomConfig=@CustomConfig ,
OutVLAN=@OutVLAN ,

INSERTEDON=now(),
REPORTDATE=@REPORTDATE 


;

CREATE INDEX IDXDevicesOld1
ON rcb_devicesold (ID);

CREATE INDEX IDXDevicesOld2
ON rcb_devicesold (ContractID);

CREATE INDEX IDXDevicesOld3
ON rcb_devicesold (SERVICEID);

CREATE INDEX IDXDevicesOld4
ON rcb_devicesold (CSID);

CREATE INDEX IDXDevicesOld5
ON rcb_devicesold (MAC);

select count(*) as devicesold from rcb_devicesold;


#################################################################################

# CONTRACT SERVICES

use rcbill;

drop table if exists rcb_contractservices;



CREATE TABLE `rcb_contractservices` (
`ID` int(11) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`ServiceID` int(11) DEFAULT NULL ,
`ServiceRateID` int(11) DEFAULT NULL ,
`StartDate` datetime DEFAULT NULL ,
`EndDate` datetime DEFAULT NULL ,
`Number` int(11) DEFAULT NULL ,
`csCredit` decimal(12,5) DEFAULT NULL ,
`manualPrice` decimal(12,5) DEFAULT NULL ,
`Active` int(11) DEFAULT NULL ,
`ActivatedDate` datetime DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`NoTrigger` int(4) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	

) ENGINE=InnoDB CHARSET UTF8;


LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractServices-31032020.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_contractservices` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_contractservices` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@CID ,
@ServiceID ,
@ServiceRateID ,
@StartDate ,
@EndDate ,
@Number ,
@csCredit ,
@manualPrice ,
@Active ,
@ActivatedDate ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@NoTrigger 
) 
set 
ID=@ID ,
CID=@CID ,
ServiceID=@ServiceID ,
ServiceRateID=@ServiceRateID ,
StartDate=@StartDate ,
EndDate=@EndDate ,
Number=@Number ,
csCredit=@csCredit ,
manualPrice=@manualPrice ,
Active=@Active ,
ActivatedDate=@ActivatedDate ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
NoTrigger=@NoTrigger ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;


CREATE INDEX IDXContractServices
ON rcb_contractservices (CID);

CREATE INDEX IDXContractServices2
ON rcb_contractservices (ServiceRateID);

CREATE INDEX IDXContractServices3
ON rcb_contractservices (ServiceID);


select count(*) as contractservices from rcb_contractservices;
-- select * from rcbill.rcb_contractservices;

########################################################

# INVOICE CONTENTS

use rcbill;

drop table if exists rcb_invoicescontents;


CREATE TABLE `rcb_invoicescontents` (
`ID` int(11) DEFAULT NULL ,
`INVOICENO` bigint(11) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`CSID` int(11) DEFAULT NULL ,
`RID` int(11) DEFAULT NULL ,
`RSID` int(11) DEFAULT NULL ,
`ServiceID` int(11) DEFAULT NULL ,
`DID` int(11) DEFAULT NULL ,
`RPDiscountID` int(11) DEFAULT NULL ,
`Discount` decimal(50,5) DEFAULT NULL ,
`NUMBER` int(11) DEFAULT NULL ,
`SCOST` decimal(50,5) DEFAULT NULL ,
`COST` decimal(50,5) DEFAULT NULL ,
`sumCost` decimal(50,5) DEFAULT NULL ,
`FROMDATE` datetime DEFAULT NULL ,
`TODATE` datetime DEFAULT NULL ,
`ValidTill` datetime DEFAULT NULL ,
`ROW` int(11) DEFAULT NULL ,
`TEXT` varchar(255) DEFAULT NULL ,
`ParentID` int(11) DEFAULT NULL ,
`InvNo` bigint(11) DEFAULT NULL ,
`CDRCOUNT` int(11) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`InvoiceID` int(11) DEFAULT NULL ,
`VAT` decimal(50,5) DEFAULT NULL ,
`CostVAT` decimal(50,5) DEFAULT NULL ,
`CostTotal` decimal(50,5) DEFAULT NULL ,
`DiscardPeriod` int(11) DEFAULT NULL ,
`ChildCID` int(11) DEFAULT NULL ,
`DiscountCost` decimal(50,5) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;


LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesContents-31032020.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_invoicescontents` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_invoicescontents` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@INVOICENO ,
@CLID ,
@CID ,
@CSID ,
@RID ,
@RSID ,
@ServiceID ,
@DID ,
@RPDiscountID ,
@Discount ,
@NUMBER ,
@SCOST ,
@COST ,
@sumCost ,
@FROMDATE ,
@TODATE ,
@ValidTill ,
@ROW ,
@TEXT ,
@ParentID ,
@InvNo ,
@CDRCOUNT ,
@ID_OLD ,
@UPDDATE ,
@USERID ,
@InvoiceID ,
@VAT ,
@CostVAT ,
@CostTotal ,
@DiscardPeriod ,
@ChildCID ,
@DiscountCost 
) 
set 
ID=@ID ,
INVOICENO=@INVOICENO ,
CLID=@CLID ,
CID=@CID ,
CSID=@CSID ,
RID=@RID ,
RSID=@RSID ,
ServiceID=@ServiceID ,
DID=@DID ,
RPDiscountID=@RPDiscountID ,
Discount=@Discount ,
NUMBER=@NUMBER ,
SCOST=@SCOST ,
COST=@COST ,
sumCost=@sumCost ,
FROMDATE=@FROMDATE ,
TODATE=@TODATE ,
ValidTill=@ValidTill ,
ROW=upper(trim(@ROW)) ,
TEXT=upper(trim(@TEXT)) ,
ParentID=@ParentID ,
InvNo=@InvNo ,
CDRCOUNT=@CDRCOUNT ,
ID_OLD=@ID_OLD ,
UPDDATE=@UPDDATE ,
USERID=@USERID ,
InvoiceID=@InvoiceID ,
VAT=@VAT ,
CostVAT=@CostVAT ,
CostTotal=@CostTotal ,
DiscardPeriod=@DiscardPeriod ,
ChildCID=@ChildCID ,
DiscountCost=@DiscountCost ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;



-- drop index IDXinvoicescontents on rcb_invoicescontents;
CREATE INDEX IDXinvoicescontents1
ON rcb_invoicescontents (ID);

CREATE INDEX IDXinvoicescontents2
ON rcb_invoicescontents (INVOICENO);


CREATE INDEX IDXinvoicescontents3
ON rcb_invoicescontents (CLID);


CREATE INDEX IDXinvoicescontents4
ON rcb_invoicescontents (CID);

-- select * from rcb_invoicescontents where clid in (717788);
 select count(*) as invoicescontents from rcb_invoicescontents;

############################################################


# INVOICES HEADERS

use rcbill;

drop table if exists rcb_invoicesheader;


CREATE TABLE `rcb_invoicesheader` (
`ID` int(11) DEFAULT NULL ,
`TYPE` smallint(4) DEFAULT NULL ,
`HARD` int(11) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`INVOICENO` bigint(50) DEFAULT NULL ,

`ProformaNO` bigint(50) DEFAULT NULL ,
`SRCNO` bigint(50) DEFAULT NULL ,
`DKINO` bigint(50) DEFAULT NULL ,
`DATA` datetime DEFAULT NULL ,
`TFIRM` varchar(255) DEFAULT NULL ,
`TADDRESS` varchar(255) DEFAULT NULL ,
`TMOL` varchar(255) DEFAULT NULL ,
`TMOLADDRESS` varchar(255) DEFAULT NULL ,

`TDANNO` varchar(255) DEFAULT NULL ,
`TBULSTAT` varchar(255) DEFAULT NULL ,
`TCITY` varchar(255) DEFAULT NULL ,
`TZIP` varchar(255) DEFAULT NULL ,
`TRECIPIENT` varchar(255) DEFAULT NULL ,
`FCLID` int(11) DEFAULT NULL ,
`FFIRM` varchar(255) DEFAULT NULL ,
`FADDRESS` varchar(255) DEFAULT NULL ,
`FMOL` varchar(255) DEFAULT NULL ,
`FDANNO` varchar(255) DEFAULT NULL ,
`FBULSTAT` varchar(255) DEFAULT NULL ,
`FCITY` varchar(255) DEFAULT NULL ,
`FBANK` varchar(255) DEFAULT NULL ,
`FBANKNO` int(11) DEFAULT NULL ,
`FACCOUNT` varchar(255) DEFAULT NULL ,
`FDDSACCOUNT` varchar(255) DEFAULT NULL ,
`PLACE` varchar(255) DEFAULT NULL ,
`REASON` varchar(255) DEFAULT NULL ,
`SUMA` decimal(50,5) DEFAULT NULL ,
`DDS` decimal(50,5) DEFAULT NULL ,
`TOTAL` decimal(50,5) DEFAULT NULL ,
`DEBT` decimal(50,5) DEFAULT NULL ,
`Avance` decimal(50,5) DEFAULT NULL ,
`AvanceUse` decimal(50,5) DEFAULT NULL ,
`VATPercent` decimal(50,5) DEFAULT NULL ,
`CREATOR` varchar(255) DEFAULT NULL ,
`PRNCOUNT` smallint(4) DEFAULT NULL ,
`BEGDATE` datetime DEFAULT NULL ,
`ENDDATE` datetime DEFAULT NULL ,
`SAPExported` int(11) DEFAULT NULL ,
`PaymentID` int(11) DEFAULT NULL ,
`Currency` varchar(255) DEFAULT NULL ,
`OriginalCurrency` varchar(255) DEFAULT NULL ,
`Rate` decimal(12,5) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`DueDate` datetime DEFAULT NULL ,
`InvNo` decimal(50,5) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;


LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesHeader-31032020.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_invoicesheader` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_invoicesheader` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@TYPE ,
@HARD ,
@CLID ,
@CID ,
@INVOICENO ,
@ProformaNO ,
@SRCNO ,
@DKINO ,
@DATA ,
@TFIRM ,
@TADDRESS ,
@TMOL ,
@TMOLADDRESS ,
@TDANNO ,
@TBULSTAT ,
@TCITY ,
@TZIP ,
@TRECIPIENT ,
@FCLID ,
@FFIRM ,
@FADDRESS ,
@FMOL ,
@FDANNO ,
@FBULSTAT ,
@FCITY ,
@FBANK ,
@FBANKNO ,
@FACCOUNT ,
@FDDSACCOUNT ,
@PLACE ,
@REASON ,
@SUMA ,
@DDS ,
@TOTAL ,
@DEBT ,
@Avance ,
@AvanceUse ,
@VATPercent ,
@CREATOR ,
@PRNCOUNT ,
@BEGDATE ,
@ENDDATE ,
@SAPExported ,
@PaymentID ,
@Currency ,
@OriginalCurrency ,
@Rate ,
@ID_OLD ,
@UPDDATE ,
@USERID ,
@DueDate ,
@InvNo 
) 
set 
ID=@ID ,
TYPE=@TYPE ,
HARD=@HARD ,
CLID=@CLID ,
CID=@CID ,
INVOICENO=@INVOICENO ,
ProformaNO=@ProformaNO ,
SRCNO=@SRCNO ,
DKINO=@DKINO ,
DATA=@DATA ,
TFIRM=upper(trim(@TFIRM)) ,
TADDRESS=upper(trim(@TADDRESS)) ,
TMOL=upper(trim(@TMOL)) ,
TMOLADDRESS=upper(trim(@TMOLADDRESS)) ,
TDANNO=upper(trim(@TDANNO)) ,
TBULSTAT=@TBULSTAT ,
TCITY=upper(trim(@TCITY)) ,
TZIP=@TZIP ,
TRECIPIENT=upper(trim(@TRECIPIENT)) ,
FCLID=@FCLID ,
FFIRM=upper(trim(@FFIRM)) ,
FADDRESS=upper(trim(@FADDRESS)) ,
FMOL=upper(trim(@FMOL)) ,
FDANNO=upper(trim(@FDANNO)) ,
FBULSTAT=@FBULSTAT ,
FCITY=upper(trim(@FCITY)) ,
FBANK=@FBANK ,
FBANKNO=@FBANKNO ,
FACCOUNT=@FACCOUNT ,
FDDSACCOUNT=@FDDSACCOUNT ,
PLACE=upper(trim(@PLACE)) ,
REASON=upper(trim(@REASON)) ,
SUMA=@SUMA ,
DDS=@DDS ,
TOTAL=@TOTAL ,
DEBT=@DEBT ,
Avance=@Avance ,
AvanceUse=@AvanceUse ,
VATPercent=@VATPercent ,
CREATOR=@CREATOR ,
PRNCOUNT=@PRNCOUNT ,
BEGDATE=@BEGDATE ,
ENDDATE=@ENDDATE ,
SAPExported=@SAPExported ,
PaymentID=@PaymentID ,
Currency=@Currency ,
OriginalCurrency=@OriginalCurrency ,
Rate=@Rate ,
ID_OLD=@ID_OLD ,
UPDDATE=@UPDDATE ,
USERID=@USERID ,
DueDate=@DueDate ,
InvNo=@InvNo ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;



CREATE INDEX IDXinvoiceheader1
ON rcb_invoicesheader (ID,INVOICENO);

CREATE INDEX IDXinvoiceheader2
ON rcb_invoicesheader (INVOICENO);

CREATE INDEX IDXinvoiceheader3
ON rcb_invoicesheader (ProformaNO);

CREATE INDEX IDXinvoiceheader4
ON rcb_invoicesheader (CLID);

CREATE INDEX IDXinvoiceheader5
ON rcb_invoicesheader (CID);

-- select * from rcb_invoicesheader where clid in (717788) limit 10000;
select count(*) as invoicesheader from rcb_invoicesheader;

#####################################################


# CASA

use rcbill;

drop table if exists rcb_casa;



CREATE TABLE `rcb_casa` (
`ID` int(11) DEFAULT NULL ,
`PAYOBJECTID` int(11) DEFAULT NULL ,
`PAYTYPE` int(11) DEFAULT NULL ,
`CashPointID` int(11) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`toCLID` int(11) DEFAULT NULL ,
`PAYDATE` datetime DEFAULT NULL ,
`MONEY` decimal(12,5) DEFAULT NULL ,
`BankReference` varchar(255) DEFAULT NULL ,
`ZAB` varchar(500) DEFAULT NULL ,
`INVID` int(11) DEFAULT NULL ,
`ENTERDATE` datetime DEFAULT NULL ,
`CONFIRMED` int(11) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`PRN_COUNT` int(11) DEFAULT NULL ,
`ExternalReference` text DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`BegDate` datetime DEFAULT NULL ,
`EndDate` datetime DEFAULT NULL ,
`hard` int(11) DEFAULT NULL ,
`InternalReference` text DEFAULT NULL ,
`RSID` int(11) DEFAULT NULL ,
`DiscountMoney` decimal(12,5) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	

) ENGINE=InnoDB CHARSET UTF8;

#NOTE: PAYTYPE in CASA is the same as negative of ID in rcb_services 

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCASA-31032020.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_casa` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_casa` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@PAYOBJECTID ,
@PAYTYPE ,
@CashPointID ,
@CLID ,
@toCLID ,
@PAYDATE ,
@MONEY ,
@BankReference ,
@ZAB ,
@INVID ,
@ENTERDATE ,
@CONFIRMED ,
@ID_OLD ,
@UPDDATE ,
@USERID ,
@PRN_COUNT ,
@ExternalReference ,
@CID ,
@BegDate ,
@EndDate ,
@hard ,
@InternalReference ,
@RSID ,
@DiscountMoney
) 
set 
ID=@ID ,
PAYOBJECTID=@PAYOBJECTID ,
PAYTYPE=@PAYTYPE ,
CashPointID=@CashPointID ,
CLID=@CLID ,
toCLID=@toCLID ,
PAYDATE=@PAYDATE ,
MONEY=@MONEY ,
BankReference=@BankReference ,
ZAB=upper(trim(@ZAB)) ,
INVID=@INVID ,
ENTERDATE=@ENTERDATE ,
CONFIRMED=@CONFIRMED ,
ID_OLD=@ID_OLD ,
UPDDATE=@UPDDATE ,
USERID=@USERID ,
PRN_COUNT=@PRN_COUNT ,
-- ExternalReference=upper(trim(@ExternalReference)) ,
ExternalReference=null ,
CID=@CID ,
BegDate=@BegDate ,
EndDate=@EndDate ,
hard=@hard ,
InternalReference=@InternalReference ,
RSID=@RSID ,
DiscountMoney=@DiscountMoney ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE 


;

CREATE INDEX IDXCASA1
ON rcb_casa (ID);

CREATE INDEX IDXCASA2
ON rcb_casa (CLID);

CREATE INDEX IDXCASA3
ON rcb_casa (CID);

CREATE INDEX IDXCASA4
ON rcb_casa (INVID);

-- select * from rcbill.rcb_casa where clid=717788;
select count(*) as casa from rcbill.rcb_casa;

###################################################


#PAYMENT COLLECTIONS
drop table if exists rcbill_my.rep_paycol_channel;
create table rcbill_my.rep_paycol_channel as 
(
	select date(PAYDATE) as paydate,day(PAYDATE) as payday, month(PAYDATE) as paymth, year(PAYDATE) as payyear, weeknum, weekday, payobjectname as pay_channel, sum(money) as pay_amount
	from 
	(
		select paydate, week(PAYDATE,1) as weeknum, rcbill_my.GetWeekdayName(weekday(paydate)) as weekday, money
        , (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
		, (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
		, (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
		from rcbill.rcb_casa 
		where
		(hard not in (100, 101, 102) or hard is null)
		-- and date(PAYDATE)>=@startdate and date(PAYDATE)<=@enddate
		-- limit 100
	) a 
	group by 1,2,3,4,5,6,7
    order by 1 desc
)
; 
select count(*) as rep_paycol_channel from rcbill_my.rep_paycol_channel;

drop table if exists rcbill_my.rep_paycol_pos;
create table rcbill_my.rep_paycol_pos as 
(
	select date(PAYDATE) as paydate, day(PAYDATE) as payday, month(PAYDATE) as paymth, year(PAYDATE) as payyear, weeknum, weekday, cashpointname as pay_pos, sum(money) as pay_amount
	from 
	(
		select paydate, week(PAYDATE,1) as weeknum, rcbill_my.GetWeekdayName(weekday(paydate)) as weekday, money
        , (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
		, (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
		, (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
		from rcbill.rcb_casa 
		where
		(hard not in (100, 101, 102) or hard is null)
		-- and date(PAYDATE)>=@startdate and date(PAYDATE)<=@enddate
		-- limit 100
	) a 
	group by 1,2,3,4,5,6,7
    order by 1 desc
)
; 
select count(*) as rep_paycol_pos from rcbill_my.rep_paycol_pos;

###################################################




###################################
# USERS TABLE

use rcbill;

drop table if exists rcb_users;

CREATE TABLE `rcb_users` (
`USERNAME` varchar(255) DEFAULT NULL ,
`ID` int(11) DEFAULT NULL ,
`NAME` varchar(255) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`EMAIL` varchar(255) DEFAULT NULL ,
`PASSWORD` varchar(255) DEFAULT NULL ,
`PHONE` varchar(255) DEFAULT NULL ,
`ADDRESS` varchar(255) DEFAULT NULL ,
`CITY` varchar(255) DEFAULT NULL ,
`ZIP` varchar(255) DEFAULT NULL ,
`EGN` varchar(255) DEFAULT NULL ,
`ACTIVE` int(11) DEFAULT NULL ,
`ACTIVETILL` datetime DEFAULT NULL ,
`ADMIN` int(11) DEFAULT NULL ,
`CASHPOINTID` int(11) DEFAULT NULL ,
`USERGROUPID` int(11) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`SECONDARY` int(11) DEFAULT NULL ,
`TEMPORARYPASSWORD` varchar(255) DEFAULT NULL ,
`REQUIREPASSWORDCHANGE` int(11) DEFAULT NULL ,
`PASSWORDEXPIREDATE` datetime DEFAULT NULL ,
`WRONG_ATTEMPTS` int(11) DEFAULT NULL ,
`IPTV_SAVEDSESSION` varchar(255) DEFAULT NULL ,
`IPTV_MAXSESSIONS` int(11) DEFAULT NULL ,
`TEMPORARYUSERID` int(11) DEFAULT NULL ,
`INCORRECT_COUNT` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;


# FILL IN DATA
-- SET SESSION sql_mode = 'STRICT_ALL_TABLES';
use rcbill;
-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllUsers-31032020.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_users` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@UserName ,
@ID ,
@Name ,
@CLID ,
@EMAIL ,
@Password ,
@Phone ,
@Address ,
@City ,
@ZIP ,
@EGN ,
@Active ,
@ActiveTill ,
@Admin ,
@CashPointID ,
@UserGroupID ,
@ID_OLD ,
@UPDDATE ,
@USERID ,
@Secondary ,
@TemporaryPassword ,
@RequirePasswordChange ,
@PasswordExpireDate ,
@Wrong_Attempts ,
@IPTV_SavedSession ,
@IPTV_MaxSessions ,
@TemporaryUserID ,
@INCORRECT_COUNT
) 
set 
USERNAME=@UserName ,
ID=@ID ,
NAME=@Name ,
CLID=@CLID ,
EMAIL=@EMAIL ,
PASSWORD=@Password ,
PHONE=@Phone ,
ADDRESS=@Address ,
CITY=@City ,
ZIP=@ZIP ,
EGN=@EGN ,
ACTIVE=@Active ,
ACTIVETILL=@ActiveTill ,
ADMIN=@Admin ,
CASHPOINTID=@CashPointID ,
USERGROUPID=@UserGroupID ,
ID_OLD=@ID_OLD ,
UPDDATE=@UPDDATE ,
USERID=@USERID ,
SECONDARY=@Secondary ,
TEMPORARYPASSWORD=@TemporaryPassword ,
REQUIREPASSWORDCHANGE=@RequirePasswordChange ,
PASSWORDEXPIREDATE=@PasswordExpireDate ,
WRONG_ATTEMPTS=@Wrong_Attempts ,
IPTV_SAVEDSESSION=@IPTV_SavedSession ,
IPTV_MAXSESSIONS=@IPTV_MaxSessions ,
TEMPORARYUSERID=@TemporaryUserID ,
INCORRECT_COUNT=@INCORRECT_COUNT ,

INSERTEDON=now(),
REPORTDATE=@REPORTDATE
;

-- select * from rcbill.rcb_tclients where firm like 'rahul%'
select count(*) as users from rcb_users;

-- select * from rcb_users;

CREATE INDEX IDXusers1
ON rcb_users (CLID);


/*
CREATE INDEX IDXusers1
ON rcb_users (ID);

CREATE INDEX IDXusers2
ON rcb_users (KOD);

CREATE INDEX IDXusers3
ON rcb_users (FIRM);

CREATE INDEX IDXusers4
ON rcb_users (DANNO);
*/
#===============================================================================







###################################
# USERACTIONS TABLE

use rcbill;

drop table if exists rcb_useractions;



CREATE TABLE `rcb_useractions` (
`ID` bigint(25) DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`STARTTIME` datetime DEFAULT NULL ,
`NUMBER` int(11) DEFAULT NULL ,
`ENDTIME` datetime DEFAULT NULL ,
`COMMENT` varchar(255) DEFAULT NULL ,
`LABEL` varchar(255) DEFAULT NULL ,
`URL` varchar(255) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`PAYMENTID` int(11) DEFAULT NULL ,
`AMOUNT` decimal(12,5) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	

) ENGINE=InnoDB CHARSET UTF8;



-- SET SESSION sql_mode = '';
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllUserActions2019-31032020.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_useractions` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_useractions` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@UserID ,
@StartTime ,
@Number ,
@EndTime ,
@Comment ,
@Label ,
@URL ,
@CLID ,
@CID ,
@PaymentID ,
@Amount 
) 
set 
ID=@ID ,
USERID=@UserID ,
STARTTIME=@StartTime ,
NUMBER=@Number ,
ENDTIME=@EndTime ,
COMMENT=@Comment ,
LABEL=@Label ,
URL=@URL ,
CLID=@CLID ,
CID=@CID ,
PAYMENTID=@PaymentID ,
AMOUNT=@Amount ,
INSERTEDON=now()

;

CREATE INDEX IDXUA1
ON rcb_useractions (ID);

CREATE INDEX IDXUA2
ON rcb_useractions (USERID);

CREATE INDEX IDXUA3
ON rcb_useractions (CLID);

CREATE INDEX IDXUA4
ON rcb_useractions (CID);

CREATE INDEX IDXUA5
ON rcb_useractions (PAYMENTID);

-- select * from rcbill.rcb_useractions where clid=717788;
select count(*) as useractions from rcbill.rcb_useractions;


#===============================================================================


###################################




###################################
# IPUSAGE TABLE

-- STOPPING IPUSAGE TEMPORARILY because PPPOE_ACCOUNTING_SUMMARY is not available

-- 20 /05 /2018 restarting IPUSAGE TABLE
use rcbill;

drop table if exists rcb_ipusage1;


CREATE TABLE `rcb_ipusage1` (
`USAGEID` int(11) DEFAULT NULL ,
`DEVICEID` int(11) DEFAULT NULL ,
`USAGEDATE` date DEFAULT NULL ,
`TRAFFICTYPE` int(11) DEFAULT NULL ,
`CLIENTIP` bigint(25) DEFAULT NULL ,
`USAGEDIRECTION` varchar(255) DEFAULT NULL ,
`ZONEID` int(11) DEFAULT NULL ,
`TIMEZONEID` int(11) DEFAULT NULL ,
`INVNO` int(11) DEFAULT NULL ,
`OCTETS` bigint(25) DEFAULT NULL ,
`COST` decimal(12,5) DEFAULT NULL ,
`CURRENCY` varchar(255) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`CSID` int(11) DEFAULT NULL ,
`SERVICEID` int(11) DEFAULT NULL ,
`COSTOLD` decimal(12,5) DEFAULT NULL ,

`INSERTEDON` datetime DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;



use rcbill;
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllIPUSAGE-14052018.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllIPUSAGE-31032020.csv' 

-- REPLACE INTO TABLE `rcbill`.`rcb_comments` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_ipusage1` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@USAGEID ,
@DEVICEID ,
@USAGEDATE ,
@TRAFFICTYPE ,
@CLIENTIP ,
@USAGEDIRECTION ,
@ZONEID ,
@TIMEZONEID ,
@INVNO ,
@OCTETS ,
@COST ,
@CURRENCY ,
@CID ,
@CSID ,
@SERVICEID ,
@COSTOLD 


) 
SET

USAGEID=@USAGEID ,
DEVICEID=@DEVICEID ,
USAGEDATE=@USAGEDATE ,
TRAFFICTYPE=@TRAFFICTYPE ,
CLIENTIP=@CLIENTIP ,
USAGEDIRECTION=@USAGEDIRECTION ,
ZONEID=@ZONEID ,
TIMEZONEID=@TIMEZONEID ,
INVNO=@INVNO ,
OCTETS=@OCTETS ,
COST=@COST ,
CURRENCY=@CURRENCY ,
CID=@CID ,
CSID=@CSID ,
SERVICEID=@SERVICEID ,
COSTOLD=@COSTOLD ,

INSERTEDON=now()

;

	CREATE INDEX idxrcbipu1
	ON rcbill.rcb_ipusage1 (deviceid);

	CREATE INDEX idxrcbipu2
	ON rcbill.rcb_ipusage1 (cid);

	CREATE INDEX idxrcbipu3
	ON rcbill.rcb_ipusage1 (csid);

	CREATE INDEX idxrcbipu4
	ON rcbill.rcb_ipusage1 (usagedate);

select count(*) as ipusage1 from rcbill.rcb_ipusage1;

-- select * from rcbill.rcb_ipusage;

###################################

drop table if exists rcbill.rcb_ipusage;
create table rcbill.rcb_ipusage as 
(
	select 
	a.*
	,
	-- all negative integers to be added with this number https://it.toolbox.com/question/function-required-to-convert-negative-ip-addresses-to-dotted-notation-021513
	case when a.clientip<0 then INET_NTOA((a.clientip+4294967296)) 
	else INET_NTOA(a.clientip)
	end as PROCESSEDCLIENTIP 
	, (a.octets)/(1024.0*1024.0) as MB_USED
	,b.clientcode as CLIENTCODE, b.clientid as CLIENTID, b.clientname as CLIENTNAME, b.contractcode as CONTRACTCODE
	from 
	rcbill.rcb_ipusage1 a 
	inner join
	rcbill.clientcontractdevices b 
	on 	
	a.cid=b.contractid and a.csid=b.CSID
)
;

	CREATE INDEX idxrcbipu1
	ON rcbill.rcb_ipusage (deviceid);

	CREATE INDEX idxrcbipu2
	ON rcbill.rcb_ipusage (cid);

	CREATE INDEX idxrcbipu3
	ON rcbill.rcb_ipusage (csid);

	CREATE INDEX idxrcbipu4
	ON rcbill.rcb_ipusage (usagedate);
	
    CREATE INDEX idxrcbipu5
	ON rcbill.rcb_ipusage (clientcode);
    
    CREATE INDEX idxrcbipu6
	ON rcbill.rcb_ipusage (contractcode);
    
    CREATE INDEX idxrcbipu7
	ON rcbill.rcb_ipusage (processedclientip);
    
select count(*) as ipusage from rcbill.rcb_ipusage;



########################################################
drop table if exists rcbill.clientcontractip;
create table rcbill.clientcontractip as 
(
	select distinct CLIENTCODE, CLIENTID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE from rcbill.rcb_ipusage
 --   group by CLIENTCODE, CLIENTID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE
-- where processedclientip=@ip;
-- where USAGEDATE>='2018-01-01' 

);

create index IDXccip1 on rcbill.clientcontractip (PROCESSEDCLIENTIP);
create index IDXccip2 on rcbill.clientcontractip (USAGEDATE);
create index IDXccip3 on rcbill.clientcontractip (CLIENTCODE);
create index IDXccip4 on rcbill.clientcontractip (CONTRACTCODE);
create index IDXccip5 on rcbill.clientcontractip (clientid);


###########################################################

drop table if exists rcbill.clientcontractipmonth;
create table rcbill.clientcontractipmonth as 
(
/*
select DISTINCT
CLIENTCODE, CLIENTID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, MONTH(USAGEDATE) AS USAGE_MTH, YEAR(USAGEDATE) AS USAGE_YR, count(USAGEDATE) as IPINSTANCES
from rcbill.clientcontractip
group by 
CLIENTCODE, CLIENTID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, 7, 8
*/

select DISTINCT
CLIENTCODE, CLIENTID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, MONTH(USAGEDATE) AS USAGE_MTH
, YEAR(USAGEDATE) AS USAGE_YR, min(USAGEDATE) as FROM_DATE, max(USAGEDATE) as TO_DATE,  count(USAGEDATE) as IPINSTANCES
from rcbill.clientcontractip
group by 
CLIENTCODE, CLIENTID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, 7, 8
)
;

create index IDXccipm1 on rcbill.clientcontractipmonth (PROCESSEDCLIENTIP);
create index IDXccipm3 on rcbill.clientcontractipmonth (CLIENTCODE);
create index IDXccipm4 on rcbill.clientcontractipmonth (CONTRACTCODE);
create index IDXccipm2 on rcbill.clientcontractipmonth (USAGE_MTH);
create index IDXccipm5 on rcbill.clientcontractipmonth (USAGE_YR);
create index IDXccipm6 on rcbill.clientcontractipmonth (FROM_DATE);
create index IDXccipm7 on rcbill.clientcontractipmonth (TO_DATE);

######################################################################

drop table if exists rcbill.contractsservicepackageprice;

create table rcbill.contractsservicepackageprice as 
(
	select a.kod as contractcode -- , b.servicerateid
	, c.id as servicerateid, c.`name` as package, c.`price`
	, d.`name` as service
	from 
	rcbill.rcb_contracts a 
	inner join 
	rcbill.rcb_contractservices b 
	on 
	a.id=b.cid
	inner join
	rcbill.rcb_vpnrates c 
	on 
	b.ServiceRateID=c.id

	inner join 
	rcbill.rcb_services d
	on 
	b.ServiceID=d.id

	-- where a.kod='I.000296149'

);

create index IDXcspp1 on rcbill.contractsservicepackageprice (contractcode);
create index IDXcspp3 on rcbill.contractsservicepackageprice (servicerateid);
create index IDXcspp4 on rcbill.contractsservicepackageprice (service);
-- create index IDXcspp2 on rcbill.contractsservicepackageprice (package);
-- create index IDXcspp5 on rcbill.contractsservicepackageprice (USAGE_YR);
