use rcbill_my;

drop table if exists tempa;

create table tempa as 
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191212
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191213
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191214
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191215
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191216
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191217
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191218
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)

;

select * from rcbill_my.tempa;

drop table if exists rcbill_my.rep_custextract_compare_final;

create table rcbill_my.rep_custextract_compare_final as 
(

	select clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, sum(`20191212`) as `20191212`
	, sum(`20191213`) as `20191213`
	, sum(`20191214`) as `20191214`
	, sum(`20191215`) as `20191215`
	, sum(`20191216`) as `20191216`
	, sum(`20191217`) as `20191217`
	, sum(`20191218`) as `20191218`

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
		from rcbill_my.tempa
	) a
	group by clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
;

select * from rcbill_my.rep_custextract_compare_final;

set @colname=', sum(`20191212`) as `20191212`
, sum(`20191213`) as `20191213`
, sum(`20191214`) as `20191214`
, sum(`20191215`) as `20191215`
, sum(`20191216`) as `20191216`
, sum(`20191217`) as `20191217`
, sum(`20191218`) as `20191218`
';


SET @qs = CONCAT('select CLIENT_NAME_STATUS ', @colname , ' from rcbill_my.rep_custextract_compare_final group by 1 with rollup');
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_CLASS_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_ADDRESS_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_LOCATION_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_AREA_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_EMAIL_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_NIN_STATUS, NIN_PRESENT ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_PHONE_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select PARCEL_ADD_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;



SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_NAME_STATUS ', @colname , ' from rcbill_my.rep_custextract_compare_final group by 1,2 with rollup');
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_CLASS_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_ADDRESS_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_LOCATION_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_AREA_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_EMAIL_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_PHONE_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;
SET @qs = CONCAT('select CLIENT_STATUS, PARCEL_ADD_STATUS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENTCLASS ', @colname , ' from rcbill_my.rep_custextract_compare_final group by 1,2,3 with rollup');
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_ADDRESS_STATUS, CLIENTCLASS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_LOCATION_STATUS, CLIENTCLASS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_AREA_STATUS, CLIENTCLASS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_EMAIL_STATUS, CLIENTCLASS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_PHONE_STATUS, CLIENTCLASS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, PARCEL_ADD_STATUS, CLIENTCLASS ', @colname, ' from rcbill_my.rep_custextract_compare_final group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

