use rcbill_usage;


/*
## MAKE SURE THESE TABLES ARE POPULATED

select * from rcbill_usage.rcb_iptv_package;
select * from rcbill_usage.rcb_iptv_channels;
select * from rcbill_usage.rcb_iptv_package_channels;
*/

drop table if exists rcbill_usage.puc_bills;

CREATE TABLE `puc_bills` (

`DATE` date DEFAULT NULL ,
`METER_TYPE` varchar(255) DEFAULT NULL ,
`ISLAND` varchar(255) DEFAULT NULL ,
`METER_NAME` varchar(255) DEFAULT NULL ,
`METER_NUMBER` varchar(255) DEFAULT NULL ,
`AMOUNT` decimal(12,5) DEFAULT NULL ,
`UNITS` decimal(12,5) DEFAULT NULL ,
`NODE` varchar(255) DEFAULT NULL ,
`COMMENTS` varchar(255) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL 
) ENGINE=InnoDB DEFAULT CHARSET UTF8;


CREATE INDEX IDXipb1
ON puc_bills (`METER_NUMBER`);

CREATE INDEX IDXipb2
ON puc_bills (`METER_NAME`);


/*
ALTER TABLE rcb_address  
ADD FULLTEXT(settlementname, areaname, districtname);
*/