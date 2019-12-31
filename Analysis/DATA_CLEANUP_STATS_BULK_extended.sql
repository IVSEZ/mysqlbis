use rcbill_my;

drop table if exists tempabulk;

create table tempabulk as 
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191212
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191213
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191214
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191215
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191216
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191217
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191218
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191219
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191220
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191221
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191222
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191223
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191224
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191225
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191226
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191227
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191229
    where clientname like '%STAFF%'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
;

select * from rcbill_my.tempabulk;

drop table if exists rcbill_my.rep_custextract_compare_final_bulk;

create table rcbill_my.rep_custextract_compare_final_bulk as 
(

	select clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, sum(`20191212`) as `20191212`
	, sum(`20191213`) as `20191213`
	, sum(`20191214`) as `20191214`
	, sum(`20191215`) as `20191215`
	, sum(`20191216`) as `20191216`
	, sum(`20191217`) as `20191217`
	, sum(`20191218`) as `20191218`
	, sum(`20191219`) as `20191219`
	, sum(`20191220`) as `20191220`
	, sum(`20191221`) as `20191221`
	, sum(`20191222`) as `20191222`
	, sum(`20191223`) as `20191223`
	, sum(`20191224`) as `20191224`
	, sum(`20191225`) as `20191225`
	, sum(`20191226`) as `20191226`
	, sum(`20191227`) as `20191227`
	, sum(`20191229`) as `20191229`

	from 
	(
		select clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
		, case when reportdate='2019-12-12' then CLIENTCODES end as '20191212'
		, case when reportdate='2019-12-13' then CLIENTCODES end as '20191213'
		, case when reportdate='2019-12-14' then CLIENTCODES end as '20191214'
		, case when reportdate='2019-12-15' then CLIENTCODES end as '20191215'
		, case when reportdate='2019-12-16' then CLIENTCODES end as '20191216'
		, case when reportdate='2019-12-17' then CLIENTCODES end as '20191217'
		, case when reportdate='2019-12-18' then CLIENTCODES end as '20191218'
		, case when reportdate='2019-12-19' then CLIENTCODES end as '20191219'
		, case when reportdate='2019-12-20' then CLIENTCODES end as '20191220'
		, case when reportdate='2019-12-21' then CLIENTCODES end as '20191221'
		, case when reportdate='2019-12-22' then CLIENTCODES end as '20191222'
		, case when reportdate='2019-12-23' then CLIENTCODES end as '20191223'
		, case when reportdate='2019-12-24' then CLIENTCODES end as '20191224'
		, case when reportdate='2019-12-25' then CLIENTCODES end as '20191225'
		, case when reportdate='2019-12-26' then CLIENTCODES end as '20191226'
		, case when reportdate='2019-12-27' then CLIENTCODES end as '20191227'
 		, case when reportdate='2019-12-29' then CLIENTCODES end as '20191229'
       
		from rcbill_my.tempabulk
	) a
	group by clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
;

select * from rcbill_my.rep_custextract_compare_final_bulk;

set @colname=', sum(`20191212`) as `20191212`
, sum(`20191213`) as `20191213`
, sum(`20191214`) as `20191214`
, sum(`20191215`) as `20191215`
, sum(`20191216`) as `20191216`
, sum(`20191217`) as `20191217`
, sum(`20191218`) as `20191218`
, sum(`20191219`) as `20191219`
, sum(`20191220`) as `20191220`
, sum(`20191221`) as `20191221`
, sum(`20191222`) as `20191222`
, sum(`20191223`) as `20191223`
, sum(`20191224`) as `20191224`
, sum(`20191225`) as `20191225`
, sum(`20191226`) as `20191226`
, sum(`20191227`) as `20191227`
, sum(`20191229`) as `20191229`

';



SET @qs = CONCAT('select CLIENT_NAME_STATUS ', @colname , ' from rcbill_my.rep_custextract_compare_final_bulk group by 1 with rollup');
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_CLASS_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final_bulk group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_ADDRESS_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final_bulk group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_LOCATION_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final_bulk group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_AREA_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final_bulk group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_EMAIL_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final_bulk group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_NIN_STATUS, NIN_PRESENT ', @colname, ' from rcbill_my.rep_custextract_compare_final_bulk group by 1, 2 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_PHONE_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final_bulk group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select PARCEL_ADD_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final_bulk group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
