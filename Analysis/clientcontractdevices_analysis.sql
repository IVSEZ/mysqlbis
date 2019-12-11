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