-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketComments-04122017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_ticketcomments` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@TicketID ,
@Comment ,
@TechUserID ,
@ID_OLD ,
@UpdDate ,
@USERID 


) 
set 
ID=@ID ,
TICKETID=@TicketID ,
COMMENT=@Comment ,
TECHUSERID=@TechUserID ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,


INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;



CREATE INDEX IDXtc1
ON rcb_ticketcomments (ID,TICKETID);

CREATE INDEX IDXtc2
ON rcb_ticketcomments (TICKETID);

CREATE INDEX IDXtc3
ON rcb_ticketcomments (ID);

CREATE INDEX IDXtc4
ON rcb_ticketcomments (USERID);

/*
CREATE INDEX IDXtick5
ON rcb_ticketcomments (CID);
*/

select count(*) from rcb_ticketcomments;

select * from rcbill.rcb_ticketcomments;
-- where `comment` like '%intelba93%' ;
