
select * from rcb_devicetypes;

select * from rcb_devices 
where contractid in
(select id from rcb_contracts where clid in (724413));

select count(*) from rcb_devices 
where contractid in
(select id from rcb_contracts where clid in (724413));

select contractid, devtypeid, mac, serno from rcb_devices;


select * from rcb_devicesold 
where contractid in
(select id from rcb_contracts where clid in (724413));

select * from clientcontracts where cl_clientid in (715413);

select * from clientcontracts where CON_CONTRACTID in (
select contractid from rcb_devices 
where contractid in
(select id from rcb_contracts where clid in (715413)));

select * from rcb_devicesold where contractid in 
(select contractid from rcb_devices where contractid in (select id from rcb_contracts where clid in (715413)));

