

### GET CMTS MXK REPORT

use rcbill_my;
## RUN THIS ONLY AFTER THE CMTS AND MXK HAVE BEEN UPDATED 
/*
insert into rep_cust_cont_payment_cmts_mxk_trail
select * from rep_cust_cont_payment_cmts_mxk
;

select * from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail;

*/


select *
from rcbill_my.rep_cust_cont_payment_cmts_mxk 
where firstactivedate is not null and lastactivedate is not null
order by clientcode
;



select reportdate, network, clean_connection_type, clean_hfc_nodename, clean_mxk_name, count(*) as recordcount, count(distinct clientcode) as distinctclients from 
rcbill_my.rep_cust_cont_payment_cmts_mxk_trail
group by 1,2,3, 4, 5
;

select reportdate, network, clean_connection_type, clean_hfc_nodename, clean_mxk_name, count(distinct clientcode) as distinctclients from 
rcbill_my.rep_cust_cont_payment_cmts_mxk_trail
where firstactivedate is not null and lastactivedate is not null
group by 1,2,3, 4, 5
;









/*
select *, year(firstactivedate) as firstactiveyear, month(firstactivedate) as firstactivemonth
, year(lastactivedate) as lastactiveyear, month(lastactivedate) as lastactivemonth 
from rcbill_my.rep_cust_cont_payment_cmts_mxk 
where 
mxk_name like '%MXK-BEAUVALLON%'
-- clean_mxk_name='MXK-BEAUVALLON' 
;


*/

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
