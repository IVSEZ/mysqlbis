select distinct a.period, 
-- a.clientclass, 
a.clienttype, 
a.servicecategory, a.servicesubcategory, a.servicetype, 
a.cl_location, a.cl_latitude, a.cl_longitude,
count(a.clientcode) as clients, sum(activecount) as activecontracts
from 
(
select 
a.period, a.contractcode, a.clientcode, a.clientname, a.clientclass, a.clienttype, a.representative, a.servicecategory, a.servicesubcategory, a.servicetype, 
a.price, a.region, a.ACTIVECOUNT, a.DEVICESCOUNT, a.REPORTED
 , b.clientaddress, b.cl_location, b.cl_area 
 , d.areaname as cl_areaname, d.latitude as cl_latitude, d.longitude as cl_longitude
, c.contractaddress, c.con_location , c.con_area
, e.areaname as con_areaname, e.latitude as con_latidue, e.longitude as con_longitude

from
rcbill_my.dailyactivenumber a
left join 
(
			SELECT clientcode, clientaddress, min(clientlocation) as cl_location, min(ClientArea) as cl_area
            FROM    rcbill.rcb_clientaddress
            GROUP BY clientcode
            order by clientcode
) b
on
a.clientcode=b.clientcode
left join
(
			SELECT contractcode, contractaddress, min(contractlocation) as con_location, min(ContractArea) as con_area
            FROM    rcbill.rcb_contractaddress
            GROUP BY ContractCode
            order by ContractCode
) c
on 
a.contractcode=c.contractcode
left join
(
		select distinct x.settlementname, x.areaname, y.latitude, y.longitude,
		y.geoname, y.featureclass,y.featurecode
		from 
		rcbill.rcb_address x 
		left join
		rcbill.geoname_sc y
		on
		x.settlementname=y.geoname
		and 
		(y.featureclass in ('A') or y.featurecode in ('ISL','PPL','PPLC'))
		where
		x.AREANAME not in ('SEYCHELLES','SANS SOUCI ROAD','M')
		group by x.settlementname, x.areaname
		order by x.SETTLEMENTNAME
) d
on (b.cl_location=d.settlementname and b.cl_area=d.areaname)

left join
(
		select distinct x.settlementname, x.areaname, y.latitude, y.longitude,
		y.geoname, y.featureclass,y.featurecode
		from 
		rcbill.rcb_address x 
		left join
		rcbill.geoname_sc y
		on
		x.settlementname=y.geoname
		and 
		(y.featureclass in ('A') or y.featurecode in ('ISL','PPL','PPLC'))
		where
		x.AREANAME not in ('SEYCHELLES','SANS SOUCI ROAD','M')
		group by x.settlementname, x.areaname
		order by x.SETTLEMENTNAME
) e
on (c.con_location=e.settlementname and c.con_area=e.areaname)

where a.period=@rundate and a.reported='Y'
) a

group by 
a.period, 
-- a.clientclass, 
a.clienttype, 
a.servicecategory, a.servicesubcategory, a.servicetype, 
a.cl_location, a.cl_latitude, a.cl_longitude
;