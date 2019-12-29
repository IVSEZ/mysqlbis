select * from rcbill.rcb_useractions order by ID desc limit 100;

select * from rcbill.rcb_users where `name` like '%- Intern';
select * from rcbill.rcb_tickettechusers;

select *
, (select name from rcbill.rcb_tickettechusers where RCBUSERID=a.userid) as username
, rcbill.GetClientCode(clid) as ClientCode, rcbill.GetClientNameFromID(clid) as ClientName from rcbill.rcb_useractions a where userid in (select id from rcbill.rcb_users where `name` like '%- Intern');


use rcbill_my;
drop table if exists rcbill_my.tempcompare;

create table rcbill_my.tempcompare as 
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191212
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191213
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191214
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191215
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191216
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191217
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191218
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191219
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191220
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191221
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191222
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191223
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191224
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191225
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191226
)
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191227
)
/*
union  
(
	select orig_reportdate, orig_CLIENTCODE, reportdate, CLIENTCODE, IsAccountActive, AccountActivityStage, CLIENTNAME, clientclass, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT, ONE_YEAR, CLIENT_STATUS, ACCOUNT_ACTIVITY_STATUS, CLIENT_NAME_STATUS, CLIENT_CLASS_STATUS, CLIENT_ADDRESS_STATUS, CLIENT_LOCATION_STATUS, CLIENT_AREA_STATUS, CLIENT_EMAIL_STATUS, CLIENT_NIN_STATUS, CLIENT_PHONE_STATUS, ADDRESS_STATUS, MOL_ADDRESS_STATUS, MOLREG_ADDRESS_STATUS, A1_PARCEL_STATUS, A2_PARCEL_STATUS, A3_PARCEL_STATUS, PARCEL_ADD_STATUS
	from rcbill_my.rep_custextract_compare20191228
)*/
;

	
CREATE INDEX idxtc1 ON rcbill_my.tempcompare (clientcode);

select * from rcbill_my.tempcompare;

select a.*, b.*
from 
(
select *
, (select name from rcbill.rcb_tickettechusers where RCBUSERID=a.userid) as username
, rcbill.GetClientCode(clid) as ClientCode, rcbill.GetClientNameFromID(clid) as ClientName from rcbill.rcb_useractions a where userid in (select id from rcbill.rcb_users where `name` like '%- Intern')
) a 
inner join
rcbill_my.tempcompare b 
on a.CLIENTCODE=b.clientcode
;

