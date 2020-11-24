-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20180902-1500.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20180915-1100.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20181013-1400.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20181126-1000.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20181220-1330.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20190101-1430.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20190204-1000.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20190415-1600.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20190603-1000.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20190626-0823.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20190906-1256.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20191001-0819.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20191211-1300.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20200106-1000.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20200422-0800.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20200720-1048.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20200727-1439.csv' 
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20201123-1644.csv' 

REPLACE INTO TABLE `rcbill`.`rcb_cmts` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
 IGNORE 1 LINES 
(
@mac_address ,
@ip_address ,
@hfc_node ,
@mac_state ,
@prim_sid ,
@rxpwr_dBmv ,
@timing_offset ,
@num_cpe ,
@dip 

) 
set 
MAC_ADDRESS=@mac_address ,
MAC_ADDRESS_CLEAN1=trim(REPLACE (@mac_address, '.', '')),

-- MAC_ADDRESS_CLEAN2=concat(substring(trim(REPLACE (@mac_address, '.', '')),2,2), '.',substring(trim(REPLACE (@mac_address, '.', '')),4,2),'.',substring(REPLACE (@mac_address, '.', ''),6,2),'.',substring(REPLACE (@mac_address, '.', ''),8,2),'.',substring(REPLACE (@mac_address, '.', ''),10,2),'.',substring(REPLACE (@mac_address, '.', ''),12,2)),
MAC_ADDRESS_CLEAN2=concat(substring(MAC_ADDRESS_CLEAN1,1,2), '.',substring(MAC_ADDRESS_CLEAN1,3,2),'.',substring(MAC_ADDRESS_CLEAN1,5,2),'.',substring(MAC_ADDRESS_CLEAN1,7,2),'.',substring(MAC_ADDRESS_CLEAN1,9,2),'.',substring(MAC_ADDRESS_CLEAN1,11,2)),
IP_ADDRESS=@ip_address ,
HFC_NODE=@hfc_node ,
MAC_STATE=@mac_state ,
PRIM_SID=@prim_sid ,
RXPWR_DBMV=@rxpwr_dBmv ,
TIMING_OFFSET=@timing_offset ,
NUM_CPE=@num_cpe ,
DIP=@dip ,



INSERTEDON=now()

;

-- update rcbill.rcb_cmts
-- set mac_address_clean = 

select count(*) as cmts from rcbill.rcb_cmts;

-- select * from rcbill.rcb_cmts;


select hfc_node, date(insertedon) as dateinserted, count(*) as devicecount
from rcbill.rcb_cmts
group by hfc_node, 2
order by 1, 2 desc
;

-- select * from rcbill.rcb_cmts where date(INSERTEDON) in (select max(date(INSERTEDON)) from rcbill.rcb_cmts)

/*

SET SQL_SAFE_UPDATES = 0;
delete from rcbill.rcb_cmts where date(insertedon)='2020-11-23' and mac_address='';
delete from rcbill.rcb_cmts where date(insertedon)='2020-11-23' and mac_address='MAC';



delete from rcbill.rcb_cmts where date(insertedon)='2020-07-27' and mac_address='';
delete from rcbill.rcb_cmts where date(insertedon)='2020-07-27' and mac_address='MAC';



delete from rcbill.rcb_cmts where date(insertedon)='2020-07-20' and mac_address='';
delete from rcbill.rcb_cmts where date(insertedon)='2020-07-20' and mac_address='MAC';



delete from rcbill.rcb_cmts where date(insertedon)='2018-10-13';
delete from rcbill.rcb_cmts where date(insertedon)='2018-12-20' and mac_address='';
delete from rcbill.rcb_cmts where date(insertedon)='2019-01-01' and mac_address='';

delete from rcbill.rcb_cmts where date(insertedon)='2019-02-04' and mac_address='';
delete from rcbill.rcb_cmts where date(insertedon)='2019-04-15' and mac_address='';
delete from rcbill.rcb_cmts where date(insertedon)='2019-06-03' and mac_address='';

delete from rcbill.rcb_cmts where date(insertedon)='2019-06-26' and mac_address='';

delete from rcbill.rcb_cmts where date(insertedon)='2019-09-06' and mac_address='';

delete from rcbill.rcb_cmts where date(insertedon)='2019-10-01' and mac_address='';

delete from rcbill.rcb_cmts where date(insertedon)='2019-12-11' and mac_address='';
delete from rcbill.rcb_cmts where date(insertedon)='2019-12-11' and mac_address='MAC';


delete from rcbill.rcb_cmts where date(insertedon)='2020-01-06' and mac_address='';
delete from rcbill.rcb_cmts where date(insertedon)='2020-01-06' and mac_address='MAC';

delete from rcbill.rcb_cmts where date(insertedon)='2020-04-22' and mac_address='';
delete from rcbill.rcb_cmts where date(insertedon)='2020-04-22' and mac_address='MAC';

*/

