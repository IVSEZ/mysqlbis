use rcbill_my;

drop table if exists ccagents;

CREATE TABLE `ccagents` (
`CCDATE` date DEFAULT NULL ,
`CCSHIFT` varchar(255) DEFAULT NULL ,
`CALLAGENT` varchar(255) DEFAULT NULL ,
`CCAGENTNAME` varchar(255) DEFAULT NULL 
-- ,
-- `INSERTEDON` datetime DEFAULT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

