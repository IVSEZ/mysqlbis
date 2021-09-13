use rcbill;

drop table if exists rcb_iptv_package_channels;

CREATE TABLE `rcb_iptv_package_channels` (

`ID` int(11) DEFAULT NULL ,
`PACKAGE_ID` int(11) DEFAULT NULL ,
`CHANNEL_ID` int(11) DEFAULT NULL ,
`ENABLED` int(11) DEFAULT NULL ,
`ORDER_WEIGHT` int(11) DEFAULT NULL ,
`CHANNEL` int(11) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`ALTERNATIVE_NAME` varchar(255) DEFAULT NULL ,
`MINUTES_SHIFTED` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL 
) ENGINE=InnoDB DEFAULT CHARSET UTF8;


CREATE INDEX IDXipc1
ON rcb_iptv_package_channels (`ID`);

CREATE INDEX IDXipc2
ON rcb_iptv_package_channels (`PACKAGE_ID`);

CREATE INDEX IDXipc3
ON rcb_iptv_package_channels (`CHANNEL_ID`);

/*
ALTER TABLE rcb_address  
ADD FULLTEXT(settlementname, areaname, districtname);
*/