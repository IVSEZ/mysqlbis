-- SET SESSION sql_mode = '';

-- set @mxk_name='MXK-MAHE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\cmts\\MXK_List_Mahe_20180903_2.csv'
-- set @mxk_name='MXK-ANSEETOILE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\cmts\\MXK_List_AnseEtoile_20180903_2.csv'
-- set @mxk_name='MXK-ANSEROYALE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\cmts\\MXK_List_AnseRoyale_20180903_2.csv'
-- set @mxk_name='MXK-PERSEVERANCE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\cmts\\MXK_List_Perseverance_20180903_2.csv'
-- set @mxk_name='MXK-BEAUVALLON'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\cmts\\MXK_List_BeauVallon_20180903_2.csv'
 set @mxk_name='MXK-PRASLIN'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\cmts\\MXK_List_Praslin_20180903_2.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_mxk` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
 IGNORE 3 LINES 
(
@id ,
@mxk_interface ,
@serial_num ,
@vendor_id ,
@model_id ,
@ont_version ,
@sware_version ,
@ont_rxpwr ,
@pwr1 ,
@olt_rxpwr ,
@pwr2 ,
@ont_distance 

) 
set 
MXK_NAME=@mxk_name ,
MXK_INTERFACE=@mxk_interface ,
SERIAL_NUM=@serial_num ,
VENDOR_ID=@vendor_id ,
MODEL_ID=@model_id ,
ONT_VERSION=@ont_version ,
SWARE_VERSION=@sware_version ,
ONT_RXPWR=@ont_rxpwr ,
OLT_RXPWR=@olt_rxpwr ,
ONT_DISTANCE=@ont_distance ,

INSERTEDON=now()

;

-- update rcbill.rcb_cmts
-- set mac_address_clean = 

select count(*) as cmts from rcbill.rcb_mxk;

select * from rcbill.rcb_mxk;


