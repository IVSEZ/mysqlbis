use rcbill_my;


drop table if exists rcbill_my.lkpccagents;

create table rcbill_my.lkpccagents as 
(
select distinct upper(trim(CCAGENT)) as CCAGENT from rcbill_my.ccrota order by ccagent

);

select * from lkpccagents;
-- SET SQL_SAFE_UPDATES=0;
-- delete from rcbill_my.lkpccagents where CCAGENT='Kiren/faulty'