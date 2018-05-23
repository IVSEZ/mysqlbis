set @category='PREPAID';

-- set @periodstart='2016-10-01';
-- set @periodend='2017-09-30';
-- set @periodstart='2017-10-01';
-- set @periodend='2017-10-14';
-- set @periodstart='2017-12-06';
-- set @periodend='2017-12-06';


-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailyUsage\\cdrUsageClient-PREPAID-01102016-30092017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailyUsage\\cdrUsageClient-PREPAID-25112017-26112017.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailyUsage\\cdrUsageClient-PREPAID-26122017.csv'



REPLACE INTO TABLE `rcbill_my`.`dailyusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@Service ,
@Client ,
@Device ,
@TrafficType ,
@TimeZone ,
@Destination ,
@Traffic_MB ,
@Billable_duration_min ,
@Actual_duration_min ,
@price ,
@price_vat ,
@InsertedOn
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
CATEGORY=@category ,
SERVICE=@Service ,
CLIENT=@Client ,
CLIENTNAME=trim(upper(SUBSTRING_INDEX(@Client,'::',1))),
CLIENTID=SUBSTRING_INDEX(@Client,'::',-1),
CLIENTCODE=rcbill.GetClientCode(SUBSTRING_INDEX(@Client,'::',-1)),


DEVICE=@Device ,
TRAFFICTYPE=SUBSTRING_INDEX(@TrafficType,'::',1) ,
TIMEZONE=SUBSTRING_INDEX(@TimeZone,'::',1) ,
DESTINATION=@Destination ,
TRAFFIC_MB=@Traffic_MB ,
BILLABLE_DURATION_MIN=@Billable_duration_min ,
ACTUAL_DURATION_MIN=@Actual_duration_min ,
PRICE=@price ,
PRICE_VAT=@price_vat ,

INSERTEDON=now()

;

-- select * from rcbill_my.dailyusage;
