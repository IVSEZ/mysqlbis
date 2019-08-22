
select 
a.*, 

CASE 
	when datediff(a.VOD_LASTTIME , a.VOD_FIRSTTIME) < 32 then '< 1 Month' 
	when datediff(a.VOD_LASTTIME , a.VOD_FIRSTTIME) >= 32 and datediff(a.VOD_LASTTIME , a.VOD_FIRSTTIME) < 91 then '1 - 3 Months' 
	when datediff(a.VOD_LASTTIME , a.VOD_FIRSTTIME) >= 91 and datediff(a.VOD_LASTTIME , a.VOD_FIRSTTIME) < 181 then '3 - 6 Months' 
	when datediff(a.VOD_LASTTIME , a.VOD_FIRSTTIME) >= 181 and datediff(a.VOD_LASTTIME , a.VOD_FIRSTTIME) < 366 then '6 - 12 Months' 
	when datediff(a.VOD_LASTTIME , a.VOD_FIRSTTIME) >= 366 then 'Over a year' 
end as VOD_DURATION
from 
(
	select 

	-- a.*


	a.reportdate
	, a.clientcode
	, a.currentdebt
	, a.isaccountactive
	, a.accountactivitystage
	, a.clientname
	, a.clientclass
	, a.activenetwork
	, a.activeservices
	, a.activecontracts
	, a.activesubscriptions
    , a.clientarea
	, a.clientlocation
	, a.clientphone
	, a.clientaddress
	, b.contractpackage
	, (select min(period) from rcbill_my.customercontractactivity where 0=0 and upper(package) in ('VOD') and clientcode=a.clientcode) as VOD_FIRSTTIME
	, (select max(period) from rcbill_my.customercontractactivity where 0=0 and upper(package) in ('VOD') and clientcode=a.clientcode) as VOD_LASTTIME
	from 
	rcbill_my.rep_custconsolidated a 
	left join
	-- rcbill_my.customercontractsnapshot b
	(
		select clientcode, group_concat( distinct package order by contractcode asc separator '|') as contractpackage
		from rcbill_my.customercontractsnapshot
		where servicecategory='OTT'
		and CurrentStatus='Active'
		group by clientcode
	) b
	on
	a.clientcode=b.clientcode


	where a.clientcode in 
	(
	  select distinct clientcode from rcbill_my.customercontractactivity where upper(package) in ('VOD')
	) 
) a 
;


