use rcbill;


/*
## MAKE SURE THESE TABLES ARE POPULATED

select * from rcbill.rcb_iptv_package;
select * from rcbill.rcb_iptv_channels;
select * from rcbill.rcb_iptv_package_channels;
*/

drop table if exists rcbill.rcb_iptv_package_channels_list;

create table rcbill.rcb_iptv_package_channels_list(index idxipcl1(PACKAGE_ID),index idxipcl2(CHANNEL_ID),index idxipcl3(PACKAGE_NAME), index idxipcl4(CHANNEL_CODE), index idxipcl5(CHANNEL_NAME))
(
	select a.package_id as PACKAGE_ID, a.channel_id as CHANNEL_ID
	, b.code as PACKAGE_NAME -- , b.name
	, c.ckey as CHANNEL_CODE, c.name as CHANNEL_NAME
	, c.UPDDATE
	, c.INSERTEDON
	from 
	rcbill.rcb_iptv_package_channels a 

	inner join 
	rcbill.rcb_iptv_package b 
	on a.PACKAGE_ID=b.ID

	inner join 
	rcbill.rcb_iptv_channels c
	on a.CHANNEL_ID=c.ID

)
;


-- select * from rcbill.rcb_iptv_package_channels_list;