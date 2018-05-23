DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_LoadDailyActiveNumber`(IN pddate varchar(10), IN filename varchar(255))
BEGIN

SET @perioddate=str_to_date(pddate,'%Y-%m-%d');	
LOAD DATA LOW_PRIORITY LOCAL INFILE filename
REPLACE INTO TABLE `rcbill_my`.`dailyactivenumber` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n'

-- INTO TABLE rcbill_my.dailyactivenumber 
-- FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@activenumberid,
@clid,
@cid,
@contract,
@contractdate,
@validity,
@fromdate,
@todate,
@state,
@lastaction,
@lastchange,
@count,
@devicescount,
@promotion,
@clientcode,
@client,
@clientclassold,
@representative,
@phones,
@correspondenceaddress,
@service,
@servicetype,
@price,
@previousservicetype,
@regionallevel3,
@regionallevel2,
@regionallevel1,
@region
) 
set 
ACTIVENUMBERID=@activenumberid,							
PERIOD=@perioddate,							
periodday	=	(select	extract(day	from	period)),		
periodmth	=	(select	extract(month	from	period)),		
periodyear	=	(select	extract(year	from	period)),		
weekday=(select	dayname(period)),						
mthname=(select	monthname(period)),						
CLIENTID=@clid,							
CONTRACTID=@cid,							
CLIENTCODE=@clientcode,							
CONTRACTCODE=@contract,							
CONTRACTDATE=@contractdate,							
VALIDITY=@validity,							
CONTRACTSTARTDATE=@fromdate,							
CONTRACTENDDATE=@todate,							
CONTRACTSTATE=@state,							
LASTACTION=@lastaction,							
LASTCHANGE=@lastchange,							
ACTIVECOUNT=@count,							
DEVICESCOUNT=@devicescount,							
PROMOTION=@promotion,							
CLIENTNAME=@client,							
CLIENTCLASS=@clientclass,							
CLIENTTYPE=@clienttype,							
REPRESENTATIVE=@representative,							
PHONE=@phones,							
ADDRESS=@correspondenceaddress,							
SERVICE=@service,							
SERVICECATEGORY=(select servicecategory from rcbill_my.lkpbaseservice where service=@service),							
SERVICESUBCATEGORY=(select servicesubcategory from rcbill_my.lkpbaseservice where service=@service),							
							
							
SERVICETYPE=@servicetype,							
-- clientclassold	=	@clientclassold,					
CLIENTCLASS	=	(select	NewClientClass	from	rcbill_my.lkpclienttype	where	origclientclass=@clientclassold),
CLIENTTYPE	=	(select	clienttype	from	rcbill_my.lkpclienttype	where	origclientclass=@clientclassold),
							
PREVIOUSSERVICETYPE=@previousservicetype,							
PRICE=@price,							
REGIONALLEVEL1=@regionallevel1,							
REGIONALLEVEL2=@regionallevel2,							
REGIONALLEVEL3=@regionallevel3,							
REGION=@region,							

REPORTED = (select reported from rcbill_my.lkpreported where servicenewtype=servicetype)

;


END$$
DELIMITER ;
