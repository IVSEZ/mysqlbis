use rcbill_my;

set @category='CAPPED';

-- set @periodstart='2016-10-01';
-- set @periodend='2017-09-30';
-- set @periodstart='2017-10-01';
-- set @periodend='2017-10-14';
-- set @periodstart='2018-09-20';
-- set @periodend='2018-09-20';

-- set @periodstart='2018-12-29';
-- set @periodend='2018-12-29';

## change dates on csv 4 files

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\cdrUsageClient-Capped-25082019-02092019.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\cdrUsageClient-Capped-16072020.csv'

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

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\cdrUsageClient-UnCapped-25082019-02092019.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\cdrUsageClient-UnCapped-16072020.csv'

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

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\cdrUsageClient-PREPAID-25082019-02092019.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\cdrUsageClient-PREPAID-16072020.csv'



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

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\cdrUsageClient-Hotspot-25082019-02092019.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\cdrUsageClient-Hotspot-16072020.csv'

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


select count(1) as dailyusage from rcbill_my.dailyusage;

-- select * from rcbill_my.dailyusage order by insertedon desc limit 30000;

-- select * from rcbill_my.dailyusage where clientcode='I.000010761';

-- select * from rcbill_my.dailyusage where clientcode='I.000011750';

-- select * from rcbill_my.dailyusage where clientcode='I22694';

-- select * from rcbill_my.dailyusage where date(insertedon)='2018-09-13';
select distinct datestart, dateend, date(INSERTEDON) as insertedon, count(1) as records from rcbill_my.dailyusage group by 1,2,3 
order by datestart desc
limit 5
;

/*

set sql_safe_updates=0;

update rcbill_my.dailyusage
set datestart=dateend
where date(insertedon)>'2019-09-03'
;


update rcbill_my.dailyusage
set dateend='2018-09-12'
where date(insertedon)='2018-09-13'
;

delete from rcbill_my.dailyusage where date(INSERTEDON)>'2018-12-21';
delete from rcbill_my.dailyusage where date(INSERTEDON)='2019-09-03';

update rcbill_my.dailyusage
set 
datestart='2018-03-18',
dateend='2018-03-18'
where
date(INSERTEDON)='2018-03-18';
*/
-- select distinct datestart, dateend from rcbill_my.dailyusage where date(INSERTEDON)='2018-02-12';
-- select distinct datestart, dateend, date(INSERTEDON) as insertedon, count(1) as records from rcbill_my.dailyusage group by 1,2,3 order by 3 desc where date(INSERTEDON)='2018-02-12';

/*

SET SQL_SAFE_UPDATES = 0;

delete from rcbill_my.dailyusage where date(insertedon)='2019-11-21';


*/

