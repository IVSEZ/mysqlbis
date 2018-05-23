-- SET SESSION sql_mode = '';
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllContracts-04122016.txt'
-- REPLACE INTO TABLE `rcbill`.`rcb_contracts` CHARACTER SET LATIN1 FIELDS TERMINATED BY '\t' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractDiscountsOld-03102017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractDiscounts-03102017.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractDiscounts-26122017.csv'

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
