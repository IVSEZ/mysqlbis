-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20190416.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20190418.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20190517.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20190727.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20191013.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20200109.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20200314.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20200626.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20200718.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20220907.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20220912.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20220923.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20220930.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_parcel_score_20221007.csv' 

REPLACE INTO TABLE `rcbill`.`client_match_parcel` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
 IGNORE 1 LINES 
(
@client_code1 ,
@client_name1 ,
@client_parcel1 ,
@client_code2 ,
@client_name2 ,
@client_parcel2 ,
@match_score  

) 
set 
CLIENT_CODE=@client_code1 ,
CLIENT_NAME=UPPER(TRIM(@client_name1)) ,
CLIENT_PARCEL=UPPER(TRIM(@client_parcel1)) ,
M_CLIENT_CODE=@client_code2 ,
M_CLIENT_NAME=UPPER(TRIM(@client_name2)) ,
M_CLIENT_PARCEL=UPPER(TRIM(@client_parcel2)) ,
M_SCORE=@match_score ,

INSERTEDON=now()

;

-- update rcbill.rcb_cmts
-- set mac_address_clean = 

select date(insertedon) as insertedon, count(*) as records from rcbill.client_match_parcel
group by 1
order by 1 desc
;

-- select * from rcbill.client_match_parcel;



/*

SET SQL_SAFE_UPDATES = 0;
delete from rcbill.rcb_mxk where date(insertedon)='2018-10-13';

delete from rcbill.rcb_mxk 
where mxk_interface in ('','==========','====================','CPEs','Interface','ONUs','Serial','13','14');


*/