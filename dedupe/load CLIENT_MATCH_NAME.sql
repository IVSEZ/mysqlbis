-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20181224.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20181227.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20190208.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20190322.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20190413.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20190517.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20190727.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20191013.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20200109.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20200314.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20200626.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20200718.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20220907.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_name_score_20220909.csv' 


REPLACE INTO TABLE `rcbill`.`client_match_name` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
 IGNORE 1 LINES 
(
@client_code1 ,
@client_name1 ,
@client_code2 ,
@client_name2 ,
@match_score  

) 
set 
CLIENT_CODE=@client_code1 ,
CLIENT_NAME=UPPER(TRIM(@client_name1)) ,
M_CLIENT_CODE=@client_code2 ,
M_CLIENT_NAME=UPPER(TRIM(@client_name2)) ,
M_SCORE=@match_score ,

INSERTEDON=now()

;

-- update rcbill.rcb_cmts
-- set mac_address_clean = 

select date(insertedon) as insertedon, count(*) as records from rcbill.client_match_name
group by 1
order by 1 desc
;

-- select * from rcbill.client_match_name;



/*

SET SQL_SAFE_UPDATES = 0;
delete from rcbill.rcb_mxk where date(insertedon)='2018-10-13';

delete from rcbill.rcb_mxk 
where mxk_interface in ('','==========','====================','CPEs','Interface','ONUs','Serial','13','14');


*/