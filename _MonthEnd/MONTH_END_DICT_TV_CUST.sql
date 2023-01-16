


call rcbill_my.sp_filllastdates('2016-05-31',DATE_SUB(date(NOW()), INTERVAL 1 DAY));
call rcbill_my.sp_fillalldates('2016-05-01',DATE_SUB(date(NOW()), INTERVAL 1 DAY));



##################
##### PART 1 #####
##################


select servicecategory, package
-- , `20181031`, `20181130`, `20181231`
-- , `20161130`
-- , `20161231`
-- , `20190131`, `20190228`, `20190331`
-- , `20190430`, `20190531`, `20190630`
-- , `20190731`, `20190831`, `20190930`
-- , `20191031`, `20191130`, `20191231`
-- , `20200131`, `20200229`, `20200331`
-- , `20200430`, `20200531`, `20200630`
-- , `20200731`, `20200831`, `20200930`
-- , `20201031`, `20201130`, `20201231`
-- , `20210131`, `20210228`, `20210331`
-- , `20210430`, `20210531`, `20210630`
-- , `20210731`, `20210831`, `20210930`
-- , `20211031`, `20211130`, `20211231`
-- , `20220131`, `20220228`, `20220331`
-- , `20220430`, `20220531`, `20220630`
-- , `20220731`, `20220831`, `20220930`
, `20221031`, `20221130`, `20221231`
, `20230131`, `20230228`, `20230331`

 from rcbill_my.rep_activenumberlastday_pv;

select servicecategory
/*
, sum(`20161231`)
, sum(`20171231`)
, sum(`20181231`)
, sum(`20191231`)
, sum(`20201231`)
, sum(`20210131`)
, sum(`20210228`)
, sum(`20210331`)
, sum(`20210430`)
, sum(`20210531`)
, sum(`20210630`)
, sum(`20210731`)
, sum(`20210831`)
, sum(`20210930`)
, sum(`20211031`)
, sum(`20211130`)
, sum(`20211231`)
, sum(`20220131`)
, sum(`20220228`)
, sum(`20220331`)
, sum(`20220430`)
, sum(`20220531`)
, sum(`20220630`)
, sum(`20220731`)
, sum(`20220831`)
, sum(`20220930`)
*/
, sum(`20221031`)
, sum(`20221130`)
, sum(`20221231`)

, sum(`20230131`)
, sum(`20230228`)
, sum(`20230331`)


 from rcbill_my.rep_activenumberlastday_pv
 group by servicecategory
 ;


##################
##### PART 2 #####
##################



-- set @period='2022-04-30';
-- set @period='2022-05-31';
-- set @period='2022-06-30';
-- set @period='2022-07-31';
-- set @period='2022-08-31';
-- set @period='2022-09-30';
-- set @period='2022-10-31';
-- set @period='2022-11-30';
-- set @period='2022-12-31';
 set @period='2023-01-31';
-- set @period='2023-02-28';
-- set @period='2023-03-31';


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
	and clientclass in ('Corporate Large','Corporate Lite','USD_standard','Intelvision Office')
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



set @message = 'INTERNET - HFC';
select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	-- and package in ('Extravagance','Extravagance Corporate','French','Indian','Indian Corporate')
	and servicecategory='INTERNET'
    and Network='HFC'
    group by clientcode, clientclass
	order by 4 desc

) a 
where 0=0 
-- upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;


set @message = 'INTERNET - GPON';
select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	-- and package in ('Extravagance','Extravagance Corporate','French','Indian','Indian Corporate')
	and servicecategory='INTERNET'
    and Network='GPON'
    group by clientcode, clientclass
	order by 4 desc

) a 
where 0=0 
-- upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;



/*
VOICE customers
*/

set @message = 'VOICE - ALL';
select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	-- and clientclass in ('Residential','VIP','Standing Order','Employee','Prepaid','Corporate Bundle','Corporate Bulk','Corporate')
	and servicecategory='VOICE'
    group by clientcode, clientclass
	order by 4 desc

) a 
where 0=0 
-- upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;


set @message = 'VOICE - MAHE';
select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	-- and clientclass in ('Residential','VIP','Standing Order','Employee','Prepaid','Corporate Bundle','Corporate Bulk','Corporate')
	and servicecategory='VOICE'
    and region = 'MAHE'
    group by clientcode, clientclass
	order by 4 desc

) a 
where 0=0 
-- upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;




set @message = 'VOICE - PRASLIN';
select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	-- and clientclass in ('Residential','VIP','Standing Order','Employee','Prepaid','Corporate Bundle','Corporate Bulk','Corporate')
	and servicecategory='VOICE'
    and region = 'PRASLIN'
    group by clientcode, clientclass
	order by 4 desc

) a 
where 0=0 
-- upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;

set @message = 'VOICE - RESIDENTIAL';
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

set @message = 'VOICE - BUSINESS';
select @period AS period, clientcode, clientclass, package, subscriptions
from 
(
	select clientcode, clientclass, group_concat(package order by package separator '|') as package, count(*) as subscriptions
    from rcbill_my.customercontractactivity 
    where period=@period and REPORTED='Y'
	and clientclass in ('Corporate Large','Corporate Lite','USD_standard','Intelvision Office')
	and servicecategory='VOICE'
    group by clientcode, clientclass
	order by 4 desc

) a 
where 0=0 
-- upper(package) like '%EXTRAVAGANCE%' and upper(package) like '%FRENCH%' and upper(package) like '%INDIAN%'
;



##################################################

/*
select period, network, count(distinct clientcode) as d_client, sum(activecount) as active from rcbill_my.customercontractactivity 
where 
-- period in ('2020-07-31','2020-08-31','2020-09-30','2020-10-31','2020-11-30','2020-12-31','2021-01-31','2021-02-28','2021-03-31') 
period in (select month_last_date from rcbill_my.month_last_date where year(month_last_date)>2020) 
and REPORTED='Y'
-- and Network='GPON'
group by period, network
order by period, network
;

select period, network, servicecategory, count(distinct clientcode) as d_client, sum(activecount) as active from rcbill_my.customercontractactivity 
where 
-- period in ('2020-07-31','2020-08-31','2020-09-30','2020-10-31','2020-11-30','2020-12-31','2021-01-31','2021-02-28','2021-03-31') 
period in (select month_last_date from rcbill_my.month_last_date where year(month_last_date)>2020) 
and REPORTED='Y'
-- and Network='GPON'
group by period, network, servicecategory
order by period, network, servicecategory
;
*/


-- select clientclass, count(clientcode) from rcbill_my.customercontractactivity where period=@period and REPORTED='Y' group by clientclass;