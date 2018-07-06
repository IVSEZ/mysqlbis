use rcbill_my;

set @category='CAPPED';

-- set @periodstart='2016-10-01';
-- set @periodend='2017-09-30';
-- set @periodstart='2017-10-01';
-- set @periodend='2017-10-14';
 set @periodstart='2018-07-05';
 set @periodend='2018-07-05';

## change dates on csv 4 files

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailyUsage\\cdrUsageClient-Capped-05052018-06052018.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailyUsage\\cdrUsageClient-Capped-05072018.csv'

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


###################################################################

set @category='UNCAPPED';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailyUsage\\cdrUsageClient-UnCapped-05052018-06052018.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailyUsage\\cdrUsageClient-UnCapped-05072018.csv'

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


###########################################################################


set @category='PREPAID';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailyUsage\\cdrUsageClient-PREPAID-05052018-06052018.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailyUsage\\cdrUsageClient-PREPAID-05072018.csv'



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


###########################################################

set @category='HOTSPOT';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailyUsage\\cdrUsageClient-Hotspot-05052018-06052018.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailyUsage\\cdrUsageClient-Hotspot-05072018.csv'

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


select count(1) from rcbill_my.dailyusage;

-- select * from rcbill_my.dailyusage;

-- select * from rcbill_my.dailyusage where clientcode='I.000010761';

-- select * from rcbill_my.dailyusage where clientcode='I.000011750';

-- select * from rcbill_my.dailyusage where clientcode='I22694';

-- select * from rcbill_my.dailyusage;
select distinct datestart, dateend, date(INSERTEDON) as insertedon, count(1) as records from rcbill_my.dailyusage group by 1,2,3 order by datestart desc;

/*

set sql_safe_updates=0;
delete from rcbill_my.dailyusage where date(INSERTEDON)='2018-04-12';

update rcbill_my.dailyusage
set 
datestart='2018-03-18',
dateend='2018-03-18'
where
date(INSERTEDON)='2018-03-18';
*/
-- select distinct datestart, dateend from rcbill_my.dailyusage where date(INSERTEDON)='2018-02-12';
-- select distinct datestart, dateend, date(INSERTEDON) as insertedon, count(1) as records from rcbill_my.dailyusage group by 1,2,3 order by 3 desc where date(INSERTEDON)='2018-02-12';