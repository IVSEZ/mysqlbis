/*
drop table if exists rcbill_my.customercontractactivity;

 create table rcbill_my.customercontractactivity as 
 (
	select a.clientcode, a.contractcode, a.period, a.periodday, a.periodmth, a.periodyear
,a.SERVICECATEGORY,a.SERVICESUBCATEGORY,a.SERVICETYPE
,c.contractaddress, c.con_location 
, e.areaname as con_area, e.latitude as con_latidue, e.longitude as con_longitude
from rcbill_my.dailyactivenumber a
left join
(
             SELECT contractcode, contractaddress, min(contractlocation) as con_location
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
) e
on c.con_location=e.settlementname 
where 
a.clientcode in (select distinct clientcode from rcbill_my.dailyactivenumber)
order by a.SERVICECATEGORY,a.contractcode, a.period, a.periodday, a.periodmth, a.periodyear
 )
 ;
 
DROP INDEX `IDXcca1` ON rcbill_my.customercontractactivity;
CREATE INDEX IDXcca1
ON rcbill_my.customercontractactivity (clientcode);

 
 select * from rcbill_my.customercontractactivity where clientcode='I.000011750';

rename table rcbill_my.activeccl1 to rcbill_my.customercontractactivity;
*/
 
-- rename table rcbill_my.customercontractactivity to rcbill_my.customercontractactivityold;
 
-- select count(*) from rcbill_my.customercontractactivityold;
 
 
drop table if exists rcbill_my.customercontractactivity; 

create table rcbill_my.customercontractactivity as 
(
select 
a.period, a.periodday, a.periodmth, a.PERIODYEAR, a.clientcode, a.clientname, a.clientclass, a.clienttype, a.representative
, b.clientaddress, b.cl_location, b.cl_area 
, d.areaname as cl_areaname, d.latitude as cl_latitude, d.longitude as cl_longitude
, a.contractcode
, c.contractaddress, c.con_location , c.con_area
, e.areaname as con_areaname, e.latitude as con_latitude, e.longitude as con_longitude
, a.SERVICE
, a.servicecategory
, GetServiceCategory2(a.service) as servicecategory2
, a.servicesubcategory, a.servicetype as package 
, a.price, a.region, a.ACTIVECOUNT, a.DEVICESCOUNT, a.REPORTED
, rcbill_my.GetNetwork(a.period, a.contractcode) as Network
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
		-- x.settlementname=y.geoname
        (concat(x.settlementname," ",x.areaname)=y.geoname or x.settlementname=y.geoname)
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

where a.reported='Y' and a.clientcode in (select distinct clientcode from rcbill_my.dailyactivenumber) 
)
; 


DROP INDEX `IDXcca1` ON rcbill_my.customercontractactivity;

DROP INDEX `IDXcca2` ON rcbill_my.customercontractactivity;

DROP INDEX `IDXcca12` ON rcbill_my.customercontractactivity;

DROP INDEX `IDXcca13` ON rcbill_my.customercontractactivity;

CREATE INDEX IDXcca1
ON rcbill_my.customercontractactivity (clientcode);

DROP INDEX `IDXcca2` ON rcbill_my.customercontractactivity;

CREATE INDEX IDXcca2
ON rcbill_my.customercontractactivity (period);

DROP INDEX `IDXcca3` ON rcbill_my.customercontractactivity;

CREATE INDEX IDXcca3
ON rcbill_my.customercontractactivity (contractcode);


CREATE INDEX IDXcca4
ON rcbill_my.customercontractactivity (package);


CREATE INDEX IDXcca1
ON rcbill_my.customercontractactivity (period, contractcode, clientcode);

CREATE INDEX IDXcca2
ON rcbill_my.customercontractactivity (clientcode, contractcode, package);

CREATE INDEX IDXcca5
ON rcbill_my.customercontractactivity (clientcode, contractcode, period);


DROP INDEX `IDXcca3` ON rcbill_my.customercontractactivity;

CREATE INDEX IDXcca3
ON rcbill_my.customercontractactivity (period, package);

show indexes from rcbill_my.customercontractactivity;


SET SQL_SAFE_UPDATES = 0;
update rcbill_my.customercontractactivity set Network = rcbill_my.GetNetwork(period, contractcode)
where clientcode in (select clientcode from a)
;

/*
drop temporary table a;
create temporary table a as
(
select distinct clientcode from rcbill_my.dailyactivenumber limit 100
);
*/

SET SQL_SAFE_UPDATES = 0;
update rcbill_my.customercontractactivity set Network = rcbill_my.GetNetwork(period, contractcode)
where clientcode in (
'I.000011750'	

)
;