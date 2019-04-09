-- select distinct period from rcbill_my.rep_activenumberlastday;
-- select * from rcbill_my.rep_activenumberlastday;
-- select * from rcbill_my.rep_activenumberlastday_pv;
-- set @period='2018-01-31';
-- set @period='2018-02-28';
-- set @period='2018-03-31';
-- set @period='2018-04-30';
-- set @period='2018-05-31';
-- set @period='2018-06-30';
-- set @period='2018-07-31';
-- set @period='2018-08-31';
-- set @period='2018-09-30';
-- set @period='2018-10-31';
-- set @period='2018-11-30';
-- set @period='2018-12-31';
-- set @period='2019-01-31';
-- set @period='2019-02-28';
 set @period='2019-03-31';

select servicecategory, package, `20181031`, `20181130`, `20181231`, `20190131`, `20190228`, `20190331` from rcbill_my.rep_activenumberlastday_pv;

/*
select * from rcbill_my.customercontractactivity 
where period=@period and REPORTED='Y'
and package in ('Extravagance','Extravagance Corporate','French')
order by clientcode
;

select clientcode, clientclass, group_concat(package separator '|') as package, count(*) 
from rcbill_my.customercontractactivity 
where period=@period and REPORTED='Y'
and package in ('Extravagance','Extravagance Corporate','French')
group by clientcode, clientclass
order by 4 desc
;
*/



select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity
    where period=@period and REPORTED='Y'
	and package in ('Extravagance','Extravagance Corporate','French')
	group by clientcode, clientclass
	order by 4 desc

) a 
where 
-- package like '%|%'
upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%'
;


/*
select * from rcbill_my.customercontractactivity 
where period=@period and REPORTED='Y'
and package in ('Extravagance','Extravagance Corporate','Indian','Indian Corporate')
order by clientcode
;

select clientcode, clientclass, group_concat(package separator '|') as package, count(*) 
from rcbill_my.customercontractactivity 
where period=@period and REPORTED='Y'
and package in ('Extravagance','Extravagance Corporate','Indian','Indian Corporate')
group by clientcode, clientclass
order by 4 desc
;
*/

select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	and package in ('Extravagance','Extravagance Corporate','Indian','Indian Corporate')
	group by clientcode, clientclass
	order by 4 desc

) a 
where 
-- package like '%|%'
upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%INDIAN%'
;


select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	and package in ('Extravagance','Extravagance Corporate','French','Indian','Indian Corporate')
	group by clientcode, clientclass
	order by 4 desc

) a 
where 
upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;

/*
DTV customers
*/

select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	-- and package in ('Extravagance','Extravagance Corporate','French','Indian','Indian Corporate')
	and servicecategory='TV' and Network='HFC' and servicesubcategory<>'ADDON'
    group by clientcode, clientclass
	order by 4 desc

) a 
where 0=0 
-- upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;


/*
IPTV customers
*/

select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	-- and package in ('Extravagance','Extravagance Corporate','French','Indian','Indian Corporate')
	and servicecategory='TV' and Network='GPON' and servicesubcategory<>'ADDON'
    group by clientcode, clientclass
	order by 4 desc

) a 
where 0=0 
-- upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;