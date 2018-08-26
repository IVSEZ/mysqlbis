use rcbill;

drop table if exists rcb_vodtelemetry;

CREATE TABLE `rcb_vodtelemetry` (
`﻿ID` int(11) DEFAULT NULL ,
`DEVICE` varchar(255) DEFAULT NULL ,
`TYPE` varchar(255) DEFAULT NULL ,
`RESOURCE` varchar(255) DEFAULT NULL ,
`STARTPOSITION` datetime DEFAULT NULL ,
`ENDTIME` datetime DEFAULT NULL ,
`DURATION` int(11) DEFAULT NULL ,
`SUBSCRIBER` varchar(255) DEFAULT NULL ,
`SESSIONSTART` datetime DEFAULT NULL ,
`SESSIONEND` datetime DEFAULT NULL ,

`INSERTEDON` datetime DEFAULT NULL	

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE INDEX IDXvodtel2
ON rcb_vodtelemetry (DEVICE);


CREATE INDEX IDXvodtel3
ON rcb_vodtelemetry (SESSIONSTART);