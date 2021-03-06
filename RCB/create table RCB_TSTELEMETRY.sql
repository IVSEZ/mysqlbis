use rcbill;

drop table if exists rcb_tstelemetry;

CREATE TABLE `rcb_tstelemetry` (
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

CREATE INDEX IDXtstel2
ON rcb_tstelemetry (DEVICE);


CREATE INDEX IDXtstel3
ON rcb_tstelemetry (SESSIONSTART);
