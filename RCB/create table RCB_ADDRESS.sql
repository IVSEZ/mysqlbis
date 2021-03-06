use rcbill;

drop table if exists rcb_address;

CREATE TABLE `rcb_address` (
`AREANAME` varchar(255) DEFAULT NULL ,
`SETTLEMENTNAME` varchar(255) DEFAULT NULL ,
`DISTRICTNAME` varchar(255) DEFAULT NULL ,
`STREETNAME` varchar(255) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	
) ENGINE=InnoDB DEFAULT CHARSET UTF8;


CREATE INDEX IDXAddress1
ON rcb_address (AREANAME);

CREATE INDEX IDXAddress2
ON rcb_address (SETTLEMENTNAME);

/*
ALTER TABLE rcb_address  
ADD FULLTEXT(settlementname, areaname, districtname);
*/