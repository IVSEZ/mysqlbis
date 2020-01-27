SELECT clientcode, clientname, ClientAddress, address, ContractCode, phoneno, mac, natip, username, ContractType, servicetype FROM rcbill.clientcontractdevices where deviceid is not null
and clientcode not in 
(
'I.000007264',
'0006',
'0010',
'T.990006524',
'I.000004181',
'I.000015720',
'91',
'I5168'
)
and clientname not in ('PREPAID CARDS')
;




select clientcode, clientname, count(*) FROM rcbill.clientcontractdevices where deviceid is not null group by clientcode order by 3 desc;

select clientname, count(*) FROM rcbill.clientcontractdevices where deviceid is not null group by clientname order by 2 desc;


SELECT clientcode, clientname, ClientAddress, address, ContractCode, phoneno, mac, natip, username, ContractType, servicetype 
FROM rcbill.clientcontractdevices where deviceid is not null
and clientcode not in 
(
'I.000007264',
'0006',
'0010',
'T.990006524',
'I.000004181',
'I.000015720',
'91',
'I5168'
)
and clientname not in ('PREPAID CARDS')

;


### PRASLIN FAULT CUSTOMERS 23/01/2020
SELECT 
-- * 
CLIENT_CODE, CLIENT_NAME, CLIENT_ADDRESS
, (select a1_parcel from rcbill.rcb_clientparcels where clientcode=a.CLIENT_CODE) as PARCEL1
, (select a2_parcel from rcbill.rcb_clientparcels where clientcode=a.CLIENT_CODE) as PARCEL2
, (select a3_parcel from rcbill.rcb_clientparcels where clientcode=a.CLIENT_CODE) as PARCEL3
, CONTRACT_CODE, FSAN, FSAN2, MAC, MXK_NAME, MXK_INTERFACE, MODEL_ID, MXK_DATE
FROM rcbill_my.customers_mxk a 
where MXK_NAME='MXK-PRASLIN'
and 
(
MXK_INTERFACE like '1-1-5%'
or
MXK_INTERFACE like '1-1-6%'
or
MXK_INTERFACE like '1-1-7%'
or
MXK_INTERFACE like '1-1-8%'
or
MXK_INTERFACE like '1-2-3%'
or
MXK_INTERFACE like '1-2-5%'
or
MXK_INTERFACE like '1-2-6%'
or
MXK_INTERFACE like '1-2-7%'
or
MXK_INTERFACE like '1-2-8%'
or
MXK_INTERFACE like '1-3-2%'
or
MXK_INTERFACE like '1-3-3%'
or
MXK_INTERFACE like '1-4-1%'
)
order by MXK_INTERFACE
;



/*
select distinct clientcode, clientname  FROM rcbill.clientcontractdevices 
where clientcode in 
(
'I.000007264',
'0006',
'0010',
'T.990006524',
'I.000004181',
'I.000015720',
'91',
'I16777',
'I.000010002',
'I5849',
'I.000019887') 
and deviceid is not null;
*/
/*
I.000007264
0006
0010
T.990006524
I.000004181
I.000015720
91
I16777
I.000010002
I5849
I.000019887

*/