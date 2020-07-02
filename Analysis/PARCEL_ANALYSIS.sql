select * from rcbill_my.rep_custconsolidated;


select * from rcbill.rcb_clientparcels;

/*
set SQL_SAFE_UPDATES=0;
delete from rcbill.rcb_clientparcelcoords where date(INSERTEDON)=date(now());
*/

select date(insertedon) as dateinserted, count(clientparcel) as parcels
from rcbill.rcb_clientparcelcoords 
where latitude<>0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))
;

select date(insertedon) as dateinserted, count(clientparcel) as parcels
from rcbill.rcb_clientparcelcoords 
group by 1
order by 1 desc
;




select * from rcbill.rcb_clientparcelcoords where date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords));
select * from rcbill.rcb_clientparcelcoords where latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords));

select * from rcbill.rcb_clientparcelcoords where latitude = 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords));


####### parcel extract for maps
select a.latitude as lat, a.longitude as lng
-- , concat(a.clientcode, ':', a.clientname, '[',a.clientparcel,']') as `name`
,
/*
case when a.isaccountactive='InActive' then '#00FF00'
else '#ff0000' end as `color`
*/
case when a.activenetwork is null then '#ff0000'
when a.activenetwork='HFC' then '#0000ff' 
when a.activenetwork='GPON' then '#00ff00' end as `color`
, concat(a.clientcode, ':', a.clientname, '[',a.clientparcel,'] ', a.AccountActivityStage,'|',a.clientclass,'|', a.activenetwork,'|',a.activeservices,'|',a.activecontracts,'|',a.activesubscriptions) as `note`
from
(
	select a.*
	-- , b.*
	, b.IsAccountActive, b.AccountActivityStage, b.clientclass, b.activenetwork, b.activeservices, b.activecontracts, b.activesubscriptions

	from
	(
	select * from rcbill.rcb_clientparcelcoords where latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))
	) a 
	left join 
	rcbill_my.rep_custconsolidated b
	on 
	a.clientcode=b.clientcode
) a 
 limit 900
;

###############################





select date(insertedon) as inserteddate
, count(clientcode) as clients
from rcbill.rcb_clientparcelcoords
group by 1
order by 1 desc
;  

select date(insertedon) as inserteddate
, case when coord_x='MISSING' then 'INVALID'
		else 'VALID' 
        end as `PARCEL_STATUS`

, count(clientcode) as clients
from rcbill.rcb_clientparcelcoords
group by 1,2
order by 1 desc
;  


select clientcode, clientname, clientparcel
-- , a1_parcel, a2_parcel, a3_parcel, NULLIF(a1_parcel,''), NULLIF(a2_parcel,''), NULLIF(a3_parcel,'') 
-- , ifnull(NULLIF(a1_parcel,''),ifnull(NULLIF(a2_parcel,''),NULLIF(a3_parcel,''))) as PARCEL
from rcbill.rcb_clientparcels
where clientparcel is not null
; 

select * from rcbill_my.matched_clients group by DEDUPE_CLIENT_CODE;


select * from rcbill_my.rep_custconsolidated;

drop table if exists rcbill_my.rep_custextract;


create table rcbill_my.rep_custextract (index idxrce1 (clientcode))
as 
(
	select a.reportdate, a.CLIENTCODE, a.IsAccountActive, a.AccountActivityStage, a.CLIENTNAME, a.clientclass
	, a.clientaddress
	, a.clientlocation, a.clientarea
    , a.clientemail
    , a.activenetwork
    
    -- , 'a@a.com' as clientemail
    , a.clientnin, a.clientphone
	-- , a.dayssincelastactive
	, b.address, b.moladdress, b.MOLRegistrationAddress
    , a.dayssincelastactive
	, b.a1_parcel, b.a2_parcel, b.a3_parcel
	, case when (b.a1_parcel is null or length(b.a1_parcel)=0) and (b.a2_parcel is null or length(b.a2_parcel)=0) and (b.a3_parcel is null or length(b.a3_parcel)=0) 
		then 'NOT PRESENT'
		else 'PRESENT' end as `PARCEL_PRESENT` 
	, case when a.clientemail is null or length(a.clientemail)=0
		then 'NOT PRESENT'
		else 'PRESENT' end as `EMAIL_PRESENT` 
	, case when a.clientnin is null or length(a.clientnin)=0 
		then 'NOT PRESENT'
		when locate("-",a.clientnin)=0 then 'INVALID'
		else 'PRESENT' end as `NIN_PRESENT`
	, case when (a.clientaddress is null or length(a.clientaddress)=0) and (b.address is null or length(b.address)=0) and (b.moladdress is null or length(b.moladdress)=0) and (b.MOLRegistrationAddress is null or length(b.MOLRegistrationAddress)=0)
		then 'NOT PRESENT'
		else 'PRESENT' end as `ADDRESS_PRESENT`
    , case when a.dayssincelastactive <=365 
		then 'ONE YEAR'
		else 'MORE THAN ONE YEAR' end as `ONE_YEAR`

	from 
	rcbill_my.rep_custconsolidated a 
	left join
	rcbill.rcb_clientparcels b
	on 
	a.CLIENTCODE=b.clientcode
	-- where a.AccountActivityStage not in ('4. Hibernating (31 to 90 days)','5. Dormant (more than 90 days)')
	-- where a.AccountActivityStage in ('4. Hibernating (31 to 90 days)','5. Dormant (more than 90 days)')
	order by 3 asc, 16 asc
)
;

-- show index from rcbill_my.rep_custextract;
select * from rcbill_my.rep_custextract;
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR'; -- and clientclass='CORPORATE LARGE';
select * from rcbill_my.rep_custextract where PARCEL_PRESENT='PRESENT'; -- and clientclass='CORPORATE LARGE';
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and PARCEL_PRESENT='NOT PRESENT' and clientclass in ('CORPORATE BULK','CORPORATE'); -- and clientclass='CORPORATE LARGE';

### to put in a table to verify data against.
-- drop table if exists rcbill_my.rep_custextract20191211;
/*
create table rcbill_my.rep_custextract20191211(index idxrceorig1 (orig_clientcode)) as 
(
select 
reportdate as orig_reportdate,
CLIENTCODE as orig_CLIENTCODE,
IsAccountActive as orig_IsAccountActive,
AccountActivityStage as orig_AccountActivityStage,
CLIENTNAME as orig_CLIENTNAME,
clientclass as orig_clientclass,
clientaddress as orig_clientaddress,
clientlocation as orig_clientlocation,
clientarea as orig_clientarea,
clientemail as orig_clientemail,
clientnin as orig_clientnin,
clientphone as orig_clientphone,
address as orig_address,
moladdress as orig_moladdress,
MOLRegistrationAddress as orig_MOLRegistrationAddress,
dayssincelastactive as orig_dayssincelastactive,

a1_parcel as orig_a1_parcel,
a2_parcel as orig_a2_parcel,
a3_parcel as orig_a3_parcel,

PARCEL_PRESENT as orig_PARCEL_PRESENT,
EMAIL_PRESENT as orig_EMAIL_PRESENT,
NIN_PRESENT as orig_NIN_PRESENT,
ADDRESS_PRESENT as orig_ADDRESS_PRESENT,
ONE_YEAR as orig_ONE_YEAR
from rcbill_my.rep_custextract
);

-- show index from rcbill_my.rep_custextract20191211;
*/


###COMPARE DAILY EXTRACT AGAINST CUSTOMER EXTRACT FROM 11/12/2019
select * from rcbill_my.rep_custextract20191211; -- where orig_clientcode='I.000011750';


########################################################################################

-- drop table if exists rcbill_my.rep_custextract_compare20200422;

create table rcbill_my.rep_custextract_compare20200624 as 
(
	select -- a.*,b.*
		a.orig_reportdate , b.reportdate ,
		a.orig_CLIENTCODE , b.CLIENTCODE ,
		a.orig_IsAccountActive , b.IsAccountActive ,
		a.orig_AccountActivityStage , b.AccountActivityStage ,
		a.orig_CLIENTNAME , b.CLIENTNAME ,
        b.activenetwork , 
		a.orig_clientclass , b.clientclass ,
		a.orig_clientaddress , b.clientaddress ,
		a.orig_clientlocation , b.clientlocation ,
		a.orig_clientarea , b.clientarea ,
		a.orig_clientemail , b.clientemail ,
		a.orig_clientnin , b.clientnin ,
		a.orig_clientphone , b.clientphone ,
		a.orig_address , b.address ,
		a.orig_moladdress , b.moladdress ,
		a.orig_MOLRegistrationAddress , b.MOLRegistrationAddress ,
		a.orig_dayssincelastactive , b.dayssincelastactive ,
		a.orig_a1_parcel , b.a1_parcel ,
		a.orig_a2_parcel , b.a2_parcel ,
		a.orig_a3_parcel , b.a3_parcel ,
		a.orig_PARCEL_PRESENT , b.PARCEL_PRESENT ,
		a.orig_EMAIL_PRESENT , b.EMAIL_PRESENT ,
		a.orig_NIN_PRESENT , b.NIN_PRESENT ,
		a.orig_ADDRESS_PRESENT , b.ADDRESS_PRESENT ,
		a.orig_ONE_YEAR , b.ONE_YEAR 
	
    , case when orig_clientcode is NULL and clientcode is NOT NULL then 'New Client'
		else 'Existing Client'
		end as `CLIENT_STATUS`
	, case when orig_IsAccountActive=IsAccountActive then 'Same Account Activity'
		else 'Changed Account Activity'
		end as `ACCOUNT_ACTIVITY_STATUS`
	, case when orig_CLIENTNAME=CLIENTNAME then 'Same Client Name'
		else 'Changed Client Name'
		end as `CLIENT_NAME_STATUS`
	, case when orig_clientclass is NULL and clientclass is NULL then 'Same Client Class'
		   when orig_clientclass=clientclass then 'Same Client Class'
		   else 'Changed Client Class'
		end as `CLIENT_CLASS_STATUS`
	, case when orig_clientaddress is NULL and clientaddress is NULL then 'Same Client Address'
		when orig_clientaddress=clientaddress then 'Same Client Address'
		else 'Changed Client Address'
		end as `CLIENT_ADDRESS_STATUS`
	, case when orig_clientlocation is NULL and clientlocation is NULL then 'Same Client Location' 
		when orig_clientlocation=clientlocation then 'Same Client Location'
		else 'Changed Client Location'
		end as `CLIENT_LOCATION_STATUS`
	, case when orig_clientarea is NULL and clientarea is NULL then 'Same Client Area' 
		when orig_clientarea=clientarea then 'Same Client Area'
		else 'Changed Client Area'
		end as `CLIENT_AREA_STATUS`
	, case when (orig_clientemail is NULL or length(orig_clientemail)=0) and (clientemail is NULL or length(clientemail)=0) then 'Client Email Not Present' 
		when (orig_clientemail is NULL or length(orig_clientemail)=0) and (clientemail  is NOT NULL or length(clientemail)>0) then 'Client Email Added'
		when orig_clientemail=clientemail  then 'Same Client Email'
		else 'Changed Client Email'
		end as `CLIENT_EMAIL_STATUS`
	, case when (orig_clientnin is NULL or length(orig_clientnin)=0) and (clientnin is NULL or length(clientnin)=0) then 'Client NIN Not Present' 
		when (orig_clientnin is NULL or length(orig_clientnin)=0) and (clientnin  is NOT NULL or length(clientnin)>0) then 'Client NIN Added'
		when orig_clientnin=clientnin  then 'Same Client NIN'
		else 'Changed Client NIN'
		end as `CLIENT_NIN_STATUS`
	, case when (orig_clientphone is NULL or length(orig_clientphone)=0) and (clientphone is NULL or length(clientphone)=0) then 'Client Phone Not Present' 
		when (orig_clientphone is NULL or length(orig_clientphone)=0) and (clientphone  is NOT NULL or length(clientphone)>0) then 'Client Phone Added'
		when orig_clientphone=clientphone  then 'Same Client Phone'
		else 'Changed Client Phone'
		end as `CLIENT_PHONE_STATUS`
	, case when orig_address is NULL and address is NULL then 'Same Address' 
		when orig_address=address then 'Same Address'
		else 'Changed Address'
		end as `ADDRESS_STATUS`
	, case when orig_moladdress is NULL and moladdress is NULL then 'Same MOL Address' 
		when orig_moladdress=moladdress then 'Same MOL Address'
		else 'Changed MOL Address'
		end as `MOL_ADDRESS_STATUS`
	, case when orig_MOLRegistrationAddress is NULL and MOLRegistrationAddress is NULL then 'Same MOL REG Address' 
		when orig_MOLRegistrationAddress=MOLRegistrationAddress then 'Same MOL REG Address'
		else 'Changed MOL REG Address'
		end as `MOLREG_ADDRESS_STATUS`
	, case when (orig_a1_parcel is NULL or length(orig_a1_parcel)=0) and (a1_parcel is NULL or length(a1_parcel)=0) then 'A1 Parcel Not Present' 
		when (orig_a1_parcel is NULL or length(orig_a1_parcel)=0) and (a1_parcel is NOT NULL or length(a1_parcel)>0) then 'A1 Parcel Added'
		when orig_a1_parcel=a1_parcel then 'Same A1 Parcel'
		else 'A1 Parcel Changed'
		end as `A1_PARCEL_STATUS`
	, case when (orig_a2_parcel is NULL or length(orig_a2_parcel)=0) and (a2_parcel is NULL or length(a2_parcel)=0) then 'A2 Parcel Not Present' 
		when (orig_a2_parcel is NULL or length(orig_a2_parcel)=0) and (a2_parcel is NOT NULL or length(a2_parcel)>0) then 'A2 Parcel Added'
		when orig_a2_parcel=a2_parcel then 'Same A2 Parcel'
		else 'A2 Parcel Changed'
		end as `A2_PARCEL_STATUS`
	, case when (orig_a3_parcel is NULL or length(orig_a3_parcel)=0) and (a3_parcel is NULL or length(a3_parcel)=0) then 'A3 Parcel Not Present' 
		when (orig_a3_parcel is NULL or length(orig_a3_parcel)=0) and (a3_parcel is NOT NULL or length(a3_parcel)>0) then 'A3 Parcel Added'
		when orig_a3_parcel=a3_parcel then 'Same A3 Parcel'
		else 'A3 Parcel Changed'
		end as `A3_PARCEL_STATUS`
	, case when orig_PARCEL_PRESENT is NULL and PARCEL_PRESENT ='NOT PRESENT' then 'Parcel Not Present' 
		when orig_PARCEL_PRESENT = 'NOT PRESENT' and PARCEL_PRESENT ='NOT PRESENT' then 'Parcel Not Present'
        when orig_PARCEL_PRESENT = 'NOT PRESENT' and PARCEL_PRESENT ='PRESENT' then 'Parcel Added'
		else 'Parcel Present'
        end as `PARCEL_ADD_STATUS`

	from 
	rcbill_my.rep_custextract20191211 a 
	right join
	rcbill_my.rep_custextract b 
	on 
	a.orig_clientcode=b.clientcode
)
;

select * from rcbill_my.rep_custextract_compare20200624 where 0=0 ;

select * from rcbill_my.rep_custextract_compare20200624 where 0=0 and ONE_YEAR='ONE YEAR';

select * from rcbill_my.rep_custextract_compare20200624 where 0=0 and ONE_YEAR='ONE YEAR' and clientname like '%STAFF%';

select 
reportdate, clientcode, CLIENTNAME, isaccountactive, AccountActivityStage
, clientclass, clientaddress, clientlocation, clientemail, clientnin, clientphone
, a1_parcel, a2_parcel, a3_parcel
, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT,ONE_YEAR, CLIENT_STATUS   
from rcbill_my.rep_custextract_compare20200624 
where 0=0 
and ONE_YEAR='ONE YEAR' 
and ( clientname like '%STAFF%' or clientclass in ('CORPORATE BULK','CORPORATE BUNDLE','CORPORATE'))
-- and IsAccountActive='Active' 
and clientclass not in ('EMPLOYEE')
-- and PARCEL_PRESENT='PRESENT'
;




-- select client_nin_status, nin_present, count(*) from rcbill_my.rep_custextract_compare20200114 group by 1,2;
-- select * from rcbill_my.rep_custextract_compare20200114 where client_nin_status='Changed Client NIN' and nin_present='NOT PRESENT';

-- =======
select * from rcbill_my.rep_custextract where CLIENTCODE in 
(

	select clientcode from rcbill_my.rep_custextract_compare20200204 where 0=0 
-- 	select clientcode from rcbill_my.rep_custextract_compare20200127 where 0=0 
--    and clientclass='EMPLOYEE'
-- 	and one_year='ONE YEAR'
	
    and
	(
		(	
			CLIENT_PHONE_STATUS='Client Phone Not Present'
		)	
	or 
		(
			nin_present='NOT PRESENT' or nin_present='INVALID'
		)
	or
		(
			email_present='NOT PRESENT'
		)
	
	or 
		(
			address_present='NOT PRESENT'
		)
	or 
		(
			PARCEL_PRESENT='NOT PRESENT'
        )
	
	)
    
)
;


select * from rcbill_my.rep_custextract_compare20200202 where 0=0 

-- and client_status='New Client'
and client_status='Existing Client'
-- and client_nin_status='Client NIN Not Present' and nin_present='INVALID'
and
(
/*
client_name_status like '%CHANGED%'
or client_address_status like '%CHANGED%'
or client_location_status like '%CHANGED%'
or client_area_status like '%CHANGED%'
or client_email_status like '%CHANGED%'
or */client_nin_status like '%CHANGED%'
/*or client_phone_status like '%CHANGED%'
or address_status like '%CHANGED%'
or mol_address_status like '%CHANGED%'
or molreg_address_status like '%CHANGED%'
or a1_parcel_status like '%CHANGED%'
or a2_parcel_status like '%CHANGED%'
or a3_parcel_status like '%CHANGED%'
or parcel_add_status like '%CHANGED%'
*/

/*or 
client_name_status like '%ADDED%'
or client_address_status like '%ADDED%'
or client_location_status like '%ADDED%'
or client_area_status like '%ADDED%'
or client_email_status like '%ADDED%'
*/or client_nin_status like '%ADDED%'
/*or client_phone_status like '%ADDED%'
or address_status like '%ADDED%'
or mol_address_status like '%ADDED%'
or molreg_address_status like '%ADDED%'
or a1_parcel_status like '%ADDED%'
or a2_parcel_status like '%ADDED%'
or a3_parcel_status like '%ADDED%'
or parcel_add_status like '%ADDED%'
*/
)

;



########################################################################################
/*
COMMENTED AS THIS IS IN THE DATA_CLEANUP_STATS FILE


set @tablename='rcbill_my.rep_custextract_compare20191217';

SET @qs = CONCAT('SELECT * FROM ', @tablename);
PREPARE ps FROM @qs;
EXECUTE ps;

*/

/*

select * from rcbill_my.rep_custextract_compare20200109 where 0=0 
and CLIENTCLASS like '%CORP%'

-- and client_nin_status='Client NIN Not Present' and nin_present='INVALID'
;


*/


/*
select CLIENT_STATUS
, CLIENT_NAME_STATUS
, count(*) from rcbill_my.rep_custextract_compare20191213
group by 1, 2 ,3,4,5,6,7,8,9,10
with rollup
;

select CLIENT_STATUS
, CLIENT_CLASS_STATUS
, count(*) from rcbill_my.rep_custextract_compare20191213
group by 1, 2
with rollup
;

select CLIENT_STATUS
, CLIENT_ADDRESS_STATUS
, count(*) from rcbill_my.rep_custextract_compare20191213
group by 1, 2
with rollup
;

select CLIENT_STATUS
, CLIENT_LOCATION_STATUS
, count(*) from rcbill_my.rep_custextract_compare20191213
group by 1, 2
with rollup
;


select CLIENT_STATUS
, CLIENT_AREA_STATUS
, count(*) from rcbill_my.rep_custextract_compare20191213
group by 1, 2
with rollup
;


select CLIENT_STATUS
, CLIENT_EMAIL_STATUS
, count(*) from rcbill_my.rep_custextract_compare20191213
group by 1, 2
with rollup
;

select CLIENT_STATUS
, CLIENT_NIN_STATUS
, NIN_PRESENT
, count(*) from rcbill_my.rep_custextract_compare20191213
group by 1, 2, 3
with rollup
;


select CLIENT_STATUS
, CLIENT_PHONE_STATUS
, count(*) from rcbill_my.rep_custextract_compare20191213
group by 1, 2
with rollup
;

select CLIENT_STATUS
, PARCEL_ADD_STATUS
, count(*) from rcbill_my.rep_custextract_compare20191213
group by 1, 2
with rollup
;
*/


/*

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_CLASS_STATUS, count(*) from ', @tablename, ' group by 1, 2 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_ADDRESS_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_LOCATION_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_AREA_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_EMAIL_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, count(*) from ', @tablename, ' group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, CLIENT_PHONE_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select CLIENT_STATUS, PARCEL_ADD_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;





-- select distinct clientclass from rcbill_my.rep_custextract;
-- select * from rcbill_my.rep_custextract where clientclass in ('CORPORATE LITE','CORPORATE LARGE','CORPORATE','VIP');

#### PARCEL PRESENT
select  parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
group by parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

select  parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a
where a.dayssincelastactive<=365 
group by parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

#### EMAIL PRESENT
select  email_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
group by email_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

select  email_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
where a.dayssincelastactive<=365 
group by email_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

#### NIN PRESENT
select  nin_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
group by nin_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

select  nin_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
where a.dayssincelastactive<=365 
group by nin_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

#### ADDRESS PRESENT
select  ADDRESS_PRESENT
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
group by ADDRESS_PRESENT
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

select  ADDRESS_PRESENT
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
where a.dayssincelastactive<=365 
group by ADDRESS_PRESENT
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;


## ONE YEAR
select  ONE_YEAR
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
group by ONE_YEAR
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

*/

