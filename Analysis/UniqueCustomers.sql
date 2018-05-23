

select count(distinct contractcode), count(*),sum(activecount), sum(DEVICESCOUNT) from rcbill_my.customercontractactivity 
where period='2018-02-07' and servicecategory2='TV' and network='GPON' and servicesubcategory not in ('ADDON');

select count(distinct contractcode), count(*),sum(activecount), sum(DEVICESCOUNT) from rcbill_my.customercontractactivity 
where period='2018-01-31' and servicecategory2='TV' and network='GPON' and servicesubcategory not in ('ADDON');