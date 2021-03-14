select inventorynumber , count(*) from rcbill_extract.IV_INVENTORY group by 1 order by 2 desc;
select SERIALNUMBER , count(*) from rcbill_extract.IV_INVENTORY group by 1 order by 2 desc;

select * from rcbill_extract.IV_INVENTORY where INVENTORYNUMBER in 
(
'00.02.71.9a.99.ac'
)
;


select * from rcbill_extract.IV_INVENTORY where SERIALNUMBER in 
(
'31a6008'
)
;


select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCENUMBER in ('SIN_4340272_504621','SIN_4279951_525982','SIN_4433368_531896','SIN_4415751_558128');

select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in ('CA_I.000003703');

select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where CLIENT_ID in (715597);

select * from rcbill_my.rep_clientcontractdevices where CLIENT_ID in (715597);

select * from rcbill.clientcontractsservicepackageprice where CLIENT_ID in (715597) and CONTRACT_ID in (1337208);
select * from rcbill.clientcontractdevices where ClientId in  (715597) and ContractId in (1337208);
select * from rcbill.rcb_devices where ContractID in (1337208);

select * from rcbill.rcb_contractservices where CID in (1337208);