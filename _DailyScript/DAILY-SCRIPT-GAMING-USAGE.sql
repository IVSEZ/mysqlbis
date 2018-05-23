use rcbill_my;
 set @periodstart='2017-12-23';
 set @periodend='2018-01-07';
## change dates on csv 4 files

 
set @category='Playstation.net content download';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\Workspace\\IV\\Work\\Reports\\Analysis\\Gaming\\20171223-20180107-Playstation.net content download.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
CATEGORY=@category ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

set @category='Playstation game';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\Workspace\\IV\\Work\\Reports\\Analysis\\Gaming\\20171223-20180107-Playstation game.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
CATEGORY=@category ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

set @category='Playstation.net';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\Workspace\\IV\\Work\\Reports\\Analysis\\Gaming\\20171223-20180107-Playstation.net.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
CATEGORY=@category ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

set @category='Playstation';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\Workspace\\IV\\Work\\Reports\\Analysis\\Gaming\\20171223-20180107-Playstation.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
CATEGORY=@category ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

set @category='Xbox Live update';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\Workspace\\IV\\Work\\Reports\\Analysis\\Gaming\\20171223-20180107-Xbox Live update.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
CATEGORY=@category ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

set @category='Xbox Live TLS';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\Workspace\\IV\\Work\\Reports\\Analysis\\Gaming\\20171223-20180107-Xbox Live TLS.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
CATEGORY=@category ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

set @category='Xbox Live';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\Workspace\\IV\\Work\\Reports\\Analysis\\Gaming\\20171223-20180107-Xbox Live.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
CATEGORY=@category ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

set @category='Steam Client';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\Workspace\\IV\\Work\\Reports\\Analysis\\Gaming\\20171223-20180107-Steam Client.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
CATEGORY=@category ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################

set @category='Steam Game';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\Workspace\\IV\\Work\\Reports\\Analysis\\Gaming\\20171223-20180107-Steam Game.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
CATEGORY=@category ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################


set @category='Counter-Strike Global Offensive';
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\Workspace\\IV\\Work\\Reports\\Analysis\\Gaming\\20171223-20180107-Counter-Strike Global Offensive.csv'

REPLACE INTO TABLE `rcbill_my`.`dailygamingusage` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ip ,
@totalbytes
) 
set 
DATESTART=@periodstart ,
DATEEND=@periodend ,
CATEGORY=@category ,
IP=@ip ,
TOTALBYTES=@totalbytes,
INSERTEDON=now()

;


###################################################################


select count(*) from rcbill_my.dailygamingusage;

-- select * from rcbill_my.dailyusage;

-- select * from rcbill_my.dailyusage where clientcode='I.000010761';

-- select * from rcbill_my.dailyusage where clientcode='I.000011750';

select *,((totalbytes/1024)/1024) as TOTALMB, (((totalbytes/1024)/1024)/1024) as TOTALGB from rcbill_my.dailygamingusage order by 8 desc;

select *,(totalbytes/1048576) as TOTALMB, (totalbytes/1073741824) as TOTALGB from rcbill_my.dailygamingusage order by 8 desc;

select distinct ip, count(*) as countip, (sum(totalbytes)/1048576) as TOTALMB, (sum(totalbytes)/1073741824) as TOTALGB 
from rcbill_my.dailygamingusage
group by ip order by 4 desc;
