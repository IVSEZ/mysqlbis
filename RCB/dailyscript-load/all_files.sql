-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllComments-04122017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_comments` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
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
show index from rcb_comments;

select count(*) from rcb_comments;

select * from rcbill.rcb_comments;
-- where `comment` like '%intelba93%' ;
-- SET SESSION sql_mode = '';
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllContracts-04122016.txt'
-- REPLACE INTO TABLE `rcbill`.`rcb_contracts` CHARACTER SET LATIN1 FIELDS TERMINATED BY '\t' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractDiscountsOld-03102017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractDiscounts-03102017.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractDiscounts-04122017.csv'

REPLACE INTO TABLE `rcbill`.`rcb_contractdiscounts` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
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
	from rcbill.clientcontractdiscounts
 	group by clientcode, contractcode
	-- order by clientcode, contractcode
	HAVING MAX(upddate) is not null
)
;
CREATE INDEX IDXCCLD1
ON rcbill.clientcontractlastdiscount (b_clientcode, b_contractcode);

select * from rcbill.clientcontractdiscounts;
select * from rcbill.clientcontractlastdiscount;

select * from rcbill.clientcontractdiscounts where clientid=723711 order by clientcode, contractcode, upddate;
-- SET SESSION sql_mode = '';
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllContracts-04122016.txt'
-- REPLACE INTO TABLE `rcbill`.`rcb_contracts` CHARACTER SET LATIN1 FIELDS TERMINATED BY '\t' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 


-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllContracts-08122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllContracts-13122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContracts-23122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContracts-04012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContracts-10012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContracts-19012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContracts-22012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContracts-29012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContracts-05022017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContracts-21022017.csv'
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContracts-04122017.csv'
REPLACE INTO TABLE `rcbill`.`rcb_contracts` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
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
-- select * from rcbill.rcb_contracts where id=2111852;



drop table if exists rcbill.rcb_contractaddress;
create table rcbill.rcb_contractaddress as
(
select distinct a.id as ContractId, a.kod as ContractCode, a.Address as ContractAddress, rcbill.GetClientCode(clid) as ClientCode, min(ifnull(b.SettlementName,'SILHOUETTE ISLAND')) as ContractLocation, 
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


select * from rcbill.rcb_contractaddress order by contractcode;

select distinct ContractLocation, count(*) as ContractCount from rcbill.rcb_contractaddress
group by ContractLocation;


## CREATE CLIENT CONTRACT TABLE

-- drop table if exists rcbill.clientcontra

-- select * from rcbill.clientcontracts;

SELECT a.id as clientid, a.kod as clientcode, b.id as contractid, b.kod as contractcode
FROM
rcbill.rcb_tclients a 
inner join 
rcbill.rcb_contracts b 
on 
a.id=b.clid;

/*
select distinct contractcode, contractlocation, count(contractcode) from rcbill.rcb_contractaddress
group by ContractCode, ContractLocation
order by ContractCode;

select distinct contractcode, contractlocation, count(*) from rcbill.rcb_contractaddress
group by ContractCode, ContractLocation
order by ContractCode;
*/

-- select * from rcbill.rcb_contractaddress where ContractCode in ('I.000242424');use rcbill;
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevices-29012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevices-05022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevices-21022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevices-28022017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevices-04122017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_devices` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
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
-- select * from rcb_devices where mac = '68.db.67.59.9b.37' order by upddate;
select count(*) from rcb_devices;

/*
create table client contract devices
*/

drop table if exists rcbill.clientcontractdevices;
create table rcbill.clientcontractdevices(INDEX idxccd1 (mac), INDEX idxccd2 (contractcode), INDEX idxccd3 (clientcode)) as 
(
select a.contractid as CONID, a.phoneno, a.mac, a.address, b.id as ContractId,b.kod as ContractCode, b.ContractType, b.clid, c.id as ClientId, c.kod as ClientCode, c.firm as ClientName, c.address as ClientAddress
from 
rcbill.rcb_devices a 
inner join 
rcbill.rcb_contracts b 

on a.contractid=b.id


inner join 
rcbill.rcb_tclients c

on b.clid=c.id
)
;



-- optimize table rcbill.clientcontractdevices;/*
Error Code: 1406. Data too long for column 'SerNo' at row 260813 - put quotes on "96HBN97FS48429"
Error Code: 1292. Incorrect datetime value: '0' for column 'UpdDate' at row 408985 - remove quotes from "01802014467
Error Code: 1406. Data too long for column 'SerNo' at row 1048246 - put quotes on "96HBN97FS48429"
*/

-- duration 94.219 sec

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevicesOld-29012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevicesOld-05022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevicesOld-21022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevicesOld-28022017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevicesOld-04122017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_devicesold` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
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

-- select * from rcb_devicesold limit 1000;-- SET SESSION sql_mode = 'STRICT_ALL_TABLES';
use rcbill;
-- SET SESSION sql_mode = '';
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllClients-04122016.txt'
-- REPLACE INTO TABLE `rcbill`.`rcb_tclients` CHARACTER SET LATIN1 FIELDS TERMINATED BY '\t' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 


-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllClients-08122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllClients-13122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllClients-23122016.csv' 

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllClients-04012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllClients-10012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllClients-19012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllClients-22012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllClients-29012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllClients-05022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTClients-21022017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTClients-04122017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_tclients` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
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

select * from rcbill.rcb_clientphones;
-- show index from rcbill.rcb_clientphones;


############################################################################
drop table if exists rcbill.rcb_clientaddress;
create table rcbill.rcb_clientaddress as
(
select distinct a.id as ClientId, a.firm as ClientName, a.kod as ClientCode, a.MOLADDRESS as ClientAddress, min(ifnull(b.SettlementName,'SILHOUETTE ISLAND')) as ClientLocation, 
min(ifnull(b.areaname,'SILHOUETTE ISLAND')) as ClientArea
from 
rcbill.rcb_tclients a
left join
(
/*
select distinct settlementname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD')
group by settlementname
*/

select distinct settlementname, areaname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD') 
-- and settlementname not in ('VICTORIA')
group by settlementname, areaname
order by SETTLEMENTNAME, areaname
) b
on
(a.moladdress like concat('%', b.SETTLEMENTNAME , '%') and a.moladdress like concat('%', b.areaname , '%'))
group by clientid, clientname, clientcode, clientaddress

)
;

CREATE INDEX IDXcaddress1
ON rcbill.rcb_clientaddress (ClientCode);

CREATE INDEX IDXcaddress2
ON rcbill.rcb_clientaddress (ClientName);

CREATE INDEX IDXcaddress3
ON rcbill.rcb_clientaddress (ClientLocation);


select * from rcbill.rcb_clientaddress order by clientcode;
select * from rcbill.rcb_tclients;

/*
drop table clientsoundex;


CREATE TABLE IF NOT EXISTS clientsoundex AS (
SELECT distinct(firm) as CL_CLIENTNAME, soundex(FIRM) as CLIENTNAME_SDX from rcb_tclients order by 1 
  limit 10
)
;

CREATE INDEX IDXclientsoundex
ON clientsoundex (CL_CLIENTNAME);



drop table clientname;

CREATE TABLE IF NOT EXISTS clientname AS (
SELECT distinct(firm) as CL_CLIENTNAME from rcb_tclients order by 1 
 limit 10
)
;

CREATE INDEX IDXclientname
ON clientname (CL_CLIENTNAME);

select * from clientsoundex;
select * from clientname;

select a.CL_CLIENTNAME as CL_CLIENTNAME1, b.CL_CLIENTNAME as CL_CLIENTNAME2, levenshtein_ratio(a.CL_CLIENTNAME,b.CL_CLIENTNAME) as LVRATIO, CLIENTNAME_SDX
from
clientname a 
cross join
clientsoundex b
-- on a.CL_CLIENTNAME=b.CL_CLIENTNAME
where levenshtein_ratio(a.CL_CLIENTNAME,b.CL_CLIENTNAME) > 50
order by 1 asc, 3 desc

;

select a.CL_CLIENTNAME as CL_CLIENTNAME1, b.CL_CLIENTNAME as CL_CLIENTNAME2 
from
clientname a 
cross join
clientsoundex b
order by 1 asc
;
*/-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketComments-04122017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_ticketcomments` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
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

select count(*) from rcb_ticketcomments;

select * from rcbill.rcb_ticketcomments;
-- where `comment` like '%intelba93%' ;
-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTickets-04122017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_tickets` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
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

select count(*) from rcb_tickets;

select * from rcbill.rcb_tickets;
-- SET SESSION sql_mode = '';
use rcbill;

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-03092017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-03092017-12092017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-14092017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-25112017-26112017.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-04122017.csv'
REPLACE INTO TABLE `rcbill`.`rcb_tstelemetry` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@﻿ID ,
@Device ,
@Type ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
) 
set 
﻿ID=@﻿ID ,
DEVICE=@Device ,
TYPE=@Type ,
RESOURCE=upper(trim(@Resource)) ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart ,
SESSIONEND=@SessionEnd ,

INSERTEDON=now()



;

select count(*) from rcb_tstelemetry;

select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday,  resource, sum(duration), count(*) from rcbill.rcb_tstelemetry
group by 1, 2
order by 1 desc, 4 desc;


select resource, sum(duration), count(*) from rcbill.rcb_tstelemetry
group by 1
order by 3 desc;

/*
SET SQL_SAFE_UPDATES = 0;

delete from rcbill.rcb_tstelemetry
where  date(SESSIONSTART)>'2017-09-02'
order by sessionstart;
*/-- SET SESSION sql_mode = '';
use rcbill;
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-05092017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-06092017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-07092017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-14092017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-25112017-26112017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-04122017.csv'
REPLACE INTO TABLE `rcbill`.`rcb_vodtelemetry` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@﻿ID ,
@Device ,
@Type ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
) 
set 
﻿ID=@﻿ID ,
DEVICE=@Device ,
TYPE=@Type ,
RESOURCE=upper(trim(@Resource)) ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart ,
SESSIONEND=@SessionEnd ,

INSERTEDON=now()



;

select count(*) from rcb_vodtelemetry;

select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(*) from rcbill.rcb_vodtelemetry
group by 1
order by 1 desc;

-- select * from rcbill.rcb_vodtelemetry order by SESSIONSTART;

/*
select a.device,a.duration,a.resource,a.sessionstart,a.subscriber,b.originaltitle,b.imdbtitleref
from
rcbill.rcb_vodtelemetry a 
inner join 
rcbill.rcb_vodtitles b 
on 
a.resource=b.IMDBTITLEREF
where 
a.SessionStart>'2017-01-01'
order by b.originaltitle 
;

select * from rcbill.clientcontractdevices;

*/