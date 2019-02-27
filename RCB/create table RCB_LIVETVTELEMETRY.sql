use rcbill;

drop table if exists rcb_livetvtelemetry;

CREATE TABLE `rcb_livetvtelemetry` (
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


show columns from rcb_livetvtelemetry;
/*
CREATE INDEX IDXlivetvtel1
ON rcb_livetvtelemetry (ID);
*/

CREATE INDEX IDXlivetvtel2
ON rcb_livetvtelemetry (DEVICE);


CREATE INDEX IDXlivetvtel3
ON rcb_livetvtelemetry (SESSIONSTART);