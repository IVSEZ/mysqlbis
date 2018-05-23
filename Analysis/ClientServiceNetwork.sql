use rcbill_my;
SET @rundate='2017-12-26';

/*
select * from rcbill_my.anreport;

select * from rcbill_my.customercontractactivity 
where period=@rundate and reported='Y'
;

select * from rcbill.clientcontractdiscounts;


select a.*,b.percent,b.amount,b.servicename 
from rcbill_my.customercontractactivity a 
inner join 
rcbill.clientcontractdiscounts b 
on 
a.clientcode=b.clientcode and a.contractcode=b.contractcode
where a.period=@rundate and a.reported='Y'
;


select * from rcbill_my.dailyactivenumber 
where period=@rundate and reported='Y'
;

select distinct package from rcbill_my.customercontractactivity 
where period=@rundate and reported='Y'
order by package
;


select clientcode, contractcode, clientname, clientclass, clienttype, region, servicecategory
, count(*)
-- servicesubcategory, 
, GetNetwork(@rundate,contractcode) as Network
from rcbill_my.customercontractactivity 
where period=@rundate
group by clientcode, contractcode, clientname, clientclass, clienttype, region, servicecategory, GetNetwork(@rundate,contractcode)
order by clientname
;
*/

drop table if exists rcbill_my.clientnetworkservicepkg;
create table rcbill_my.clientnetworkservicepkg as
(
select a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, a.service
, a.network, a.package, a.servicecategory
,a.contractcode
, count(distinct a.period) as ServiceCount, sum(distinct a.ACTIVECOUNT) as ActiveCount
from rcbill_my.customercontractactivity a
where a.period=@rundate and a.reported='Y'
group by 1,2,3,4,5,6,7,8,9,10,11
order by a.clientname

/*
select a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, trim(upper(b.Service)) as Service
, GetNetwork(@rundate,a.contractcode) as Network, a.package, a.servicecategory
,a.contractcode
, count(distinct a.period) as ServiceCount, sum(distinct a.ACTIVECOUNT) as ActiveCount
from rcbill_my.customercontractactivity a
inner join
rcbill_my.dailyactivenumber b
on a.clientcode=b.clientcode and a.contractcode=b.contractcode and a.period=b.period and a.package=b.servicetype
where a.period=@rundate and a.reported='Y'
group by a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, 7, 8, a.package, a.servicecategory
,a.contractcode
order by a.clientname
*/

/*

select tb1.*, trim(upper(tb2.Service)) as Service
from 
(
select a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region
,a.network
, a.package, a.servicecategory
,a.contractcode
, count(a.period) as ServiceCount, sum(a.ACTIVECOUNT) as ActiveCount
from rcbill_my.customercontractactivity a

where a.period=@rundate and a.reported='Y'
group by a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, 7, a.package, a.servicecategory
,a.contractcode
order by a.clientname

) tb1
inner join 
(
select clientcode,contractcode,period,servicetype,service from rcbill_my.dailyactivenumber 
where period=@rundate and reported='Y' 
) tb2
on
tb1.clientcode=tb2.clientcode and tb1.contractcode=tb2.contractcode 
and tb1.period=tb2.period 
and tb1.package=tb2.servicetype
;


-- select service from rcbill_my.dailyactivenumber where clientcode='I9987' and contractcode='I37042.1' and servicetype='Intel Voice 10' and period='2017-10-07' and reported='Y';

select a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region
, a.network, a.package, a.servicecategory
,a.contractcode
, count(a.period) as ServiceCount, sum(a.ACTIVECOUNT) as ActiveCount
from rcbill_my.customercontractactivity a

where a.period=@rundate and a.reported='Y'
group by a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, 7, a.package, a.servicecategory
,a.contractcode
order by a.clientname



select a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region
, GetNetwork(@rundate,a.contractcode) as Network, a.package, a.servicecategory
,a.contractcode
, count(a.period) as ServiceCount, sum(a.ACTIVECOUNT) as ActiveCount
from rcbill_my.customercontractactivity a

where a.period=@rundate and a.reported='Y'
group by a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, 7, a.package, a.servicecategory
,a.contractcode
order by a.clientname
*/
)
;



select * from rcbill_my.clientnetworkservicepkg;

/*
select clientcode, clientname, clientclass, clienttype, region, network, 
case when servicecategory='TV' then ServiceCount end as TV,
case when servicecategory='Internet' then ServiceCount end as Internet,
case when servicecategory='Voice' then ServiceCount end as Voice
from rcbill_my.clientnetworkservicepkg;
*/

drop table if exists rcbill_my.clientnetworkservicesum;

create table rcbill_my.clientnetworkservicesum as
(
select period, clientcode, clientname, clientclass, clienttype, region, network, sum(ActiveCount) as ActiveCount
,count(distinct contractcode) as contractcount,  ifnull(sum(tv),0) as tv, ifnull(sum(internet),0) as internet, ifnull(sum(voice),0) as voice
from 
(
select period, clientcode, clientname, clientclass, clienttype, region, network, ActiveCount, contractcode,
-- count(distinct contractcode) as contractcount,
case when servicecategory='TV' then ServiceCount end as TV,
case when servicecategory='Internet' then ServiceCount end as Internet,
case when servicecategory='Voice' then ServiceCount end as Voice
from rcbill_my.clientnetworkservicepkg
) cns
group by period, clientcode, clientname, clientclass, clienttype, region, network
);

select * from rcbill_my.clientnetworkservicesum;

-- select distinct package from rcbill_my.clientnetworkservicesum;


drop table if exists rcbill_my.clientnetworkservicestats;

create table rcbill_my.clientnetworkservicestats as
(
select period, clientcode, clientname, clientclass, clienttype, region, network, ActiveCount,contractcount,
case 
when tv>0 and internet>0 and voice>0 then 'All' 
when tv>0 and internet>0 and voice=0 then 'TV & Internet'
when tv>0 and internet=0 and voice=0 then 'TV Only'
when tv=0 and internet>0 and voice=0 then 'Internet Only'
when tv=0 and internet=0 and voice>0 then 'Voice Only'
when tv>0 and internet=0 and voice>0 then 'TV & Voice'
when tv=0 and internet>0 and voice>0 then 'Internet & Voice'
end as Services
from
rcbill_my.clientnetworkservicesum
)
;

select * from rcbill_my.clientnetworkservicestats;

/*
select a.clientcode, a.clientname, a.clientclass, b.package
from 
rcbill_my.clientnetworkservicestats a 
inner join 
rcbill_my.customercontractactivity b
on a.clientcode=b.clientcode
where 
a.services in ('TV & Internet','All')
and 
b.period=@rundate
;
*/

drop table if exists rcbill_my.clientpackagestats;

create table rcbill_my.clientpackagestats as
(

	select period, clientcode, clientname, region, network, 
	ifnull(sum(`10GB`),0) as `10GB`,
	ifnull(sum(`20GB`),0) as `20GB`,
	ifnull(sum(`40GB`),0) as `40GB`,
	ifnull(sum(`Basic`),0) as `Basic`,
	ifnull(sum(`Business Unlimited-1`),0) as `Business Unlimited-1`,
	ifnull(sum(`Business Unlimited-2`),0) as `Business Unlimited-2`,
	ifnull(sum(`Business Unlimited-6`),0) as `Business Unlimited-6`,
	ifnull(sum(`Business Unlimited-8`),0) as `Business Unlimited-8`,
	ifnull(sum(`Business Unlimited-8-daytime`),0) as `Business Unlimited-8-daytime`,
	ifnull(sum(Crimson),0) as `Crimson`,
	ifnull(sum(`Crimson Corporate`),0) as `Crimson Corporate`,
	ifnull(sum(`Dedicated Custom`),0) as `Dedicated Custom`,
	ifnull(sum(`Dedicated Plus`),0) as `Dedicated Plus`,
	ifnull(sum(Elite),0) as `Elite`,
	ifnull(sum(Executive),0) as `Executive`,
	ifnull(sum(Extravagance),0) as `Extravagance`,
	ifnull(sum(`Extravagance Corporate`),0) as `Extravagance Corporate`,
	ifnull(sum(Extreme),0) as `Extreme`,
	ifnull(sum(`Extreme Plus`),0) as `Extreme Plus`,
	ifnull(sum(French),0) as `French`,
	ifnull(sum(`Hotels/Channels`),0) as `Hotels/Channels`,
	ifnull(sum(`Hotels/Decoder`),0) as `Hotels/Decoder`,
	ifnull(sum(Indian),0) as `Indian`,
	ifnull(sum(`Intel Data 10`),0) as `Intel Data 10`,
	ifnull(sum(`Intel Voice 10`),0) as `Intel Voice 10`,
	ifnull(sum(`Intel Voice 20`),0) as `Intel Voice 20`,
	ifnull(sum(Intelenovela),0) as `Intelenovela`,
	ifnull(sum(PBX),0) as `PBX`,
	ifnull(sum(Performance),0) as `Performance`,
	ifnull(sum(`Performance Plus`),0) as `Performance Plus`,
	ifnull(sum(Prepaid),0) as `Prepaid`,
	ifnull(sum(`Prepaid Data`),0) as `Prepaid Data`,
	ifnull(sum(Prestige),0) as `Prestige`,
	ifnull(sum(Starter),0) as `Starter`,
	ifnull(sum(`Turquoise High Tide`),0) as `Turquoise High Tide`,
	ifnull(sum(`Turquoise Low Tide`),0) as `Turquoise Low Tide`,
	ifnull(sum(TurquoiseTV),0) as `TurquoiseTV`,
	ifnull(sum(Value),0) as `Value`,
	ifnull(sum(`Voice Plus`),0) as `Voice Plus`,
	ifnull(sum(VPN),0) as `VPN`


	from 
	(
		select period, clientcode, clientname, region, network,
		case when package='10GB' then packagecount end as `10GB`,
		case when package='20GB' then packagecount end as `20GB`,
		case when package='40GB' then packagecount end as `40GB`,
		case when package='Basic' then packagecount end as `Basic`,
		case when package='Business Unlimited-1' then packagecount end as `Business Unlimited-1`,
		case when package='Business Unlimited-2' then packagecount end as `Business Unlimited-2`,
		case when package='Business Unlimited-6' then packagecount end as `Business Unlimited-6`,
		case when package='Business Unlimited-8' then packagecount end as `Business Unlimited-8`,
		case when package='Business Unlimited-8-daytime' then packagecount end as `Business Unlimited-8-daytime`,
		case when package='Crimson' then packagecount end as `Crimson`,
		case when package='Crimson Corporate' then packagecount end as `Crimson Corporate`,
		case when package='Dedicated Custom' then packagecount end as `Dedicated Custom`,
		case when package='Dedicated Plus' then packagecount end as `Dedicated Plus`,
		case when package='Elite' then packagecount end as `Elite`,
		case when package='Executive' then packagecount end as `Executive`,
		case when package='Extravagance' then packagecount end as `Extravagance`,
		case when package='Extravagance Corporate' then packagecount end as `Extravagance Corporate`,
		case when package='Extreme' then packagecount end as `Extreme`,
		case when package='Extreme Plus' then packagecount end as `Extreme Plus`,
		case when package='French' then packagecount end as `French`,
		case when package='Hotels/Channels' then packagecount end as `Hotels/Channels`,
		case when package='Hotels/Decoder' then packagecount end as `Hotels/Decoder`,
		case when package='Indian' then packagecount end as `Indian`,
		case when package='Intel Data 10' then packagecount end as `Intel Data 10`,
		case when package='Intel Voice 10' then packagecount end as `Intel Voice 10`,
		case when package='Intel Voice 20' then packagecount end as `Intel Voice 20`,
		case when package='Intelenovela' then packagecount end as `Intelenovela`,
		case when package='PBX' then packagecount end as `PBX`,
		case when package='Performance' then packagecount end as `Performance`,
		case when package='Performance Plus' then packagecount end as `Performance Plus`,
		case when package='Prepaid' then packagecount end as `Prepaid`,
		case when package='Prepaid Data' then packagecount end as `Prepaid Data`,
		case when package='Prestige' then packagecount end as `Prestige`,
		case when package='Starter' then packagecount end as `Starter`,
		case when package='Turquoise High Tide' then packagecount end as `Turquoise High Tide`,
		case when package='Turquoise Low Tide' then packagecount end as `Turquoise Low Tide`,
		case when package='TurquoiseTV' then packagecount end as `TurquoiseTV`,
		case when package='Value' then packagecount end as `Value`,
		case when package='Voice Plus' then packagecount end as `Voice Plus`,
		case when package='VPN' then packagecount end as `VPN`

		from 
		(
			/*
			select period, clientcode, clientname, package, region, GetNetwork(@rundate,contractcode) as network, count(*) as packagecount from rcbill_my.customercontractactivity where period=@rundate and clientcode in 
			(
            select clientcode from rcbill_my.clientnetworkservicestats 
            -- where services = 'TV & Internet' 
			-- and clienttype='Residential'
			) 
			group by period, clientcode, clientname, package, region, GetNetwork(@rundate,contractcode)
			order by clientcode
            */
            -- select * from rcbill_my.clientnetworkservicepkg
            
            select period, clientcode, clientname, package, region, network, count(*) as packagecount from rcbill_my.clientnetworkservicepkg where period=@rundate
            group by period, clientcode, clientname, package, region, network
			
        ) a
	) b 

	group by period, clientcode, clientname,region, network
	order by clientname

);

select * from rcbill_my.clientpackagestats;


/*
select * from rcbill_my.clientpackagestats where (`Extreme`>0 or `Extreme Plus`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0); 
select * from rcbill_my.clientpackagestats where (`Elite`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0); 
select * from rcbill_my.clientpackagestats where (`Performance`>0 or `Performance Plus`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0); 
*/

drop table if exists rcbill_my.clientstats;

create table rcbill_my.clientstats 
(INDEX idxcs1 (clientcode)) as
(
select 
-- a.period as a_period, a.clientcode as a_clientcode, a.clientname as a_clientname, a.region as a_region, a.network as a_network
-- , 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount
, b.* from
rcbill_my.clientnetworkservicestats a 
inner join
rcbill_my.clientpackagestats b
on 
a.clientcode=b.clientcode
and 
a.region=b.region
and
a.network=b.network
order by b.clientcode
)

;

select * from rcbill_my.clientstats;

/*
select count(*) as count, sum(activecount) as active, sum(contractcount) as contracts from rcbill_my.clientstats
where services='Internet Only'
 and region='Mahe' and network='HFC'
;

select services, count(*) as count, sum(activecount) as active, sum(contractcount) as contracts, count(distinct clientcode) as uniqueac from rcbill_my.clientstats
where 
-- services='Internet Only'
-- and 
 region='Mahe' and network='HFC'
 group by services
 with rollup
;
*/

/*
select distinct a_clientcode, count(*) as a_count
from rcbill_my.clientstats 
group by 1
order by 2 desc;

select * from rcbill_my.clientstats where network='ADDON';

select * from rcbill_my.clientstats where clientcode='I.000015676';
*/


			/*
            select cl_location, cl_latitude, cl_longitude, sum(accounts) as accounts
			from rcbill_my.activeccl_clsum
            group by cl_location, cl_latitude, cl_longitude
            with rollup;
            
            select * from rcbill_my.activeccl_clsum;
            select * from rcbill_my.activeccl;
            select * from rcbill_my.clientstats;
			select distinct clientcode, count(*) from rcbill_my.clientstats group by clientcode order by 2 desc;

			*/

select coalesce(services,"GRAND TOTAL") as services, sum(activecount) as activecount, count(clientcode) as allaccounts
, count(distinct clientcode) as uniqueaccounts 
, sum(contractcount) as uniquecontracts
from
rcbill_my.clientstats
group by services
 with rollup 
;

select coalesce(network,"GRAND TOTAL") as network, sum(activecount) as activecount, count(clientcode) as allaccounts, count(distinct clientcode) as uniqueaccounts
, sum(contractcount) as uniquecontracts
 from
rcbill_my.clientstats
group by network
 with rollup
;

select coalesce(network,"GRAND TOTAL") as network, coalesce(services,"Services Total") as services, sum(activecount) as activecount
, count(clientcode) as allaccounts, count(distinct clientcode) as uniqueaccounts 
, sum(contractcount) as uniquecontracts
from
rcbill_my.clientstats
group by network, services
 with rollup
;

select coalesce(region,"GRAND TOTAL") as region, coalesce(network,"Network Total") as network, coalesce(services,"Services Total") as services, sum(activecount) as activecount
, count(clientcode) as allaccounts, count(distinct clientcode) as uniqueaccounts 
, sum(contractcount) as uniquecontracts
from
rcbill_my.clientstats
group by region, network, services
 with rollup
;

##CREATE ACTIVE CUSTOMER CONTRACT DISCOUNTS
drop table if exists rcbill_my.activediscounts;
create table rcbill_my.activediscounts as
(
	select 
	tb1.*, tb2.clientid, tb2.contractid, tb2.serviceid,tb2.percent,tb2.amount,tb2.upddate,tb2.approved,tb2.approvalreason
	from 
	(
		select a.*, b.*
		from rcbill_my.clientnetworkservicepkg a 
		left join
		rcbill.clientcontractlastdiscount b
		on 
		a.clientcode=b.b_clientcode
		and
		a.contractcode=b.b_contractcode
		order by a.clientcode, a.contractcode
	) as tb1
	left join
	rcbill.clientcontractdiscounts tb2
	on
	tb1.clientcode=tb2.clientcode
	and
	tb1.contractcode=tb2.contractcode
	and
	tb1.b_upddate=tb2.upddate
	and tb1.service=tb2.servicename
)
;

select * from rcbill_my.activediscounts where percent>0 or amount>0;


-- CLIENT CONTRACT DISCOUNTS
drop table if exists rcbill_my.activediscounts2;
create table rcbill_my.activediscounts2 as 
(

	select a.*,b.percent,b.amount,b.servicename,b.upddate 
	from 
	(
		select a.*
		-- , b.service
		from 
		rcbill_my.customercontractactivity a 
		/*
		inner join 
		rcbill_my.dailyactivenumber b 
		on 
		a.period=b.period and a.contractcode=b.contractcode and a.clientcode=b.clientcode and a.servicesubcategory=b.servicesubcategory and a.package=b.servicetype
		and a.servicecategory=b.servicecategory
		*/
		where a.period=@rundate and a.reported='Y' 
	) a
	inner join
	( 
		-- rcbill.clientcontractdiscounts b 
		select a.*,b.*
		from 
		rcbill.clientcontractdiscounts a
		inner join 
		rcbill.clientcontractlastdiscount b 
		on 
		a.clientcode=b.b_clientcode and a.contractcode=b.b_contractcode and a.upddate=b.b_upddate

	) b
	on 
	a.clientcode=b.clientcode 
	and a.contractcode=b.contractcode
	and upper(trim(a.service))=upper(trim(b.servicename))
	-- where a.period=@rundate and a.reported='Y' 
)
;

select * from rcbill_my.activediscounts2;

select distinct clientcode from rcbill_my.activediscounts2;
select distinct contractcode from rcbill_my.activediscounts2;

select clientclass, count(distinct clientcode) as clients, count(distinct contractcode) contracts from rcbill_my.activediscounts2
group by clientclass
with rollup
;


/* 
select a.* 
,b.*
from rcbill_my.clientnetworkservicepkg a
inner join
rcbill.clientcontractdiscounts b
on 
a.clientcode=b.clientcode
and 
a.contractcode=b.contractcode
; 

select * from rcbill_my.clientnetworkservicepkg;

select a.*, b.*
from rcbill_my.clientnetworkservicepkg a 
left join
rcbill.clientcontractlastdiscount b
on 
a.clientcode=b.b_clientcode
and
a.contractcode=b.b_contractcode

order by a.clientcode, a.contractcode
;


select * from rcbill.clientcontractdiscounts order by clientcode, contractcode;


select 
tb1.*, tb2.* 
from 
(
select a.*, b.*
from rcbill_my.clientnetworkservicepkg a 
left join
rcbill.clientcontractlastdiscount b
on 
a.clientcode=b.b_clientcode
and
a.contractcode=b.b_contractcode

order by a.clientcode, a.contractcode
) as tb1
left join
rcbill.clientcontractdiscounts tb2
on
tb1.clientcode=tb2.clientcode
and
tb1.contractcode=tb2.contractcode
and
tb1.b_upddate=tb2.upddate
and tb1.service=tb2.servicename
;

select max(upddate) as upddate, clientcode, contractcode
from rcbill.clientcontractdiscounts
group by clientcode, contractcode
order by clientcode, contractcode
;

select max(upddate), clientcode, contractcode
from rcbill.clientcontractdiscounts
where clientcode='I.000011750'

group by clientcode, contractcode
order by contractcode
;
              SELECT    MAX(id) max_id, customer_id 
              FROM      customer_data 
              GROUP BY  customer_id 
*/

 
/* 
select clientid, clientcode, contractid, contractcode, percent, amount, approved, approvalreason, max(upddate) from rcbill.clientcontractdiscounts
group by clientid, clientcode, contractid, contractcode
; 
*/
 
/*
select clienttype, `Extravagance`, `Extravagance Corporate`, count(clientcode) as allaccounts, count(distinct clientcode) as uniqueaccounts
from rcbill_my.clientstats
where 
(`Extravagance`>0 or `Extravagance Corporate`>0)
and
services='TV & Internet' 
group by clienttype, `Extravagance`, `Extravagance Corporate`
;

select clienttype, `Extravagance`, `Extravagance Corporate`, count(clientcode) as allaccounts, count(distinct clientcode) as uniqueaccounts
from rcbill_my.clientstats
where 
(`Extravagance`>0 or `Extravagance Corporate`>0)
and
services='TV Only' 
group by clienttype, `Extravagance`, `Extravagance Corporate`
;

select *
from rcbill_my.clientstats
where 
(`Extravagance`>0 or `Extravagance Corporate`>0)
and
services='TV & Internet'
order by clientname;
*/
