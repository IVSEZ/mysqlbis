/*
  `﻿No` int(11) DEFAULT NULL,
  `InterfaceName` text,
  `NodeName` text,
  `Latitude` text,
  `Longitude` text,
  `DecimalLat` double DEFAULT NULL,
  `DecimalLong` double DEFAULT NULL,
  `District` text,
  `SubDistrict` text
*/


-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTechRegions-30012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTechRegions-31012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTechRegions-13092018.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTechRegions-13092018-2.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_techregions` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@no ,
@interfacename,
@nodename ,
@latitude ,
@longitude ,
@decimallat ,
@decimallong ,
@district ,
@subdistrict
) 
set 
NO=@no ,
INTERFACENAME=upper(trim(@interfacename)) ,
NODENAME=upper(trim(@nodename)) ,
LATITUDE=@latitude ,
LONGITUDE=@longitude ,
DECIMALLAT=@decimallat ,
DECIMALLONG=@decimallong ,
DISTRICT=upper(trim(@district)) ,
SUBDISTRICT=upper(trim(@subdistrict)), 
TYPE='NODE',
INSERTEDON=now()

;

-- show index from rcbill.rcb_techregions;


-- select * from rcbill.rcb_techregions;

-- select * from rcb_techregions

-- select distinct interfacename, count(*) from rcbill.rcb_techregions group by interfacename;
/*

select district, decimallat, decimallong,type,nodename,interfacename,subdistrict
from 
rcb_techregions
group by district, decimallat, decimallong,type,nodename,interfacename,subdistrict
;

select nodename, interfacename from rcb_techregions
where
district in ('Cascade');

select distinct district, decimallat, decimallong from rcb_techregions;
select district, decimallat, decimallong from rcb_techregions group by district, decimallat, decimallong;

select interfacename, nodename, subdistrict from rcb_techregions where decimallat in (-4.746325000000) and decimallong in (55.471518060000);
select interfacename, nodename, subdistrict from rcb_techregions where decimallat in (-4.761451389000) and decimallong in (55.486764440000);

*/