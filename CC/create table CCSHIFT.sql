use rcbill_my;


drop table if exists rcbill_my.lkpccshift;

create table rcbill_my.lkpccshift as 
(
select distinct ccshift as CCSHIFT from rcbill_my.ccrota order by ccshift

);

select * from lkpccshift;