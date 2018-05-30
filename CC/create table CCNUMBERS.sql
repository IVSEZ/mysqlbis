use rcbill_my;


drop table if exists rcbill_my.lkpccnumbers;

create table rcbill_my.lkpccnumbers as 
(
select distinct ccnumber as CCNUMBER from rcbill_my.ccrota order by ccnumber

);

select * from lkpccnumbers;