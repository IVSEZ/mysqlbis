###############################
## make sure the parcel coords table has been populated

-- select * from rcbill_my.rep_custconsolidated;

drop table if exists rcbill_extract.IV_PARCELEXTRACTStaging;

create table rcbill_extract.IV_PARCELEXTRACTStaging as 
(
	select a.latitude as lat, a.longitude as lon
	-- , concat(a.clientcode, ':', a.clientname, '[',a.clientparcel,']') as `title`
    , concat('<font face=verdana size=0.5>',a.reportdate,'</font><br>','<font face=verdana size=1>','Parcel: [',a.clientparcel,'] </font><hr>') as `title`
	-- , concat(a.clientcode, ':', a.clientname, '[',a.clientparcel,'] ', a.AccountActivityStage,'|',a.clientclass,'|', a.activenetwork,'|',a.activeservices,'|',a.activecontracts,'|',a.activesubscriptions) as `description`
	, ifnull(concat('<font face=verdana size=1><a href="http://dashboard.intelvision.sc/anreports/report/customercontractreport_main.php?custcode=', a.clientcode, '" target=_main>', a.clientcode, '</a>:', a.clientname, '[',a.clientparcel,']</font><br><font face=verdana size=0.5>', a.AccountActivityStage,'|',a.clientclass,'|', a.activenetwork,'|',a.activeservices,'|',a.activecontracts,'|',a.activesubscriptions, '</font><hr>'), concat('<font face=verdana size=1><a href="http://dashboard.intelvision.sc/anreports/report/customercontractreport_main.php?custcode=', a.clientcode, '" target=_main>', a.clientcode, '</a>:', a.clientname, '[',a.clientparcel,']</font><br><font face=verdana size=0.5>','INACTIVE','</font><hr>')) as `description`
	/*
	case when a.isaccountactive='InActive' then '#00FF00'
	else '#ff0000' end as `color`
	*/
	,activenetwork
    , case when a.activenetwork is null then 'ylw-circle-lv.png'
	when a.activenetwork='HFC' then 'red-square-lv.png' 
	when a.activenetwork='GPON' then 'grn-diamond-lv.png' 
    else 'blu-blank-lv.png' end as `icon`
	, '13,13' as `iconSize`
	, '-8,-8' as `iconOffset`
    , date(a.insertedon) as insertedon
	from
	(
		select a.*
		-- , b.*
		, b.IsAccountActive, b.AccountActivityStage, b.clientclass, b.activenetwork, b.activeservices, b.activecontracts, b.activesubscriptions
		, b.reportdate
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

SELECT * FROM rcbill_extract.IV_PARCELEXTRACTStaging;



set session group_concat_max_len = 30000;

drop table if exists rcbill_extract.IV_PARCELFORMAP;
create table rcbill_extract.IV_PARCELFORMAP as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_extract.IV_PARCELEXTRACTStaging group by lat, lon, title
        
);

select * from rcbill_extract.IV_PARCELFORMAP;

drop table if exists rcbill_extract.IV_PARCELFORMAP_Inactive;
create table rcbill_extract.IV_PARCELFORMAP_Inactive as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_extract.IV_PARCELEXTRACTStaging 
        where activenetwork is null
        group by lat, lon, title
        
);

select * from rcbill_extract.IV_PARCELFORMAP_Inactive;

drop table if exists rcbill_extract.IV_PARCELFORMAP_HFC;
create table rcbill_extract.IV_PARCELFORMAP_HFC as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_extract.IV_PARCELEXTRACTStaging 
        where activenetwork = 'HFC'
        group by lat, lon, title
        
);

select * from rcbill_extract.IV_PARCELFORMAP_HFC;

drop table if exists rcbill_extract.IV_PARCELFORMAP_GPON;
create table rcbill_extract.IV_PARCELFORMAP_GPON as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_extract.IV_PARCELEXTRACTStaging 
        where activenetwork = 'GPON'
        group by lat, lon, title
        
);

select * from rcbill_extract.IV_PARCELFORMAP_GPON;


drop table if exists rcbill_extract.IV_PARCELFORMAP_MIX;
create table rcbill_extract.IV_PARCELFORMAP_MIX as 
(
        select lat, lon, title, group_concat(description separator '<br>') as description 
        , icon, iconSize, iconOffset
        from rcbill_extract.IV_PARCELEXTRACTStaging 
        where icon='blu-blank-lv.png'
        group by lat, lon, title
        
);

select * from rcbill_extract.IV_PARCELFORMAP_MIX;
##
/*
this table is to be extracted as a TAB separated file
enclose strings in should be blank
exported to C:\ProgramData\MySQL\MySQL Server 5.7\Export\PARCEL_EXTRACT\textfile.csv
then convert the .csv to .txt and upload to maptest folder on the dashboard.intelvision.sc server

*/


###############################