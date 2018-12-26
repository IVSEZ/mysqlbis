-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\_out\\cust_nin_score_20181225.csv' 
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

select date(insertedon) as insertedon, count(*) as records from rcbill.client_match_nin;

-- select * from rcbill.client_match_nin;



/*

SET SQL_SAFE_UPDATES = 0;
delete from rcbill.rcb_mxk where date(insertedon)='2018-10-13';

delete from rcbill.rcb_mxk 
where mxk_interface in ('','==========','====================','CPEs','Interface','ONUs','Serial','13','14');


*/