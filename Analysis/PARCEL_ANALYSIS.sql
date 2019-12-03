select * from rcbill_my.rep_custconsolidated;
select * from rcbill.rcb_clientparcels;

drop table if exists rcbill_my.rep_parcelextract;

create table rcbill_my.rep_parcelextract
as 
(
	select a.CLIENTCODE, a.IsAccountActive, a.AccountActivityStage, a.CLIENTNAME, a.clientclass
	-- , a.clientaddress
	, a.clientlocation, a.clientarea, a.clientemail, a.clientnin
	-- , a.dayssincelastactive
	, b.address, b.moladdress, b.MOLRegistrationAddress
    , a.dayssincelastactive
	-- , a1_parcel, a2_parcel, a3_parcel
	, case when a1_parcel is null and a2_parcel is null and a3_parcel is null 
		then 'NOT PRESENT'
		else 'PRESENT' end as `PARCEL_PRESENT` 
	, case when clientemail is null  
		then 'NOT PRESENT'
		else 'PRESENT' end as `EMAIL_PRESENT` 
	, case when clientnin is null  
		then 'NOT PRESENT'
		when locate("-",clientnin)=0 then 'INVALID'
		else 'PRESENT' end as `NIN_PRESENT`
	, case when address is null and moladdress is null and MOLRegistrationAddress is null 
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
	order by 14 asc
)
;

select * from rcbill_my.rep_parcelextract;

select  parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_parcelextract a 
group by parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;



select  parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_parcelextract a
where a.dayssincelastactive<=365 
group by parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

select  email_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_parcelextract a 
group by email_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

select  nin_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_parcelextract a 
group by nin_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

select  ONE_YEAR
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_parcelextract a 
group by ONE_YEAR
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;