-- SET SESSION sql_mode = '';
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllContracts-04122016.txt'
-- REPLACE INTO TABLE `rcbill`.`rcb_contracts` CHARACTER SET LATIN1 FIELDS TERMINATED BY '\t' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
use rcbill;

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
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContracts-26122017.csv'
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

-- select * from rcbill.rcb_contractaddress where ContractCode in ('I.000242424');