select * from rcbill.rcb_devices where DevTypeID=103;
select * from rcbill.rcb_devicetypes;


select reportdate, clientcode, currentdebt
, IsAccountActive, AccountActivityStage
, clientname, clientclass, activenetwork, activeservices
, clientaddress, firstactivedate, lastactivedate, dayssincelastactive
, clientemail, clientphone

from rcbill_my.rep_custconsolidated
where clientcode in 
(
	select ClientCode from rcbill.clientcontractdevices
	where DeviceId in 
	(
	select ID from rcbill.rcb_devices where DevTypeID=103
	)
)
;