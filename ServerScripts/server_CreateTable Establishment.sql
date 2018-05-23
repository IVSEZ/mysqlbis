use rcbill_my;

drop table if exists establishment;

/*
ID
Establishment
Manager
Address
Location
Island
Tel
Fax
Email
Website
Status
License Type
Remark
No of Restaurant
Names of Restaurants
Number of Covers
Rooms
Beds
*/
CREATE TABLE `establishment` (
`ESTID` bigint(8) NOT NULL AUTO_INCREMENT ,
`ESTNAME` varchar(255) DEFAULT NULL ,
`ESTMANAGER` varchar(255) DEFAULT NULL ,
`ESTADDRESS` varchar(255) DEFAULT NULL ,
`ESTLOCATION` varchar(255) DEFAULT NULL ,
`ESTISLAND` varchar(255) DEFAULT NULL ,
`ESTPHONE` varchar(255) DEFAULT NULL ,
`ESTFAX` varchar(255) DEFAULT NULL ,
`ESTEMAIL` varchar(255) DEFAULT NULL ,
`ESTWEBSITE` varchar(255) DEFAULT NULL ,
`ESTSTATUS` varchar(255) DEFAULT NULL ,
`ESTLICENSETYPE` varchar(255) DEFAULT NULL ,
`ESTREMARK` varchar(255) DEFAULT NULL ,
`ESTROOMS` int(11) DEFAULT NULL ,
`ESTBEDS` int(11) DEFAULT NULL ,
`ESTRESTAURANTS` int(11) DEFAULT NULL ,
`ESTRESTNAME` varchar(255) DEFAULT NULL ,
`ESTCOVERS` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
  PRIMARY KEY (`ESTID`),
  UNIQUE KEY `ESTID_UNIQUE` (`ESTID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET UTF8;


CREATE INDEX IDXEst1
ON establishment (ESTNAME);

CREATE INDEX IDXEst2
ON establishment (ESTLICENSETYPE);

