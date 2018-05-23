use rcbill;

drop table if exists rcb_ticketcomments;


CREATE TABLE `rcb_ticketcomments` (
`ID` int(11) DEFAULT NULL ,
`TICKETID` int(11) DEFAULT NULL ,
`COMMENT` varchar(255) DEFAULT NULL ,
`TECHUSERID` int(11) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,

`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,


`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;




-- drop index IDXinvoiceheader on rcb_ticketcomments;

