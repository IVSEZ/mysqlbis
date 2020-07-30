###############################
## make sure the parcel coords table has been populated

drop table if exists rcbill_extract.IV_PARCELEXTRACTStaging_orig;

create table rcbill_extract.IV_PARCELEXTRACTStaging_orig as 
(
	select a.orig_lat as lat, a.orig_lon as lon
	-- , concat(a.clientcode, ':', a.clientname, '[',a.clientparcel,']') as `title`
    , concat('<font face=verdana size=1>','Parcel: [',a.orig_clientparcel,']</font>') as `title`
	-- , concat(a.clientcode, ':', a.clientname, '[',a.clientparcel,'] ', a.AccountActivityStage,'|',a.clientclass,'|', a.activenetwork,'|',a.activeservices,'|',a.activecontracts,'|',a.activesubscriptions) as `description`
	, ifnull(concat('<font face=verdana size=1><a href="http://dashboard.intelvision.sc/anreports/report/customercontractreport_main.php?custcode=', a.orig_clientcode, '" target=_main>', a.orig_clientcode, '</a>:', a.orig_clientname, '[',a.orig_clientparcel,']</font><br><font face=verdana size=0.5>', a.orig_AccountActivityStage,'|',a.orig_clientclass,'|', a.orig_network, '</font><hr>'), concat('<font face=verdana size=1><a href="http://dashboard.intelvision.sc/anreports/report/customercontractreport_main.php?custcode=', a.orig_clientcode, '" target=_main>', a.orig_clientcode, '</a>:', a.orig_clientname, '[',a.orig_clientparcel,']</font><br><font face=verdana size=0.5>','INACTIVE','</font><hr>')) as `description`
	/*
	case when a.isaccountactive='InActive' then '#00FF00'
	else '#ff0000' end as `color`
	*/
	,a.orig_network
    , case when a.orig_network is null then 'icon/ylw-circle-lv.png'
	when a.orig_network='HFC' then 'icon/red-square-lv.png' 
	when a.orig_network='GPON' then 'icon/grn-diamond-lv.png' 
    else 'icon/blu-blank-lv.png' end as `icon`
	, '13,13' as `iconSize`
	, '-8,-8' as `iconOffset`
    , a.orig_reportdate as insertedon
	from
	(

		/*
		select a.*
		, (select latitude from rcbill.rcb_clientparcelcoords where clientparcel=a.orig_clientparcel and latitude<>0 order by INSERTEDON desc limit 1) as orig_lat
		, (select longitude from rcbill.rcb_clientparcelcoords where clientparcel=a.orig_clientparcel and latitude<>0  order by INSERTEDON desc limit 1) as orig_lon
		from 
		(
			select orig_reportdate,orig_CLIENTCODE, orig_CLIENTNAME, orig_IsAccountActive
			, orig_AccountActivityStage, orig_clientclass
			, ifnull(NULLIF(orig_a1_parcel,''),ifnull(NULLIF(orig_a2_parcel,''),NULLIF(orig_a3_parcel,''))) as orig_clientparcel 
			, (select network from rcbill_my.customercontractactivity a where a.clientcode=orig_CLIENTCODE and a.PERIOD=orig_reportdate limit 1) as orig_network
			from rcbill_my.rep_custextract_compare20191212
			where (orig_a1_parcel is not null or orig_a2_parcel is not null or orig_a3_parcel is not null)
		) a 
        */
        
		select a.*
		, b.latitude as orig_lat
        , b.longitude as orig_lon
		from 
		(
			select orig_reportdate,orig_CLIENTCODE, orig_CLIENTNAME, orig_IsAccountActive
			, orig_AccountActivityStage, orig_clientclass
			, ifnull(NULLIF(orig_a1_parcel,''),ifnull(NULLIF(orig_a2_parcel,''),NULLIF(orig_a3_parcel,''))) as orig_clientparcel 
			, (select network from rcbill_my.customercontractactivity a where a.clientcode=orig_CLIENTCODE and a.PERIOD=orig_reportdate limit 1) as orig_network
			from rcbill_my.rep_custextract_compare20191212
			where (orig_a1_parcel is not null or orig_a2_parcel is not null or orig_a3_parcel is not null)
		) a 
        inner join 
        (
		select * from rcbill.rcb_clientparcelcoords where latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel	
        
        ) b
        on a.orig_CLIENTCODE=b.clientcode and a.orig_clientparcel=b.clientparcel
	) a 
    where orig_lat is not null
    order by 6 asc
	

	
	/*
	select a.latitude as lat, a.longitude as lon
	-- , concat(a.clientcode, ':', a.clientname, '[',a.clientparcel,']') as `title`
    , concat('<font face=verdana size=1>','Parcel: [',a.clientparcel,']</font>') as `title`
	-- , concat(a.clientcode, ':', a.clientname, '[',a.clientparcel,'] ', a.AccountActivityStage,'|',a.clientclass,'|', a.activenetwork,'|',a.activeservices,'|',a.activecontracts,'|',a.activesubscriptions) as `description`
	, ifnull(concat('<font face=verdana size=1><a href="http://dashboard.intelvision.sc/anreports/report/customercontractreport_main.php?custcode=', a.clientcode, '" target=_main>', a.clientcode, '</a>:', a.clientname, '[',a.clientparcel,']</font><br><font face=verdana size=0.5>', a.AccountActivityStage,'|',a.clientclass,'|', a.activenetwork,'|',a.activeservices,'|',a.activecontracts,'|',a.activesubscriptions, '</font><hr>'), concat('<font face=verdana size=1><a href="http://dashboard.intelvision.sc/anreports/report/customercontractreport_main.php?custcode=', a.clientcode, '" target=_main>', a.clientcode, '</a>:', a.clientname, '[',a.clientparcel,']</font><br><font face=verdana size=0.5>','INACTIVE','</font><hr>')) as `description`

	,activenetwork
    , case when a.activenetwork is null then 'ylw-circle-lv.png'
	when a.activenetwork='HFC' then 'red-square-lv.png' 
	when a.activenetwork='GPON' then 'grn-diamond-lv.png' 
    else 'blu-blank-lv.png' end as `icon`
	, '13,13' as `iconSize`
	, '-8,-8' as `iconOffset`
	from
	(
		select a.*
		-- , b.*
		, b.IsAccountActive, b.AccountActivityStage, b.clientclass, b.activenetwork, b.activeservices, b.activecontracts, b.activesubscriptions

		from
		(
		select * from rcbill.rcb_clientparcelcoords where latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
		) a 
		left join 
		rcbill_my.rep_custconsolidated b
		on 
		a.clientcode=b.clientcode
	) a 
	-- limit 900
    order by 4 asc
    */
)
;

SELECT * FROM rcbill_extract.IV_PARCELEXTRACTStaging_orig;

set session group_concat_max_len = 30000;

drop table if exists rcbill_extract.IV_PARCELFORMAP_orig;
create table rcbill_extract.IV_PARCELFORMAP_orig as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_extract.IV_PARCELEXTRACTStaging_orig group by lat, lon, title
        
);

select * from rcbill_extract.IV_PARCELFORMAP_orig;

drop table if exists rcbill_extract.IV_PARCELFORMAP_Inactive_orig;
create table rcbill_extract.IV_PARCELFORMAP_Inactive_orig as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_extract.IV_PARCELEXTRACTStaging_orig 
        where orig_network is null
        group by lat, lon, title
        
);

select * from rcbill_extract.IV_PARCELFORMAP_Inactive_orig;

drop table if exists rcbill_extract.IV_PARCELFORMAP_HFC_orig;
create table rcbill_extract.IV_PARCELFORMAP_HFC_orig as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_extract.IV_PARCELEXTRACTStaging_orig 
        where orig_network = 'HFC'
        group by lat, lon, title
        
);

select * from rcbill_extract.IV_PARCELFORMAP_HFC_orig;

drop table if exists rcbill_extract.IV_PARCELFORMAP_GPON_orig;
create table rcbill_extract.IV_PARCELFORMAP_GPON_orig as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_extract.IV_PARCELEXTRACTStaging_orig 
        where orig_network = 'GPON'
        group by lat, lon, title
        
);

select * from rcbill_extract.IV_PARCELFORMAP_GPON_orig;


drop table if exists rcbill_extract.IV_PARCELFORMAP_MIX_orig;
create table rcbill_extract.IV_PARCELFORMAP_MIX_orig as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_extract.IV_PARCELEXTRACTStaging_orig 
        where icon='icon/blu-blank-lv.png'
        group by lat, lon, title
        
);

select * from rcbill_extract.IV_PARCELFORMAP_MIX_orig;
##
/*
this table is to be extracted as a TAB separated file
enclose strings in should be blank
exported to C:\ProgramData\MySQL\MySQL Server 5.7\Export\PARCEL_EXTRACT\textfile.csv
then convert the .csv to .txt and upload to maptest folder on the dashboard.intelvision.sc server

*/


###############################