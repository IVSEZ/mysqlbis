show columns from rcbill_my.rep_cust_cont_payment_cmts_mxk;
show columns from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail;
 
### GET CMTS MXK REPORT

use rcbill_my;
/*
ALTER table rcbill_my.rep_cust_cont_payment_cmts_mxk_trail
    Add column packageinfo text AFTER nodename;
    
ALTER table rcbill_my.rep_cust_cont_payment_cmts_mxk_trail
	Drop column services;
ALTER table rcbill_my.rep_cust_cont_payment_cmts_mxk_trail
	Drop column network;
*/


## RUN THIS ONLY AFTER THE CMTS AND MXK HAVE BEEN UPDATED and REVENUE_PER_NODE_MXK has been run
/*
insert into rcbill_my.rep_cust_cont_payment_cmts_mxk_trail
select * from rcbill_my.rep_cust_cont_payment_cmts_mxk
;

select * from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail;

*/

## UPDATED for 2019 table
/*
-- FIRST TIME create table rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2 as (select * from rcbill_my.rep_cust_cont_payment_cmts_mxk);

insert into rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2
select * from rcbill_my.rep_cust_cont_payment_cmts_mxk
;

select * from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2;


*/


## UPDATED for 2020 table
/*
-- FIRST TIME drop table if exists rcbill_my.rep_cust_cont_payment_cmts_mxk_trail3; create table rcbill_my.rep_cust_cont_payment_cmts_mxk_trail3 as (select * from rcbill_my.rep_cust_cont_payment_cmts_mxk);

insert into rcbill_my.rep_cust_cont_payment_cmts_mxk_trail3
select * from rcbill_my.rep_cust_cont_payment_cmts_mxk
;

select * from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail3;


*/

########################### CHANGE COLLATION and CHARACTER_SET
/*
SELECT table_schema, table_name, column_name, character_set_name, collation_name
FROM information_schema.columns
where table_name like 'rep_cust_cont_payment_cmts_mxk_trail%'
-- WHERE collation_name = 'latin1_general_ci'
ORDER BY table_schema, table_name,ordinal_position; 


ALTER TABLE rep_cust_cont_payment_cmts_mxk_trail CONVERT TO CHARACTER SET utf8 COLLATE 'utf8_general_ci';

ALTER TABLE rep_cust_cont_payment_cmts_mxk_trail2 CONVERT TO CHARACTER SET utf8 COLLATE 'utf8_general_ci';

*/
###########################


select *
from rcbill_my.rep_cust_cont_payment_cmts_mxk 
where firstactivedate is not null and lastactivedate is not null
order by clientcode
;

select reportdate
-- , network
, clean_connection_type, clean_hfc_nodename, clean_mxk_name, count(*) as recordcount, count(distinct clientcode) as distinctclients from 
rcbill_my.rep_cust_cont_payment_cmts_mxk_trail3
group by 1,2,3, 4 -- , 5
order by reportdate desc
;

select reportdate
-- , network
, clean_connection_type, clean_hfc_nodename, clean_mxk_name, count(*) as recordcount, count(distinct clientcode) as distinctclients from 
rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2
group by 1,2,3, 4 -- , 5
order by reportdate desc
;

select reportdate
-- , network
, clean_connection_type, clean_hfc_nodename, clean_mxk_name, count(*) as recordcount, count(distinct clientcode) as distinctclients from 
rcbill_my.rep_cust_cont_payment_cmts_mxk_trail
group by 1,2,3, 4 -- , 5
order by reportdate desc
;

/*
select reportdate
-- , network
, clean_connection_type, clean_hfc_nodename, clean_mxk_name, count(distinct clientcode) as distinctclients from 
rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2
where firstactivedate is not null and lastactivedate is not null
group by 1,2,3, 4 -- , 5
order by reportdate desc
;

select reportdate
-- , network
, clean_connection_type, clean_hfc_nodename, clean_mxk_name, count(distinct clientcode) as distinctclients from 
rcbill_my.rep_cust_cont_payment_cmts_mxk_trail
where firstactivedate is not null and lastactivedate is not null
group by 1,2,3, 4 -- , 5
order by reportdate desc
;
*/
#########

drop table if exists rcbill_my.rep_cmtsmxk_trail;

create table rcbill_my.rep_cmtsmxk_trail
as
(
select reportdate
-- , network
, clean_connection_type, clean_hfc_nodename, clean_mxk_name, count(distinct clientcode) as distinctclients 
, sum(activecontracts) as activecontracts
from 
rcbill_my.rep_cust_cont_payment_cmts_mxk_trail3
where firstactivedate is not null and lastactivedate is not null
and lastactivedate=reportdate
group by 1,2,3, 4 -- , 5
order by reportdate desc
) 
union
(
select reportdate
-- , network
, clean_connection_type, clean_hfc_nodename, clean_mxk_name, count(distinct clientcode) as distinctclients 
, sum(activecontracts) as activecontracts
from 
rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2
where firstactivedate is not null and lastactivedate is not null
and lastactivedate=reportdate
group by 1,2,3, 4 -- , 5
order by reportdate desc
) 
union
(
select reportdate
-- , network
, clean_connection_type, clean_hfc_nodename, clean_mxk_name, count(distinct clientcode) as distinctclients 
, sum(activecontracts) as activecontracts

from 
rcbill_my.rep_cust_cont_payment_cmts_mxk_trail
where firstactivedate is not null and lastactivedate is not null
and lastactivedate=reportdate
group by 1,2,3, 4 -- , 5
order by reportdate desc
)
;

#ALL STATS FROM CMTSMXK TRAIL TABLE
select * from rcbill_my.rep_cmtsmxk_trail order by reportdate desc;
select * from rcbill.rcb_techregions;

select a.*, ifnull(b.district,a.clean_hfc_nodename) as district from rcbill_my.rep_cmtsmxk_trail a 
left join 
-- rcbill.rcb_techregions 
(
select distinct nodename, district from rcbill.rcb_techregions
)
b 
on a.clean_hfc_nodename=b.nodename 
order by a.reportdate desc;

#ONLY HFC TV CUSTOMERS
select * from rcbill_my.rep_cmtsmxk_trail 
where clean_connection_type is null and clean_hfc_nodename is null and clean_mxk_name is null
order by reportdate desc;

select * from rcbill_my.rep_cmtsmxk_trail 
where clean_connection_type = 'GPON' and clean_hfc_nodename is NOT null
order by reportdate desc;

select * from rcbill_my.rep_cmtsmxk_trail 
where clean_connection_type = 'GPON' and clean_hfc_nodename is null and clean_mxk_name is null
order by reportdate desc;


select HFC_NODE, NODENAME, CMTS_DATE, date(INSERTEDON) as INSERTED_ON
, count(distinct CLIENT_CODE) as UNIQUE_ACCOUNTS, count(distinct CONTRACT_CODE) as UNIQUE_CONTRACTS
, count(distinct MAC) as UNIQUE_MAC_INRCBOSS, count(distinct MAC_ADDRESS) as UNIQUE_MAC_INCMTS
from rcbill_my.customers_cmts
group by HFC_NODE, NODENAME, CMTS_DATE, date(INSERTEDON)
order by HFC_NODE
;

select MXK_NAME, MXK_DATE, date(INSERTEDON) as INSERTED_ON
, count(distinct CLIENT_CODE) as UNIQUE_ACCOUNTS, count(distinct CONTRACT_CODE) as UNIQUE_CONTRACTS
, count(distinct FSAN2) as UNIQUE_FSAN_INRCBOSS, count(distinct SERIAL_NUM2) as UNIQUE_FSAN_INMXK
from rcbill_my.customers_mxk
group by MXK_NAME, MXK_DATE, date(INSERTEDON)
order by MXK_NAME
;

-- select * from rcbill_my.customers_mxk;
/*
select distinct client_code from rcbill_my.customers_mxk where mxk_name='MXK-ANSEETOILE';
*/

 set @mxkname='MXK-BEAUVALLON';
-- set @mxkname='MXK-MAHE';
-- set @mxkname='MXK-ANSEETOILE';
-- set @mxkname='MXK-ANSEROYALE';
-- set @mxkname='MXK-PERSEVERANCE';
-- set @mxkname='MXK-PRASLIN';


select * from rcbill_my.rep_cmtsmxk_trail 
where 0=0 
and clean_connection_type = 'GPON' 
and clean_hfc_nodename is null
-- and
-- (clean_mxk_name = @mxkname or clean_mxk_name is null)
order by clean_mxk_name asc, reportdate desc;

#########

select * from rcbill_my.rep_cmtsmxk_trail
where 0=0
and (clean_connection_type is null or clean_connection_type='HFC')
and clean_mxk_name is null
order by clean_hfc_nodename asc, clean_connection_type asc, reportdate desc;

#########




select HFC_NODE, NODENAME, CMTS_DATE, date(INSERTEDON) as INSERTED_ON
, count(distinct CLIENT_CODE) as UNIQUE_ACCOUNTS, count(distinct CONTRACT_CODE) as UNIQUE_CONTRACTS
, count(distinct MAC) as UNIQUE_MAC_INRCBOSS, count(distinct MAC_ADDRESS) as UNIQUE_MAC_INCMTS
from rcbill_my.customers_cmts
group by HFC_NODE, NODENAME, CMTS_DATE, date(INSERTEDON)
order by HFC_NODE
;

select MXK_NAME, MXK_DATE, date(INSERTEDON) as INSERTED_ON
, count(distinct CLIENT_CODE) as UNIQUE_ACCOUNTS, count(distinct CONTRACT_CODE) as UNIQUE_CONTRACTS
, count(distinct FSAN2) as UNIQUE_FSAN_INRCBOSS, count(distinct SERIAL_NUM2) as UNIQUE_FSAN_INMXK
from rcbill_my.customers_mxk
group by MXK_NAME, MXK_DATE, date(INSERTEDON)
order by MXK_NAME
;








/*
select * from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail
where 
reportdate='2018-12-19' and
clean_mxk_name is null and clean_connection_type='GPON'
;

select *, year(firstactivedate) as firstactiveyear, month(firstactivedate) as firstactivemonth
, year(lastactivedate) as lastactiveyear, month(lastactivedate) as lastactivemonth 
from rcbill_my.rep_cust_cont_payment_cmts_mxk 
where 
mxk_name like '%MXK-BEAUVALLON%'
-- clean_mxk_name='MXK-BEAUVALLON' 
;


*/

select * from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2
where 0=0
and clean_connection_type is null and clean_hfc_nodename is null
and lastactivedate=reportdate

order by clientcode
order by reportdate desc;

select * from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail;

set sql_safe_updates=0;


/*
alter table rep_cust_cont_payment_cmts_mxk_trail
change reportdate reportdate date
;
alter table rep_cust_cont_payment_cmts_mxk_trail
change firstactivedate firstactivedate date
;
alter table rep_cust_cont_payment_cmts_mxk_trail
change lastactivedate lastactivedate date
;
*/

-- update rcbill_my.rep_cust_cont_payment_cmts_mxk_trail 
-- set combined_clientcode=NULL where combined_clientcode='NULL'
-- set cl_clientcode=NULL where cl_clientcode='NULL'
-- set b_clientcode=NULL where b_clientcode='NULL'
-- set connection_type=NULL where connection_type='NULL'
-- set mxk_name=NULL where mxk_name='NULL'
-- set mxk_interface=NULL where mxk_interface='NULL'
-- set hfc_node=NULL where hfc_node='NULL'
-- set nodename=NULL where nodename='NULL'
-- set nodename=NULL where nodename='NULL'
-- set clean_mxk_name=NULL where clean_mxk_name='NULL'
-- set clean_mxk_interface=NULL where clean_mxk_interface='NULL'
-- set clean_hfc_node=NULL where clean_hfc_node='NULL'
-- set clean_hfc_nodename=NULL where clean_hfc_nodename='NULL'
-- set clean_connection_type=NULL where clean_connection_type='NULL'
-- set firstactivedate=NULL where firstactivedate='0000-00-00'
-- set lastactivedate=NULL where lastactivedate='0000-00-00'
;
