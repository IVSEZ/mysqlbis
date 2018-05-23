-- SET SESSION sql_mode = 'STRICT_ALL_TABLES';
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
*/