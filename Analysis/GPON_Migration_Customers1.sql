#HFC to GPON migration accounts

select count(*) from rcbill_my.customercontractsnapshot;

select * from rcbill_my.customercontractsnapshot limit 100;

select distinct network from rcbill_my.customercontractsnapshot;


select * from rcbill_my.customercontractsnapshot where network='GPON';
select * from rcbill_my.customercontractsnapshot where network='HFC';

select clientcode, clientclass, network, servicecategory, servicecategory2
, min(firstcontractdate) as firstcontractdate, max(lastcontractdate) as lastcontractdate
, sum(durationforcontract) as durationforcontract, sum(ActiveDaysForContract) as ActiveDaysForContract
from rcbill_my.customercontractsnapshot 
-- where network='GPON'
group by clientcode, clientclass, network, servicecategory, servicecategory2
order by 6 asc
;


select * from rcbill_my.customercontractsnapshot where network='MOBILE TV';
select * from rcbill_my.customercontractsnapshot where network='ADDON';

select * from rcbill_my.customercontractsnapshot where package='iGO' and network='HFC';

select * from rcbill_my.customercontractsnapshot 
where 
clientcode in 
(
select distinct clientcode from rcbill_my.customercontractsnapshot where network in ('GPON','HFC') and clientclass='Residential'
)
order by clientcode, firstcontractdate, lastcontractdate;

select distinct clientcode from rcbill_my.customercontractsnapshot where network='GPON';
select distinct clientcode from rcbill_my.customercontractsnapshot where network='HFC';

select * from rcbill_my.rep_custconsolidated where connection_type like '%HFC|GPON%' or ;
select * from rcbill_my.rep_custconsolidated where connection_type like '%GPON|HFC%';

/*
select * from rcbill_my.customercontractsnapshot where clientcode='I.000019753' order by lastcontractdate asc;

select * from rcbill_my.customercontractactivity where clientcode='I.000019753';

-- select rcbill_my.GetNetwork(@rundate, a.contractcode);
select rcbill_my.GetNetwork('2019-05-18', 'I.000358178');

select * from rcbill_my.dailyactivenumber where CONTRACTCODE='I.000358178' and PERIOD='2019-05-17';

select servicesubcategory from rcbill_my.lkpbaseservice where service='Subscription Intelenovela';
*/

