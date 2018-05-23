use rcbill_my;

drop table if exists bc_inactdevices;



CREATE TABLE `bc_inactdevices` (
`BESTCASID` varchar(255) DEFAULT NULL	,
`LASTACTIVEDATE` datetime DEFAULT NULL	,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;



-- drop index IDXTClients on rcb_tclients;


-- select * from rcb_tclients where id in (723013);