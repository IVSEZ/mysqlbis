use rcbill;

-- I.000022100 as bestcas nas
-- I.000003064 | I.000202203 | 2026815 has conax card

select * from rcbill.rcb_gatekeepers;
select * from rcbill.rcb_devicetypes;
select * from rcbill.rcb_services;
select * from rcbill.clientcontractdevices where ContractId=2260608;
select * from rcbill.rcb_devices where ContractID=2260608;
select * from rcbill.rcb_contractservices where CID=2260608;

select * from rcbill.clientcontractsservicepackageprice where CONTRACT_ID=2260608;


set @clientcode='I.000003064';
set @contractid=2026815;

select * from rcbill.clientcontractdevices where ClientCode=@clientcode;
select * from rcbill.rcb_devices where ContractID=@contractid;
select * from rcbill.rcb_contractservices where CID=@contractid;
select * from rcbill.clientcontractsservicepackageprice where CONTRACT_ID=@contractid;

select * from rcbill.rcb_vpnrates;
select * from rcbill.rcb_gatekeepers;
select * from rcbill.rcb_devicetypes;
select * from rcbill.rcb_services;


select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where clientcode='I.000022100';