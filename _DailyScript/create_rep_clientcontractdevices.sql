use rcbill_my;

-- select * from rcbill.rcb_gatekeepers

drop table if exists rcbill_my.rep_clientcontractdevices;

create table rcbill_my.rep_clientcontractdevices(INDEX idxrccd1 (MAC), INDEX idxrccd2 (UID), INDEX idxrccd3 (CLIENT_CODE), INDEX idxrccd4 (CONTRACT_CODE), INDEX idxrccd5 (FSAN), INDEX idxrccd6(SERVICE_TYPE)) as 
(

	select 
	clientid as CLIENT_ID,
	clientcode as CLIENT_CODE,
	trim(upper(clientname)) as CLIENT_NAME,
	trim(upper(ClientAddress)) as CLIENT_ADDRESS,
	ContractId as CONTRACT_ID,
	ContractCode as CONTRACT_CODE,
	ContractType as CONTRACT_TYPE,
	ServiceType as SERVICE_TYPE,
    ServiceId as SERVICE_ID,
    DeviceId as DEVICE_ID,
    DevTypeID as DEVICE_TYPE_ID,
    (select `name` from rcbill.rcb_devicetypes rd where rd.id=ccd.DevTypeID) as DEVICE_NAME,
    ccd.GKID as GATEKEEPER_ID,
    (select `name` from rcbill.rcb_gatekeepers gk where gk.ID=ccd.GKID) as GATEKEEPER_NAME,
    -- (select `name` from rcbill.rcb_gatekeepers gak where gak.﻿id=ccd.GKID) as GATEKEEPER_NAME,
    NATIP as FSAN,
	mac as MAC,
	phoneno as UID,
    username as username
	from rcbill.clientcontractdevices ccd where ccd.deviceid is not null
	order by ClientId
    
);

select count(*) as rep_clientcontractdevices from rcbill_my.rep_clientcontractdevices;

-- select * from rcbill_my.rep_clientcontractdevices;

-- select * from rcbill.rcb_gatekeepers where gkid=4;