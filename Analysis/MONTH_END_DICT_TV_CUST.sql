




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
-- set @period='2019-03-31';
-- set @period='2019-04-30';
-- set @period='2019-05-31';
-- set @period='2019-06-30';
-- set @period='2019-07-31';
-- set @period='2019-08-31';
-- set @period='2019-09-30';
 set @period='2019-10-31';
-- set @period='2019-11-30';
-- set @period='2019-12-31';

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

select servicecategory, package
-- , `20181031`, `20181130`, `20181231`
, `20190131`, `20190228`, `20190331`
, `20190430`, `20190531`, `20190630`
, `20190731`, `20190831`, `20190930`
, `20191031`, `20191130`, `20191231`
 from rcbill_my.rep_activenumberlastday_pv;



set @message = 'EXTRA + INDIAN';
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


set @message = 'EXTRA + FRENCH';
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


set @message = 'EXTRA + INDIAN + FRENCH';
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
IPTV customers
*/

set @message = 'IPTV';
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


/*
DTV customers
*/

set @message = 'DTV';
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
INTERNET customers
*/

set @message = 'INTERNET';
select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	-- and package in ('Extravagance','Extravagance Corporate','French','Indian','Indian Corporate')
	and servicecategory='INTERNET'
    group by clientcode, clientclass
	order by 4 desc

) a 
where 0=0 
-- upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;

/*
INTERNET customers - Business
*/

set @message = 'INTERNET - BUSINESS';
select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	and clientclass in ('Corporate Large','Corporate Lite','USD_standard')
	and servicecategory='INTERNET'
    group by clientcode, clientclass
	order by 4 desc

) a 
where 0=0 
-- upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;


/*
INTERNET customers - Business
*/

set @message = 'INTERNET - RESIDENTIAL';
select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	and clientclass in ('Residential','VIP','Standing Order','Employee','Prepaid','Corporate Bundle','Corporate Bulk','Corporate')
	and servicecategory='INTERNET'
    group by clientcode, clientclass
	order by 4 desc

) a 
where 0=0 
-- upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;


/*
VOICE customers
*/

set @message = 'VOICE';
select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	and clientclass in ('Residential','VIP','Standing Order','Employee','Prepaid','Corporate Bundle','Corporate Bulk','Corporate')
	and servicecategory='VOICE'
    group by clientcode, clientclass
	order by 4 desc

) a 
where 0=0 
-- upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;