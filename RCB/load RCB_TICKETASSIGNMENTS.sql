-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketAssignments-11062018.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_tickets` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_ticketassignments` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@TicketID ,
@TechLevelID ,
@TechDeptID ,
@TechRegionID ,
@TechGroupID ,
@TechUserID ,
@Required ,
@Participation ,
@State ,
@Comment ,
@Complete ,
@OpenDate ,
@CloseDate ,
@CloseReasonID ,
@WorkTime ,
@UserID ,
@ID_OLD ,
@UpdDate ,
@SeverityID ,
@Duration_Hour 

) 
set 
ID=@ID ,
TICKETID=@TicketID ,
TECHLEVELID=@TechLevelID ,
TECHDEPTID=@TechDeptID ,
TECHREGIONID=@TechRegionID ,
TECHGROUPID=@TechGroupID ,
TECHUSERID=@TechUserID ,
REQUIRED=@Required ,
PARTICIPATION=@Participation ,
STATE=@State ,
COMMENT=@Comment ,
COMPLETE=@Complete ,
OPENDATE=@OpenDate ,
CLOSEDATE=@CloseDate ,
CLOSEREASONID=@CloseReasonID ,
WORKTIME=@WorkTime ,
USERID=@UserID ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
SEVERITYID=@SeverityID ,
DURATION_HOUR=@Duration_Hour ,


INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;


/*
CREATE INDEX IDXtick1
ON rcb_ticketassignments (CLID,CID);

CREATE INDEX IDXtick2
ON rcb_ticketassignments (CLID);

CREATE INDEX IDXtick3
ON rcb_ticketassignments (CID);

CREATE INDEX IDXtick4
ON rcb_ticketassignments (ID);
*/

/*
CREATE INDEX IDXtick5
ON rcb_tickets (CID);
*/

select count(*) from rcbill.rcb_ticketassignments;

select * from rcbill.rcb_ticketassignments;

-- select * from rcbill.rcb_tickets where id=863585;