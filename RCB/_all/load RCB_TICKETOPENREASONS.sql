-- SET SESSION sql_mode = '';
/*
  `﻿ID` int(11) DEFAULT NULL,
  `KOD` int(11) DEFAULT NULL,
  `NAME` text,
  `STANDARDWORK` text,
  `MAXDURATION` text,
  `TECHSERVICEID` int(11) DEFAULT NULL,
  `TICKETTYPEID` int(11) DEFAULT NULL,
  `ID_OLD` int(11) DEFAULT NULL,
  `UPDDATE` datetime DEFAULT NULL,
  `USERID` int(11) DEFAULT NULL,
  `REQUIRETESTING` int(11) DEFAULT NULL
  */

-- ID,KOD,Name,StandartWork,MaxDuration,TechServiceID,TicketTypeID,ID_OLD,UpdDate,USERID,RequireTesting

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketOpenReasons-21112017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_ticketopenreasons` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@TORID ,
@KOD ,
@OpenReasonName ,
@StandardWork ,
@MaxDuration ,
@TechServiceID ,
@TicketTypeID ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@RequireTesting 
) 
set
TORID=@TORID ,
KOD=@KOD ,
OPENREASONNAME=@OpenReasonName ,
STANDARDWORK=@StandardWork ,
MAXDURATION=@MaxDuration ,
TECHSERVICEID=@TechServiceID ,
TICKETTYPEID=@TicketTypeID ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,
REQUIRETESTING=@RequireTesting ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;


/*
CREATE INDEX IDXtc1
ON rcb_ticketcomments (ID,TICKETID);

CREATE INDEX IDXtc2
ON rcb_ticketcomments (TICKETID);

CREATE INDEX IDXtc3
ON rcb_ticketcomments (ID);

CREATE INDEX IDXtc4
ON rcb_ticketcomments (USERID);
*/
/*
CREATE INDEX IDXtick5
ON rcb_ticketcomments (CID);
*/

-- select count(*) from rcb_ticketopenreasons;

select * from rcbill.rcb_ticketopenreasons;
-- where `comment` like '%intelba93%' ;
