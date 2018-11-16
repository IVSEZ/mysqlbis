-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20180902-1500.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20180915-1100.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\CMTS_List_20181013-1400.csv' 
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

select * from rcbill.rcb_cmts;


select hfc_node, date(insertedon) as dateinserted, count(*) as devicecount
from rcbill.rcb_cmts
group by hfc_node, 2;


/*

SET SQL_SAFE_UPDATES = 0;
delete from rcbill.rcb_cmts where date(insertedon)='2018-10-13';

*/

