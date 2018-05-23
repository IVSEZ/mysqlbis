use rcbill_my;
/*
select a.clientcode, a.contractcode, a.period,a.periodday,a.periodmth,a.periodyear,a.ACTIVECOUNT,
a.CLIENTCLASS, a.clienttype, a.SERVICECATEGORY, a.SERVICESUBCATEGORY, a.SERVICETYPE,a.REGION, a.REPORTED,
b.contractaddress, b.contractlocation

from rcbill_my.dailyactivenumber a 
inner join
rcbill.rcb_contractaddress b
on 
a.CONTRACTCODE=b.contractcode 
 
 where a.period in ('2017-07-23');
 */
 
 select * from rcbill.rcb_clientaddress order by clientname;
             SELECT clientid, clientcode, clientname, clientaddress, min(clientlocation) cl_location
            FROM    rcbill.rcb_clientaddress
            GROUP BY clientcode
            order by clientcode;
            

 select * from rcbill.rcb_contractaddress order by contractcode;
             SELECT contractid, contractcode, contractaddress, min(contractlocation) con_location
            FROM    rcbill.rcb_contractaddress
            GROUP BY ContractCode
            order by ContractCode;
            
 

 
 
 select distinct a.settlementname, a.areaname, b.latitude, b.longitude,
b.geoname, b.featureclass,b.featurecode
from 
rcbill.rcb_address a 
left join
rcbill.geoname_sc b
on
a.settlementname=b.geoname
and 
(b.featureclass in ('A') or b.featurecode in ('ISL','PPL','PPLC'))
where
a.AREANAME not in ('SEYCHELLES','SANS SOUCI ROAD','M')
group by a.settlementname, a.areaname
order by a.SETTLEMENTNAME

;

 select * from rcbill.rcb_contractaddress;
 
 select distinct contractcode, contractaddress, count(*) from rcbill.rcb_contractaddress 
 group by contractcode, ContractAddress
 ;
 