select * from rcbill_my.rep_custconsolidated;
select * from rcbill.rcb_clientparcels;

select a.CLIENTCODE, a.IsAccountActive, a.AccountActivityStage, a.CLIENTNAME, a.clientclass
-- , a.clientaddress
, a.clientlocation, a.clientarea, a.clientemail, a.clientnin
-- , a.dayssincelastactive
, b.address, b.moladdress, b.MOLRegistrationAddress
-- , a1_parcel, a2_parcel, a3_parcel
, case when a1_parcel is null and a2_parcel is null and a3_parcel is null 
	then 'NOT PRESENT'
	else 'PRESENT' end as `PARCEL_PRESENT` 
from 
rcbill_my.rep_custconsolidated a 
left join
rcbill.rcb_clientparcels b
on 
a.CLIENTCODE=b.clientcode
where a.AccountActivityStage not in ('4. Hibernating (31 to 90 days)','5. Dormant (more than 90 days)')
order by 13 asc
;


select  parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
(

	select a.CLIENTCODE, a.IsAccountActive, a.AccountActivityStage, a.CLIENTNAME, a.clientclass
	-- , a.clientaddress
	, a.clientlocation, a.clientarea, a.clientemail, a.clientnin
	-- , a.dayssincelastactive
	, b.address, b.moladdress, b.MOLRegistrationAddress
	-- , a1_parcel, a2_parcel, a3_parcel
	, case when a1_parcel is null and a2_parcel is null and a3_parcel is null 
		then 'NOT PRESENT'
		else 'PRESENT' end as `PARCEL_PRESENT` 
	from 
	rcbill_my.rep_custconsolidated a 
	left join
	rcbill.rcb_clientparcels b
	on 
	a.CLIENTCODE=b.clientcode
	-- where a.AccountActivityStage not in ('4. Hibernating (31 to 90 days)','5. Dormant (more than 90 days)')
	order by 13 asc
) a 
group by parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

