use rcbill;

drop table if exists rcb_comments;


CREATE TABLE `rcb_comments` (
`ID` int(11) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`CLIENTCODE` varchar(255) DEFAULT NULL ,

`CID` int(11) DEFAULT NULL ,
`CONTRACTCODE` varchar(255) DEFAULT NULL ,

`COMMENTDATE` datetime DEFAULT NULL ,
`COMMENT` text DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,



`INSERTEDON` datetime DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;




-- drop index IDXinvoiceheader on rcb_ticketcomments;

show index from rcbill.rcb_comments;

