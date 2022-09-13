-- SET SESSION sql_mode = '';

-- set @mxk_name='MXK-MAHE-PROVIDENCE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_Providence_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-ANSEAUXPINS'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_AnseAuxPins_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-ANSEETOILE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_AnseEtoile_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-ANSEROYALE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_AnseRoyale_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-BAIELAZARE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_BaieLazare_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-PERSEVERANCE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_Perseverance_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-MONTFLEURI'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_MtFleuri_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-BEAUVALLON-1'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_BeauVallon-1_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-BEAUVALLON-2'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_BeauVallon-2_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-GRANDANSE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_MaheGrandeAnse_20211217_1.csv' 
-- set @mxk_name='MXK-PRASLIN-GRANDANSE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_Praslin-1_20211217_1.csv' 
-- set @mxk_name='MXK-PRASLIN-BAIESTEANNE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_Praslin-2_20200727_1.csv' 

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\ONTInventoryReport_12-20-2021 14-13-59.csv' 

 set @mxk_name='MXK-MAHE-PROVIDENCE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_Providence_20220907_1.csv'
-- set @mxk_name='MXK-MAHE-ANSEAUXPINS'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_AnseAuxPins_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-ANSEETOILE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_AnseEtoile_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-ANSEROYALE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_AnseRoyale_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-BAIELAZARE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_BaieLazare_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-PERSEVERANCE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_Perseverance_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-MONTFLEURI'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_MtFleuri_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-BEAUVALLON-1'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_BeauVallon-1_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-BEAUVALLON-2'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_BeauVallon-2_20211217_1.csv'
-- set @mxk_name='MXK-MAHE-GRANDANSE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_MaheGrandeAnse_20211217_1.csv' 
-- set @mxk_name='MXK-PRASLIN-GRANDANSE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_Praslin-1_20211217_1.csv' 
-- set @mxk_name='MXK-PRASLIN-BAIESTEANNE'; LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CMTSMXK\\MXK_List_Praslin-2_20200727_1.csv' 



REPLACE INTO TABLE `rcbill`.`rcb_mxk` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
 IGNORE 1 LINES 
(
@mxk_region ,
@mxk_ip,
@device_name,
@mxk_card,
@mxk_cardname,
@mxk_interface ,
@port_no,
@vendor_id ,
@serial_num,
@serial_num_hex ,
@model_id ,
@ont_version ,
@sware_version ,
@me_profile,
@onu_added,
@olt_rxpwr ,
@ont_rxpwr ,
@ont_distance ,
@redundant_status,
@oper_status
) 
set 


MXK_NAME=@device_name,

MXK_IP=@mxk_ip,
MXK_CARD=@mxk_card,
MXK_CARDNAME=@mxk_cardname,
MXK_INTERFACE=@mxk_interface ,
SERIAL_NUM=@serial_num_hex ,
VENDOR_ID=@vendor_id ,
ME_PROFILE=@me_profile,
ONU_ADDED=@onu_added,
MODEL_ID=@model_id ,
ONT_VERSION=@ont_version ,
SWARE_VERSION=@sware_version ,
ONT_RXPWR=@ont_rxpwr ,
OLT_RXPWR=@olt_rxpwr ,
ONT_DISTANCE=@ont_distance ,
OP_STATUS=@oper_status,
INSERTEDON=now()

;

-- update rcbill.rcb_cmts
-- set mac_address_clean = 

select count(*) as mxk from rcbill.rcb_mxk;

-- select * from rcbill.rcb_mxk where mxk_interface='';
/*
select mxk_name
-- , MXK_INTERFACE
, date(insertedon) as dateinserted, count(*) as devicecount
from rcbill.rcb_mxk
group by mxk_name, 2 -- , 3
order by 2 desc, 1 asc
;

*/
select date(insertedon) as dateinserted, mxk_name
-- , MXK_INTERFACE
,  count(*) as devicecount
from rcbill.rcb_mxk
group by 1, 2 -- , 3
order by 1 desc, 2 asc
;


/*
	case 
		when @device_name='BEAU VALLON 2' then MXK_NAME='MXK-MAHE-BEAUVALLON-2'
		when @device_name='MAHE-ANSE_ROYALE_2' then MXK_NAME='MXK-MAHE-ANSEROYALE-2'
		when @device_name='MAHE-ANSE-AUX-PINS' then MXK_NAME='MXK-MAHE-ANSEAUXPINS'
		when @device_name='MAHE-ANSE-ETOILE' then MXK_NAME='MXK-MAHE-ANSEETOILE'
		when @device_name='MAHE-ANSE-ROYALE' then MXK_NAME='MXK-MAHE-ANSEROYALE'
		when @device_name='MAHE-BEAU-VALLON' then MXK_NAME='MXK-MAHE-BEAUVALLON-1'
		when @device_name='MAHE-GRAND-ANSE' then MXK_NAME='MXK-MAHE-GRANDANSE'
		when @device_name='MAHE-LAB' then MXK_NAME='MXK-MAHE-LAB'
		when @device_name='MAHE-MT-FLEURI' then MXK_NAME='MXK-MAHE-MONTFLEURI'
		when @device_name='MAHE-PERSEVERANCE' then MXK_NAME='MXK-MAHE-PERSEVERANCE'
		when @device_name='MAHE-PROVIDENCE' then MXK_NAME='MXK-MAHE-PROVIDENCE'
		when @device_name='PRASLIN-GRAND-ANSE' then MXK_NAME='MXK-PRASLIN-GRANDANSE'
		when @device_name='PRASLIN-BAIE-STE-ANNE' then MXK_NAME='MXK-PRASLIN-BAIESTEANNE'
	end
,
*/
SET SQL_SAFE_UPDATES = 0;
update rcbill.rcb_mxk set MXK_NAME='MXK-MAHE-BEAUVALLON-2' where MXK_NAME='BEAU VALLON 2';
update rcbill.rcb_mxk set MXK_NAME='MXK-MAHE-ANSEROYALE-2' where MXK_NAME='MAHE-ANSE_ROYALE_2';
update rcbill.rcb_mxk set MXK_NAME='MXK-MAHE-ANSEAUXPINS' where MXK_NAME='MAHE-ANSE-AUX-PINS';
update rcbill.rcb_mxk set MXK_NAME='MXK-MAHE-ANSEETOILE' where MXK_NAME='MAHE-ANSE-ETOILE';
update rcbill.rcb_mxk set MXK_NAME='MXK-MAHE-ANSEROYALE' where MXK_NAME='MAHE-ANSE-ROYALE';
update rcbill.rcb_mxk set MXK_NAME='MXK-MAHE-BEAUVALLON-1' where MXK_NAME='MAHE-BEAU-VALLON';
update rcbill.rcb_mxk set MXK_NAME='MXK-MAHE-GRANDANSE' where MXK_NAME='MAHE-GRAND-ANSE';

update rcbill.rcb_mxk set MXK_NAME='MXK-MAHE-LAB' where MXK_NAME='MAHE-LAB';
update rcbill.rcb_mxk set MXK_NAME='MXK-MAHE-MONTFLEURI' where MXK_NAME='MAHE-MT-FLEURI';
update rcbill.rcb_mxk set MXK_NAME='MXK-MAHE-PERSEVERANCE' where MXK_NAME='MAHE-PERSEVERANCE';
update rcbill.rcb_mxk set MXK_NAME='MXK-MAHE-PROVIDENCE' where MXK_NAME='MAHE-PROVIDENCE';
update rcbill.rcb_mxk set MXK_NAME='MXK-PRASLIN-GRANDANSE' where MXK_NAME='PRASLIN-GRAND-ANSE';
update rcbill.rcb_mxk set MXK_NAME='MXK-PRASLIN-BAIESTEANNE' where MXK_NAME='PRASLIN-BAIE-STE-ANNE';


-- select distinct vendor_id from rcbill.rcb_mxk;
-- select mxk_interface, count(*) from rcbill.rcb_mxk group by mxk_interface;


-- select * from rcbill.rcb_mxk where date(INSERTEDON) in (select max(date(INSERTEDON)) from rcbill.rcb_mxk);


/*

SET SQL_SAFE_UPDATES = 0;
-- delete from rcbill.rcb_mxk where date(insertedon)='2022-09-07';

delete from rcbill.rcb_mxk 
where mxk_interface in ('','==========','====================','CPEs','Interface','ONUs','Serial','13','14','for','exit');

select * from rcbill.rcb_mxk 
where mxk_interface in ('','==========','====================','CPEs','Interface','ONUs','Serial','13','14','for','exit');

*/