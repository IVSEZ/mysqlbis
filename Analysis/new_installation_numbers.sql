



select * from  rcbill_my.clientticketjourney 
where 0=0
-- and commentuser in ('Rahul Walavalkar') 
-- and (trim(upper(comment)) REGEXP 'FRENCH')
and (trim(upper(comment)) REGEXP 'installation done')
and year(opendate)=2021
order by commentdate desc
;

select * from  rcbill_my.clientticketjourney 
where 0=0
-- and commentuser in ('Rahul Walavalkar') 
-- and (trim(upper(comment)) REGEXP 'FRENCH')
and (trim(upper(comment)) REGEXP 'conversion')
and year(opendate)=2021
order by commentdate desc
;

select * from  rcbill_my.clientticketjourney 
where 0=0
-- and commentuser in ('Rahul Walavalkar') 
-- and (trim(upper(comment)) REGEXP 'FRENCH')
and (trim(upper(comment)) REGEXP 'installation')
and year(opendate)=2021
order by commentdate desc
;

select * from  rcbill_my.clientticketjourney 
where 0=0
-- and commentuser in ('Rahul Walavalkar') 
-- and (trim(upper(comment)) REGEXP 'FRENCH')
-- and (trim(upper(comment)) REGEXP 'installation')
and openreason in ('installation')
and year(opendate)=2021
order by commentdate desc
;


select clientcode, clientname, service, contractcode,closereason, date(OPENDATE) as opendate, count(distinct contractcode) as contracts from  rcbill_my.clientticketjourney 
where 0=0
-- and commentuser in ('Rahul Walavalkar') 
-- and (trim(upper(comment)) REGEXP 'FRENCH')
-- and (trim(upper(comment)) REGEXP 'installation')
and openreason in ('installation')
and year(opendate)=2021
group by 1,2,3,4,5

order by commentdate desc
;

-- select * from rcbill_my.rep_clientcontractdevices where CLIENT_CODE in ('I.000022448');

SELECT a.*, b.*, c.service, c.package, d.clientclass, d.clientaddress, d.clientlocation, d.activenetwork
from 
(
	select clientcode, clientname, service, contractcode,closereason, ticketid, stagetechregion, date(OPENDATE) as opendate, openuser, count(distinct contractcode) as contracts from  rcbill_my.clientticketjourney 
	where 0=0
	-- and commentuser in ('Rahul Walavalkar') 
	-- and (trim(upper(comment)) REGEXP 'FRENCH')
	-- and (trim(upper(comment)) REGEXP 'installation')
	and openreason in ('installation')
	and year(opendate)=2021
	group by 1,2,3,4,5,6

	order by commentdate desc
) a
left join 
(
	select 
	CLIENT_CODE, CONTRACT_CODE, CONTRACT_TYPE, SERVICE_TYPE, SERVICE_ID, CSID, DEVICE_ID, DEVICE_TYPE_ID, DEVICE_NAME, GATEKEEPER_ID, GATEKEEPER_NAME, FSAN, UID, mac, SerNo, username, mac_prefix, MAC_VENDOR
	from 
	rcbill_my.rep_clientcontractdevices
) b
on a.clientcode=b.client_code and a.contractcode=b.contract_code 

left join
rcbill.clientcontractsservicepackageprice c 
on b.contract_code=c.contractcode and b.CSID=c.serviceinstancenumber

left join rcbill_my.rep_custconsolidated d 
on a.CLIENTCODE=d.clientcode

;


select * from rcbill_my.rep_custconsolidated; -- where clientcode in ('I.000022964');