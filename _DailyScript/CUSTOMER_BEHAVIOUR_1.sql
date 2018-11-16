use rcbill_my;
set @reportdate='2018-10-22';
SET @rundate='2018-10-22';

set @clientcode='I.000011750';
-- set @package

##########################
#1
#first get all the client, contracts and active dates



select *
-- , (DurationForContract-ActiveDaysForContract) as InActiveDaysForContract
-- , (ActiveDaysForContract/DurationForContract) as PercentActive
-- , (ifnull( ((DurationForContract-ActiveDaysForContract)/DurationForContract),0 )) as PercentInActive
from rcbill_my.customercontractsnapshot
-- where package in ('Amber','Amber Corporate')
where servicecategory='Internet'
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;


select count(distinct clientcode) as extravagancecust from rcbill_my.customercontractsnapshot where  package in ('Extravagance','Extravagance Corporate');
select count(distinct clientcode) as crimsoncust from rcbill_my.customercontractsnapshot where  package in ('Crimson','Crimson Corporate');
select count(distinct clientcode) as ambercust from rcbill_my.customercontractsnapshot where  package in ('Amber','Amber Corporate');

select count(distinct clientcode) as ambercust from rcbill_my.customercontractsnapshot where  package in ('Amber','Amber Corporate');


#AMBER CUSTOMERS
select *
from rcbill_my.customercontractsnapshot
where 
-- servicecategory='Internet'
-- and 
clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('Amber','Amber Corporate'))
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;


#CRIMSON CUSTOMERS
select *
from rcbill_my.customercontractsnapshot
where servicecategory='Internet'
and clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('Crimson','Crimson Corporate'))
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;

#EXTRAVAGANCE CUSTOMERS
select *
from rcbill_my.customercontractsnapshot
where servicecategory='TV' and PackageType='STANDALONE'
and clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('Extravagance','Extravagance Corporate'))
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;

#French CUSTOMERS - STANDALONE
select *
from rcbill_my.customercontractsnapshot
where servicecategory='TV' 
and PackageType='STANDALONE'
and package in ('French')
and CurrentStatus='Active'
and clientclass not in ('Employee','Intelvision Office')
and clientclass in ('Employee','Intelvision Office')
-- and clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('Indian','Indian Corporate'))
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;

#French CUSTOMERS - ADDON
select distinct(clientcode)
from rcbill_my.customercontractsnapshot
where servicecategory='TV' 
and PackageType='ADDON'
and package in ('French')
and CurrentStatus='Active'
and clientclass not in ('Employee','Intelvision Office')
and clientclass in ('Employee','Intelvision Office')
-- and clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('Indian','Indian Corporate'))
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;


#Indian CUSTOMERS - STANDALONE
select 
-- *
distinct clientcode
from rcbill_my.customercontractsnapshot
where servicecategory='TV' 
and PackageType='STANDALONE'
and package in ('Indian','Indian Corporate')
and CurrentStatus='Active'
and clientclass not in ('Employee','Intelvision Office')
-- and clientclass not in ('Employee','Intelvision Office')
-- and clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('Indian','Indian Corporate'))
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;

#Indian CUSTOMERS - ADDON
select 
-- *
distinct clientcode
from rcbill_my.customercontractsnapshot
where servicecategory='TV' 
and PackageType='ADDON'
and package in ('Indian','Indian Corporate')
and CurrentStatus='Active'
and clientclass not in ('Employee','Intelvision Office')
-- and clientclass not in ('Employee','Intelvision Office')
-- and clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('Indian','Indian Corporate'))
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;



#####################################################################

select 
*
-- , min(firstcontractdate) as contractstart, max(lastcontractdate) as contractend
-- distinct clientcode
from rcbill_my.customercontractsnapshot
where 
 servicecategory in ('TV','OTT') 
-- and PackageType='ADDON'
-- and package in ('Indian','Indian Corporate')
-- and CurrentStatus='Active'
-- and clientclass not in ('Employee','Intelvision Office')
-- and clientclass not in ('Employee','Intelvision Office')
 and 
clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('DUALVIEW'))
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;

select * from rcbill_my.customercontractactivity where clientcode='I.000013003';



#####################################################################

-- I.000015232
select *
from rcbill_my.customercontractsnapshot
where clientcode=@clientcode
and servicecategory='Internet'
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;

select * from rcbill_my.clientstats ;

