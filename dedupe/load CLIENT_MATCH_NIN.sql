-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20181225.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20181228.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20190209.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20190323.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20190414.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20190518.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20190728.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20191014.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20200110.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20200315.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20200627.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20200719.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20220908.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20220910.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20220924.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20221001.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20221008.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20221022.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20221105.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20221119.csv' 


REPLACE INTO TABLE `rcbill`.`client_match_nin` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
 IGNORE 1 LINES 
(
@client_code1 ,
@client_name1 ,
@client_nin1 ,
@client_code2 ,
@client_name2 ,
@client_nin2 ,
@match_score  

) 
set 
CLIENT_CODE=@client_code1 ,
CLIENT_NAME=UPPER(TRIM(@client_name1)) ,
CLIENT_NIN=UPPER(TRIM(@client_nin1)) ,
M_CLIENT_CODE=@client_code2 ,
M_CLIENT_NAME=UPPER(TRIM(@client_name2)) ,
M_CLIENT_NIN=UPPER(TRIM(@client_nin2)) ,
M_SCORE=@match_score ,

INSERTEDON=now()

;

-- update rcbill.rcb_cmts
-- set mac_address_clean = 

select date(insertedon) as insertedon, count(*) as records from rcbill.client_match_nin
group by 1
order by 1 desc
;

-- select * from rcbill.client_match_nin;



/*

SET SQL_SAFE_UPDATES = 0;
delete from rcbill.rcb_mxk where date(insertedon)='2018-10-13';

delete from rcbill.rcb_mxk 
where mxk_interface in ('','==========','====================','CPEs','Interface','ONUs','Serial','13','14');


*/