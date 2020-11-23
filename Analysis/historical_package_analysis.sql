set @rundate='2020-02-05';

drop table if exists rcbill_my.clientnetworkservicepkg_temp;
create table rcbill_my.clientnetworkservicepkg_temp as
(
	select a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, a.service
	, a.network, a.package, a.servicecategory
	,a.contractcode
	, count(distinct a.period) as ServiceCount
    -- , sum(distinct a.ACTIVECOUNT) as ActiveCount
    , sum(a.ACTIVECOUNT) as ActiveCount
	from rcbill_my.customercontractactivity a
	where a.period=@rundate and a.reported='Y'
    
    and a.region='Praslin'
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



-- select * from rcbill_my.clientnetworkservicepkg where clientcode='I.000004055';

/*
select clientcode, clientname, clientclass, clienttype, region, network, 
case when servicecategory='TV' then ServiceCount end as TV,
case when servicecategory='Internet' then ServiceCount end as Internet,
case when servicecategory='Voice' then ServiceCount end as Voice
from rcbill_my.clientnetworkservicepkg;
*/

drop table if exists rcbill_my.clientnetworkservicesum_temp;

create table rcbill_my.clientnetworkservicesum_temp as
(
select period, clientcode, clientname, clientclass, clienttype, region, network, sum(ActiveCount) as ActiveCount
,count(distinct contractcode) as contractcount,  ifnull(sum(tv),0) as tv, ifnull(sum(ott),0) as ott, ifnull(sum(internet),0) as internet, ifnull(sum(voice),0) as voice
from 
(
	select period, clientcode, clientname, clientclass, clienttype, region, network, ActiveCount, contractcode,
	-- count(distinct contractcode) as contractcount,
	case when servicecategory='TV' then ServiceCount end as TV,
	case when servicecategory='OTT' then ServiceCount end as OTT,
	case when servicecategory='Internet' then ServiceCount end as Internet,
	case when servicecategory='Voice' then ServiceCount end as Voice
	from rcbill_my.clientnetworkservicepkg_temp
) cns
group by period, clientcode, clientname, clientclass, clienttype, region, network
);



-- select * from rcbill_my.clientnetworkservicesum_temp where clientcode='I.000012657';

-- select distinct package from rcbill_my.clientnetworkservicesum_temp;


drop table if exists rcbill_my.clientnetworkservicestats_temp;

create table rcbill_my.clientnetworkservicestats_temp as
(
	select period, clientcode, clientname, clientclass, clienttype, region, network, ActiveCount,contractcount,
	/*
	case 
	when tv>0 and internet>0 and voice>0 then 'All' 
	when tv>0 and internet>0 and voice=0 then 'TV & Internet'
	when tv>0 and internet=0 and voice=0 then 'TV Only'
	when tv=0 and internet>0 and voice=0 then 'Internet Only'
	when tv=0 and internet=0 and voice>0 then 'Voice Only'
	when tv>0 and internet=0 and voice>0 then 'TV & Voice'
	when tv=0 and internet>0 and voice>0 then 'Internet & Voice'
	end as Services
	*/

	case 

	when tv>0 and internet>0 and voice>0 and ott>0 then 'All' 
	when tv>0 and internet>0 and voice>0 and ott=0 then 'TV & Internet & Voice' 

	when tv>0 and internet=0 and voice=0 and ott=0 then 'TV Only'
	when tv=0 and internet>0 and voice=0 and ott=0 then 'Internet Only'
	when tv=0 and internet=0 and voice>0 and ott=0 then 'Voice Only'

	when tv>0 and internet=0 and voice>0 and ott=0 then 'TV & Voice'
	when tv=0 and internet>0 and voice>0 and ott=0 then 'Internet & Voice'
	when tv>0 and internet>0 and voice=0 and ott=0 then 'TV & Internet'

	when tv=0 and internet=0 and voice=0 and ott>0 then 'OTT Only'

	when tv>0 and internet=0 and voice=0 and ott>0 then 'TV & OTT'
	when tv=0 and internet>0 and voice=0 and ott>0 then 'Internet & OTT'
	when tv=0 and internet=0 and voice>0 and ott>0 then 'Voice & OTT'

	when tv>0 and internet>0 and voice=0 and ott>0 then 'TV & Internet & OTT'
	when tv>0 and internet=0 and voice>0 and ott>0 then 'TV & Voice & OTT'
	when tv=0 and internet>0 and voice>0 and ott>0 then 'Internet & Voice & OTT'

	end as Services

	from
	rcbill_my.clientnetworkservicesum_temp
)
;

-- select * from rcbill_my.clientnetworkservicestats_temp where clientcode='I.000012657';




drop table if exists rcbill_my.clientpackagestats_temp;

create table rcbill_my.clientpackagestats_temp as
(

	select period, clientcode, clientname, region, network, 
	ifnull(sum(`10GB`),0) as `10GB`,
	ifnull(sum(`20GB`),0) as `20GB`,
	ifnull(sum(`40GB`),0) as `40GB`,
    ifnull(sum(`Amber`),0) as `Amber`,
    ifnull(sum(`Amber Corporate`),0) as `Amber Corporate`,
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
	ifnull(sum(`DualView`),0) as `DualView`,
	ifnull(sum(`MultiView`),0) as `MultiView`,
	ifnull(sum(`VOD`),0) as `VOD`,
	ifnull(sum(`IGO`),0) as `IGO`,
	ifnull(sum(`Mobile Indian`),0) as `Mobile Indian`,
    
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
	ifnull(sum(`Indian Corporate`),0) as `Indian Corporate`,
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
		case when package='Amber' then packagecount end as `Amber`,
		case when package='Amber Corporate' then packagecount end as `Amber Corporate`,
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
        
		case when package='DualView' then packagecount end as `DualView`,
        case when package='MultiView' then packagecount end as `MultiView`,
		case when package='VOD' then packagecount end as `VOD`,
		case when package='IGo' then packagecount end as `IGO`,
		case when package='Mobile Indian' then packagecount end as `Mobile Indian`,
        
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
		case when package='Indian Corporate' then packagecount end as `Indian Corporate`,
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
			select period, clientcode, clientname, package, region, GetNetwork(@rundate,contractcode) as network, count(1) as packagecount from rcbill_my.customercontractactivity where period=@rundate and clientcode in 
			(
            select clientcode from rcbill_my.clientnetworkservicestats 
            -- where services = 'TV & Internet' 
			-- and clienttype='Residential'
			) 
			group by period, clientcode, clientname, package, region, GetNetwork(@rundate,contractcode)
			order by clientcode
            */
            -- select * from rcbill_my.clientnetworkservicepkg
            
            select period, clientcode, clientname, package, region, network
            -- , count(1) as packagecount 
            , sum(activecount) as packagecount
            from rcbill_my.clientnetworkservicepkg_temp where period=@rundate
            group by period, clientcode, clientname, package, region, network
			
        ) a
	) b 

	group by period, clientcode, clientname,region, network
	order by clientname

);

-- select * from rcbill_my.clientpackagestats_temp;

drop table if exists rcbill_my.clientstats_temp;

create table rcbill_my.clientstats_temp 
(INDEX idxcs1 (clientcode)) as
(
select 
-- a.period as a_period, a.clientcode as a_clientcode, a.clientname as a_clientname, a.region as a_region, a.network as a_network
-- , 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount
, b.* from
rcbill_my.clientnetworkservicestats_temp a 
inner join
rcbill_my.clientpackagestats_temp b
on 
a.clientcode=b.clientcode
and 
a.region=b.region
and
a.network=b.network
order by b.clientcode
)

;

select count(*) as clientstats_temp from rcbill_my.clientstats_temp;
-- 
select * from rcbill_my.clientstats_temp;
select * from rcbill_my.clientstats;

select a.*
, b.reportdate, b.IsAccountActive, b.AccountActivityStage, b.clientname, b.activenetwork, b.lastactivedate
, b.TotalPaymentAmount2020, b.clientclass
from 
(
	select COALESCE(a.clientcode_old,a.clientcode) as clientcode_final, a.period_old, a.period, a.services_old, a.services
	, a.region_old
    , a.region
    , a.network_old
    , a.network
    , a.Extravagance_old
    , a.Extravagance
    , a.Basic_old
    , a.Basic
    , a.Executive_old
    , a.Executive
    , a.Intelenovela_old
    , a.Intelenovela
	from
	( 
		(
		select
		a.`clientclass` as `clientclass_old`,
		a.`clienttype` as `clienttype_old`,
		a.`services` as `services_old`,
		a.`ActiveCount` as `ActiveCount_old`,
		a.`contractcount` as `contractcount_old`,
		a.`period` as `period_old`,
		a.`clientcode` as `clientcode_old`,
		a.`clientname` as `clientname_old`,
		a.`region` as `region_old`,
		a.`network` as `network_old`,
		a.`10GB` as `10GB_old`,
		a.`20GB` as `20GB_old`,
		a.`40GB` as `40GB_old`,
		a.`Amber` as `Amber_old`,
		a.`Amber Corporate` as `Amber Corporate_old`,
		a.`Basic` as `Basic_old`,
		a.`Business Unlimited-1` as `Business Unlimited-1_old`,
		a.`Business Unlimited-2` as `Business Unlimited-2_old`,
		a.`Business Unlimited-6` as `Business Unlimited-6_old`,
		a.`Business Unlimited-8` as `Business Unlimited-8_old`,
		a.`Business Unlimited-8-daytime` as `Business Unlimited-8-daytime_old`,
		a.`Crimson` as `Crimson_old`,
		a.`Crimson Corporate` as `Crimson Corporate_old`,
		a.`Dedicated Custom` as `Dedicated Custom_old`,
		a.`Dedicated Plus` as `Dedicated Plus_old`,
		a.`DualView` as `DualView_old`,
		a.`MultiView` as `MultiView_old`,
		a.`VOD` as `VOD_old`,
		a.`IGO` as `IGO_old`,
		a.`Mobile Indian` as `Mobile Indian_old`,
		a.`Elite` as `Elite_old`,
		a.`Executive` as `Executive_old`,
		a.`Extravagance` as `Extravagance_old`,
		a.`Extravagance Corporate` as `Extravagance Corporate_old`,
		a.`Extreme` as `Extreme_old`,
		a.`Extreme Plus` as `Extreme Plus_old`,
		a.`French` as `French_old`,
		a.`Hotels/Channels` as `Hotels/Channels_old`,
		a.`Hotels/Decoder` as `Hotels/Decoder_old`,
		a.`Indian` as `Indian_old`,
		a.`Indian Corporate` as `Indian Corporate_old`,
		a.`Intel Data 10` as `Intel Data 10_old`,
		a.`Intel Voice 10` as `Intel Voice 10_old`,
		a.`Intel Voice 20` as `Intel Voice 20_old`,
		a.`Intelenovela` as `Intelenovela_old`,
		a.`PBX` as `PBX_old`,
		a.`Performance` as `Performance_old`,
		a.`Performance Plus` as `Performance Plus_old`,
		a.`Prepaid` as `Prepaid_old`,
		a.`Prepaid Data` as `Prepaid Data_old`,
		a.`Prestige` as `Prestige_old`,
		a.`Starter` as `Starter_old`,
		a.`Turquoise High Tide` as `Turquoise High Tide_old`,
		a.`Turquoise Low Tide` as `Turquoise Low Tide_old`,
		a.`TurquoiseTV` as `TurquoiseTV_old`,
		a.`Value` as `Value_old`,
		a.`Voice Plus` as `Voice Plus_old`,
		a.`VPN` as `VPN_old`,

		b.*
		from 
		rcbill_my.clientstats_temp a
		right join 
		rcbill_my.clientstats b
		on 
		a.CLIENTCODE=b.clientcode
        
        where b.region='Praslin'
		)
		union
		(
		select
		a.`clientclass` as `clientclass_old`,
		a.`clienttype` as `clienttype_old`,
		a.`services` as `services_old`,
		a.`ActiveCount` as `ActiveCount_old`,
		a.`contractcount` as `contractcount_old`,
		a.`period` as `period_old`,
		a.`clientcode` as `clientcode_old`,
		a.`clientname` as `clientname_old`,
		a.`region` as `region_old`,
		a.`network` as `network_old`,
		a.`10GB` as `10GB_old`,
		a.`20GB` as `20GB_old`,
		a.`40GB` as `40GB_old`,
		a.`Amber` as `Amber_old`,
		a.`Amber Corporate` as `Amber Corporate_old`,
		a.`Basic` as `Basic_old`,
		a.`Business Unlimited-1` as `Business Unlimited-1_old`,
		a.`Business Unlimited-2` as `Business Unlimited-2_old`,
		a.`Business Unlimited-6` as `Business Unlimited-6_old`,
		a.`Business Unlimited-8` as `Business Unlimited-8_old`,
		a.`Business Unlimited-8-daytime` as `Business Unlimited-8-daytime_old`,
		a.`Crimson` as `Crimson_old`,
		a.`Crimson Corporate` as `Crimson Corporate_old`,
		a.`Dedicated Custom` as `Dedicated Custom_old`,
		a.`Dedicated Plus` as `Dedicated Plus_old`,
		a.`DualView` as `DualView_old`,
		a.`MultiView` as `MultiView_old`,
		a.`VOD` as `VOD_old`,
		a.`IGO` as `IGO_old`,
		a.`Mobile Indian` as `Mobile Indian_old`,
		a.`Elite` as `Elite_old`,
		a.`Executive` as `Executive_old`,
		a.`Extravagance` as `Extravagance_old`,
		a.`Extravagance Corporate` as `Extravagance Corporate_old`,
		a.`Extreme` as `Extreme_old`,
		a.`Extreme Plus` as `Extreme Plus_old`,
		a.`French` as `French_old`,
		a.`Hotels/Channels` as `Hotels/Channels_old`,
		a.`Hotels/Decoder` as `Hotels/Decoder_old`,
		a.`Indian` as `Indian_old`,
		a.`Indian Corporate` as `Indian Corporate_old`,
		a.`Intel Data 10` as `Intel Data 10_old`,
		a.`Intel Voice 10` as `Intel Voice 10_old`,
		a.`Intel Voice 20` as `Intel Voice 20_old`,
		a.`Intelenovela` as `Intelenovela_old`,
		a.`PBX` as `PBX_old`,
		a.`Performance` as `Performance_old`,
		a.`Performance Plus` as `Performance Plus_old`,
		a.`Prepaid` as `Prepaid_old`,
		a.`Prepaid Data` as `Prepaid Data_old`,
		a.`Prestige` as `Prestige_old`,
		a.`Starter` as `Starter_old`,
		a.`Turquoise High Tide` as `Turquoise High Tide_old`,
		a.`Turquoise Low Tide` as `Turquoise Low Tide_old`,
		a.`TurquoiseTV` as `TurquoiseTV_old`,
		a.`Value` as `Value_old`,
		a.`Voice Plus` as `Voice Plus_old`,
		a.`VPN` as `VPN_old`,

		b.*
		from 
		rcbill_my.clientstats_temp a
		left join 
		rcbill_my.clientstats b
		on 
		a.CLIENTCODE=b.clientcode
        
        where a.region='Praslin'
		)
	) a

) a 

left join 
rcbill_my.rep_custconsolidated b 
on a.clientcode_final=b.clientcode

-- where a.region_old='Praslin'
;


-- select * from rcbill_my.rep_custconsolidated
