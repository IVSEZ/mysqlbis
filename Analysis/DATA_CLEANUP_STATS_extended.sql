

use rcbill_my;

drop table if exists tempa;

create table tempa as 
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191212
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191213
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191214
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191215
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191216
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191217
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191218
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191219
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191220
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191221
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191222
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191223
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191224
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191225
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191226
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191227
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191229
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191230
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20191231
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200105
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200106
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200107
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200108
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200109
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200110
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200113
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200114
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200115
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200116
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)

union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200122
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200127
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200202
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200203
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200204
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200206
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200211
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200214
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200301
    where 0=0 and ONE_YEAR='ONE YEAR'
	group by REPORTDATE, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
union  
(
	select reportdate, clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
	, count(CLIENTCODE) as CLIENTCODES
	from rcbill_my.rep_custextract_compare20200315
    where 0=0 and ONE_YEAR='ONE YEAR'
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
	, sum(`20191230`) as `20191230`
	, sum(`20191231`) as `20191231`
	, sum(`20200105`) as `20200105`
	, sum(`20200106`) as `20200106`
	, sum(`20200107`) as `20200107`
	, sum(`20200108`) as `20200108`
	, sum(`20200109`) as `20200109`
	, sum(`20200110`) as `20200110`
	, sum(`20200113`) as `20200113`
	, sum(`20200114`) as `20200114`
	, sum(`20200115`) as `20200115`
	, sum(`20200116`) as `20200116`
	, sum(`20200122`) as `20200122`
	, sum(`20200127`) as `20200127`
	, sum(`20200202`) as `20200202`
	, sum(`20200203`) as `20200203`
	, sum(`20200204`) as `20200204`
	, sum(`20200206`) as `20200206`
	, sum(`20200211`) as `20200211`
	, sum(`20200214`) as `20200214`
	, sum(`20200301`) as `20200301`
	, sum(`20200315`) as `20200315`
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
		, case when reportdate='2019-12-30' then CLIENTCODES end as '20191230'
		, case when reportdate='2019-12-31' then CLIENTCODES end as '20191231'
		, case when reportdate='2020-01-05' then CLIENTCODES end as '20200105'
		, case when reportdate='2020-01-06' then CLIENTCODES end as '20200106'
		, case when reportdate='2020-01-07' then CLIENTCODES end as '20200107'
		, case when reportdate='2020-01-08' then CLIENTCODES end as '20200108'
		, case when reportdate='2020-01-09' then CLIENTCODES end as '20200109'
		, case when reportdate='2020-01-10' then CLIENTCODES end as '20200110'
		, case when reportdate='2020-01-13' then CLIENTCODES end as '20200113'
		, case when reportdate='2020-01-14' then CLIENTCODES end as '20200114'
		, case when reportdate='2020-01-15' then CLIENTCODES end as '20200115'
		, case when reportdate='2020-01-16' then CLIENTCODES end as '20200116'
		, case when reportdate='2020-01-22' then CLIENTCODES end as '20200122'
		, case when reportdate='2020-01-27' then CLIENTCODES end as '20200127'
		, case when reportdate='2020-02-02' then CLIENTCODES end as '20200202'
		, case when reportdate='2020-02-03' then CLIENTCODES end as '20200203'
		, case when reportdate='2020-02-04' then CLIENTCODES end as '20200204'
		, case when reportdate='2020-02-06' then CLIENTCODES end as '20200206'
		, case when reportdate='2020-02-11' then CLIENTCODES end as '20200211'
		, case when reportdate='2020-02-14' then CLIENTCODES end as '20200214'
		, case when reportdate='2020-03-01' then CLIENTCODES end as '20200301'
		, case when reportdate='2020-03-15' then CLIENTCODES end as '20200315'        
        
		from rcbill_my.tempa
	) a
	group by clientclass, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_AREA_STATUS, CLIENT_CLASS_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, CLIENT_PHONE_STATUS, PARCEL_ADD_STATUS
)
;

select * from rcbill_my.rep_custextract_compare_final;

set @colname='
, sum(`20200315`) as `20200315`
, sum(`20200301`) as `20200301`
, sum(`20200214`) as `20200214`
, sum(`20200211`) as `20200211`
, sum(`20200206`) as `20200206`
, sum(`20200204`) as `20200204`
, sum(`20200203`) as `20200203`
, sum(`20200202`) as `20200202`
, sum(`20200127`) as `20200127`
, sum(`20200122`) as `20200122`
, sum(`20200116`) as `20200116`
, sum(`20200115`) as `20200115`
, sum(`20200114`) as `20200114`
, sum(`20200113`) as `20200113`
, sum(`20200110`) as `20200110`
, sum(`20200109`) as `20200109`
, sum(`20200108`) as `20200108`
, sum(`20200107`) as `20200107`
, sum(`20200106`) as `20200106`
, sum(`20200105`) as `20200105`
, sum(`20191231`) as `20191231`
, sum(`20191230`) as `20191230`
, sum(`20191229`) as `20191229`
, sum(`20191227`) as `20191227`
, sum(`20191226`) as `20191226`
, sum(`20191225`) as `20191225`
, sum(`20191224`) as `20191224`
, sum(`20191223`) as `20191223`
, sum(`20191222`) as `20191222`
, sum(`20191221`) as `20191221`
, sum(`20191220`) as `20191220`
, sum(`20191219`) as `20191219`
, sum(`20191218`) as `20191218`
, sum(`20191217`) as `20191217`
, sum(`20191216`) as `20191216`
, sum(`20191215`) as `20191215`
, sum(`20191214`) as `20191214`
, sum(`20191213`) as `20191213`
, sum(`20191212`) as `20191212`


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

/*

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

*/

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

