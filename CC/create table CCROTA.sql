use rcbill_my;

drop table if exists ccrota;

CREATE TABLE `ccrota` (
`CCDATE` date DEFAULT NULL ,
`CCSHIFT` varchar(255) DEFAULT NULL ,
`CCNUMBER` varchar(255) DEFAULT NULL ,
`CCAGENT` varchar(255) DEFAULT NULL ,
`COMMENT` varchar(255) DEFAULT NULL 
-- ,
-- `INSERTEDON` datetime DEFAULT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

