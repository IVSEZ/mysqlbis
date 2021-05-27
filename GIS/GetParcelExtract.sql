use rcbill_maps;

###############################
## make sure the parcel coords table has been populated
-- select * from rcbill_my.rep_custconsolidated where clientcode='I.000005755';

/*
##### TESTING CODE

select * from rcbill.rcb_clientparcels;


select date(insertedon) as dateinserted, count(clientparcel) as parcels
from rcbill.rcb_clientparcelcoords 
where latitude<>0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))
;

select date(insertedon) as dateinserted, count(clientparcel) as parcels
from rcbill.rcb_clientparcelcoords 
group by 1
order by 1 desc
;

select * from rcbill.rcb_clientparcelcoords where latitude<>0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords));


select a.*, b.valid_parcels, c.invalid_parcels
from 
	(
		select date(insertedon) as dateinserted, count(clientparcel) as total_parcels
		from rcbill.rcb_clientparcelcoords 
		group by 1
		order by 1 desc
		-- ;
	) a 
inner join 
	(
		select date(insertedon) as dateinserted, count(clientparcel) as valid_parcels
		from rcbill.rcb_clientparcelcoords 
		where latitude<>0
		group by 1
		order by 1 desc
		-- ;
	) b 
on a.dateinserted=b.dateinserted

inner join 
	(
		select date(insertedon) as dateinserted, count(clientparcel) as invalid_parcels
		from rcbill.rcb_clientparcelcoords 
		where latitude=0
		group by 1
		order by 1 desc
		-- ;
	) c
on a.dateinserted=c.dateinserted
;

*/

-- select * from rcbill_my.rep_custconsolidated;

drop table if exists rcbill_maps.IV_PARCELEXTRACTStaging;

create table rcbill_maps.IV_PARCELEXTRACTStaging as 
(
	select a.latitude as lat, a.longitude as lon
	-- , concat(a.clientcode, ':', a.clientname, '[',a.clientparcel,']') as `title`
    , concat('<font face=verdana size=0.5>',a.reportdate,'</font><br>','<font face=verdana size=1>','Parcel: [',a.clientparcel,'] </font><hr>') as `title`
	-- , concat(a.clientcode, ':', a.clientname, '[',a.clientparcel,'] ', a.AccountActivityStage,'|',a.clientclass,'|', a.activenetwork,'|',a.activeservices,'|',a.activecontracts,'|',a.activesubscriptions) as `description`
	, ifnull(concat('<font face=verdana size=1><a href="http://dashboard.intelvision.sc/anreports/report/customercontractreport_main.php?custcode=', a.clientcode, '" target=_main>', a.clientcode, '</a>:', a.clientname, '[',a.clientparcel,']</font><br><font face=verdana size=0.5><font color=green>', a.AccountActivityStage,'</font>|',a.clientclass,'|', a.activenetwork,'|',a.activeservices,'|',a.activecontracts,'|',a.activesubscriptions, '</font><hr>'), concat('<font face=verdana size=1><a href="http://dashboard.intelvision.sc/anreports/report/customercontractreport_main.php?custcode=', a.clientcode, '" target=_main>', a.clientcode, '</a>:', a.clientname, '[',a.clientparcel,']</font><br><font face=verdana size=0.5><font color=red>','INACTIVE</font> [since: ',ifnull(a.lastactivedate,'before 2016'),']</font><hr>')) as `description`
	/*
	case when a.isaccountactive='InActive' then '#00FF00'
	else '#ff0000' end as `color`
	*/
	,activenetwork
    , 
    case 
    when a.activenetwork is null and a.AccountActivityStage='2. Snoozing (1 to 7 days)' then 'icon/wht-circle-lv.png'
    when a.activenetwork is null and a.AccountActivityStage='3. Asleep (8 to 30 days)' then 'icon/ylw-circle-lv.png'
    when a.activenetwork is null and a.AccountActivityStage='4. Hibernating (31 to 90 days)' then 'icon/pink-circle-lv.png'
    when a.activenetwork is null and a.AccountActivityStage='5. Dormant (more than 90 days)' then 'icon/purple-circle-lv.png'
	when a.activenetwork='HFC' then 'icon/red-square-lv.png' 
	when a.activenetwork='GPON' then 'icon/grn-diamond-lv.png' 
    else 'icon/blu-blank-lv.png' end as `icon`
	, '13,13' as `iconSize`
	, '-8,-8' as `iconOffset`
    , date(a.insertedon) as insertedon
    , a.accountactivitystage
	from
	(
		select a.*
		-- , b.*
		, b.IsAccountActive, b.AccountActivityStage, b.clientclass, b.activenetwork, b.activeservices, b.activecontracts, b.activesubscriptions
		, b.reportdate, b.lastactivedate
		from
		(
		select * from rcbill.rcb_clientparcelcoords where latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
		) a 
		left join 
		rcbill_my.rep_custconsolidated b
		on 
		a.clientcode=b.clientcode
        -- order by b.IsAccountActive
	) a 
	-- limit 900
    order by 6 asc
)
;

SELECT * FROM rcbill_maps.IV_PARCELEXTRACTStaging;



set session group_concat_max_len = 30000;

drop table if exists rcbill_maps.IV_PARCELFORMAP;
create table rcbill_maps.IV_PARCELFORMAP as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_maps.IV_PARCELEXTRACTStaging group by lat, lon, title
        
);

select * from rcbill_maps.IV_PARCELFORMAP;

drop table if exists rcbill_maps.IV_PARCELFORMAP_Inactive_2;
create table rcbill_maps.IV_PARCELFORMAP_Inactive_2 as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_maps.IV_PARCELEXTRACTStaging 
        where activenetwork is null and AccountActivityStage='2. Snoozing (1 to 7 days)'
        group by lat, lon, title
        
);
select * from rcbill_maps.IV_PARCELFORMAP_Inactive_2;

drop table if exists rcbill_maps.IV_PARCELFORMAP_Inactive_3;
create table rcbill_maps.IV_PARCELFORMAP_Inactive_3 as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_maps.IV_PARCELEXTRACTStaging 
        where activenetwork is null and AccountActivityStage='3. Asleep (8 to 30 days)'
        group by lat, lon, title
        
);
select * from rcbill_maps.IV_PARCELFORMAP_Inactive_3;

drop table if exists rcbill_maps.IV_PARCELFORMAP_Inactive_4;
create table rcbill_maps.IV_PARCELFORMAP_Inactive_4 as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_maps.IV_PARCELEXTRACTStaging 
        where activenetwork is null and AccountActivityStage='4. Hibernating (31 to 90 days)'
        group by lat, lon, title
        
);
select * from rcbill_maps.IV_PARCELFORMAP_Inactive_4;

drop table if exists rcbill_maps.IV_PARCELFORMAP_Inactive_5;
create table rcbill_maps.IV_PARCELFORMAP_Inactive_5 as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_maps.IV_PARCELEXTRACTStaging 
        where activenetwork is null and AccountActivityStage='5. Dormant (more than 90 days)'
        group by lat, lon, title
        
);
select * from rcbill_maps.IV_PARCELFORMAP_Inactive_5;




drop table if exists rcbill_maps.IV_PARCELFORMAP_HFC;
create table rcbill_maps.IV_PARCELFORMAP_HFC as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_maps.IV_PARCELEXTRACTStaging 
        where activenetwork = 'HFC'
        group by lat, lon, title
        
);

select * from rcbill_maps.IV_PARCELFORMAP_HFC;

drop table if exists rcbill_maps.IV_PARCELFORMAP_GPON;
create table rcbill_maps.IV_PARCELFORMAP_GPON as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_maps.IV_PARCELEXTRACTStaging 
        where activenetwork = 'GPON'
        group by lat, lon, title
        
);

select * from rcbill_maps.IV_PARCELFORMAP_GPON;


drop table if exists rcbill_maps.IV_PARCELFORMAP_MIX;
create table rcbill_maps.IV_PARCELFORMAP_MIX as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_maps.IV_PARCELEXTRACTStaging 
        where icon='icon/blu-blank-lv.png'
        group by lat, lon, title
        
);

select * from rcbill_maps.IV_PARCELFORMAP_MIX;
##
/*
this table is to be extracted as a TAB separated file
enclose strings in should be blank
exported to C:\ProgramData\MySQL\MySQL Server 5.7\Export\PARCEL_EXTRACT\textfile.csv
then convert the .csv to .txt and upload to maptest folder on the dashboard.intelvision.sc server

*/


###############################

drop table if exists rcbill_maps.IV_HFCNODEStaging;

create table rcbill_maps.IV_HFCNODEStaging as 
(
	select a.DECIMALLAT as lat, a.DECIMALLONG as lon
	-- , concat(a.clientcode, ':', a.clientname, '[',a.clientparcel,']') as `title`
    , concat('<font face=verdana size=1>',a.NODENAME,'</font><hr>') as `title`
	-- , concat(a.clientcode, ':', a.clientname, '[',a.clientparcel,'] ', a.AccountActivityStage,'|',a.clientclass,'|', a.activenetwork,'|',a.activeservices,'|',a.activecontracts,'|',a.activesubscriptions) as `description`
	, concat('<font face=verdana size=1>', a.NODENAME, '[',a.INTERFACENAME,']</font><br><font face=verdana size=0.5>', a.SUBDISTRICT,'</font>', '</font>') as `description`
    ,'icon/letter_g.png' end as `icon`
	, '16,16' as `iconSize`
	, '-8,-8' as `iconOffset`
    , date(a.insertedon) as insertedon
	from
	rcbill.rcb_techregions a 
)
;

SELECT * FROM rcbill_maps.IV_HFCNODEStaging;

drop table if exists rcbill_maps.IV_HFC_NODES;
create table rcbill_maps.IV_HFC_NODES as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_maps.IV_HFCNODEStaging 
        where icon='icon/blu-blank-lv.png'
        group by lat, lon, title
        
);

select * from rcbill_maps.IV_HFC_NODES;

-- SELECT * FROM rcbill.rcb_techregions;
