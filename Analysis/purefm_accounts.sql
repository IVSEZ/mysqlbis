-- select period,periodday,periodmth,periodyear,clientcode,clientname, clientaddress, contractcode, contractaddress,servicecategory,package,price,network,activecount,devicescount
-- from rcbill_my.customercontractactivity where clientname like '%rahul walavalkar%';
--  select * from rcbill_my.activediscounts where clientcode ='I119'
-- select * from rcbill.clientextendedreport where cl_clientcode='I119'
-- select * from rcbill_my.customercontractactivity where clientcode='I119'

select a.period,a.periodday,a.periodmth,a.periodyear,a.clientcode,a.clientname, a.clientaddress, a.contractcode, a.contractaddress
, a.servicecategory,a.package,a.price,a.network,a.activecount,a.devicescount
, b.percent, b.amount, b.upddate, b.approved, b.approvalreason
, c.TotalPaymentAmount, c.LastPaymentDate, c.LastInvoiceDate 
 from rcbill_my.customercontractactivity a
 left join 
 rcbill_my.activediscounts b 
 on a.clientcode=b.clientcode and a.contractcode=b.contractcode and a.package=b.package
 
 left join 
 rcbill.clientextendedreport c 
 on  
 a.clientcode=c.CL_CLIENTCODE 
 where 
 (
 /*
 (clientname like '%isuru%') 
 or 
 (clientname like '%dave furneau%')
 or 
 (clientname like '%Rajive Ellawala%')
 or 
 (clientname like '%chantal Prudence%') 
 or 
 (clientname like '%Giselle Pucheokchuen%') 
  or 
 (clientname like '%Dawn Athanasius%') 
  or 
 (clientname like '%Kitson Julie%') 
  or 
 (clientname like '%Janesta Moses%') 
  or 
 (clientname like '%Nelson Esparon%') 
  or 
 (clientname like '%Heather Prea%') 
  or 
 (clientname like '%Heather Prea%') 

*/

a.clientcode in 
(
'I1871','I312','I.000008407' -- shamir peermohamed
,'I.000013132','I.000008352','I.000006753' -- isuru
,'I.000006089' -- rajive ellawala
,'I.000006181','I.000006182' -- Mrs Bonnelame
, 'I2584' -- Phylis Coeur de Lion
,'I.000005415' -- AZZAFF AZZEEZ
,'I119' -- DERRICK YOUNGKON FOC
,'I.000008119' -- PURE FM
,'I.000006753' -- PURE FM C/O ISURU

-- OTHERS
,'I21368' -- AHMED c/o vipul DIDI
,'I21369' -- AHMED C/O VIPUL DIDI-- acc closed 
,'I21367' -- AHMED DIDI c/o vipul
,'I1144' -- VIPUL KANUMALE - Vision Infinity 
,'I8883' -- VIPUL KANUMALE- C/O SriLankan Airlines  
,'I.000008754' -- ALI NOORDEEN (ANDEEN) C/O VIPUL KANUMALE
,'I.000009076' -- ALI NOORDEEN
,'I.000003586' -- TRISHA TARA DUBIGNON C/O VIPUL KANUMALE 
,'I.000003585' -- TRISHA TARA DUBIGNON C/O VIPUL KANUMALE 
,'I.000012614' -- TRACY BERNADETTE CAMILLE (has email vkanumale@hotmail.com)
,'I9107' -- SILHOUETTE ISLAND RESORT'S LTD (has email vkanumale@hotmail.com)
,'I9061' -- SILHOUETTE ISLAND RESORT - ACC CLOSED
,'I.000006985' -- GERARD COMPLEX , FLAT 4 (has NIN 011-0508-6-1-39)

-- from Jim 10/10/2017
,'I.000002392' -- Tanya Athanasius
,'I.000005766' -- RAMANAN SUNDARALINGAM 
)



 )
 order by a.clientcode, a.contractcode, a.period
 ;