use rcbill;

drop table if exists rcb_iptv_package;

CREATE TABLE `rcb_iptv_package` (

`ID` int(11) DEFAULT NULL ,
`CODE` varchar(255) DEFAULT NULL ,
`NAME` varchar(255) DEFAULT NULL ,
`TEST_ONLY` int(11) DEFAULT NULL ,
`ENABLED` int(11) DEFAULT NULL ,
`TENANT_ID` int(11) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`EXPLUDE_FROM_ALL_PACKAGE_LIST` int(11) DEFAULT NULL ,
`RCBILLPUBLISHED` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL 
) ENGINE=InnoDB DEFAULT CHARSET UTF8;


CREATE INDEX IDXip1
ON rcb_iptv_package (`ID`);

CREATE INDEX IDXip2
ON rcb_iptv_package (`CODE`);

CREATE INDEX IDXip3
ON rcb_iptv_package (`NAME`);

/*
ALTER TABLE rcb_address  
ADD FULLTEXT(settlementname, areaname, districtname);
*/