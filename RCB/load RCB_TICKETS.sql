-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTickets-26122017.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_tickets` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_tickets` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@OpenDate ,
@OpenUserID ,
@OpenReasonID ,
@TechDeptID ,
@TechRegionID ,
@TechGroupID ,
@VisitDate ,
@StageTechRegionID ,
@ExecutedDate ,
@CloseDate ,
@CloseUserID ,
@CloseReasonID ,
@CloseTechDeptID ,
@CloseTechRegionID ,
@CloseTechGroupID ,
@CLID ,
@CID ,
@DEVID ,
@SeverityID ,
@ServiceID ,
@TypeID ,
@Type ,
@State ,
@VisitCount ,
@WorkTime ,
@Subject ,
@DeviceState ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@NAS ,
@ParentID ,
@Interface ,
@TestDate ,
@TestState ,
@ActivityID ,
@GlobalTicket 

) 
set 
ID=@ID ,
OPENDATE=@OpenDate ,
OPENUSERID=@OpenUserID ,
OPENREASONID=@OpenReasonID ,
TECHDEPTID=@TechDeptID ,
TECHREGIONID=@TechRegionID ,
TECHGROUPID=@TechGroupID ,
VISITDATE=@VisitDate ,
STAGETECHREGIONID=@StageTechRegionID ,
EXECUTEDDATE=@ExecutedDate ,
CLOSEDATE=@CloseDate ,
CLOSEUSERID=@CloseUserID ,
CLOSEREASONID=@CloseReasonID ,
CLOSETECHDEPTID=@CloseTechDeptID ,
CLOSETECHREGIONID=@CloseTechRegionID ,
CLOSETECHGROUPID=@CloseTechGroupID ,
CLID=@CLID ,
CID=@CID ,
DEVID=@DEVID ,
SEVERITYID=@SeverityID ,
SERVICEID=@ServiceID ,
TYPEID=@TypeID ,
TYPE=@Type ,
STATE=@State ,
VISITCOUNT=@VisitCount ,
WORKTIME=@WorkTime ,
SUBJECT=@Subject ,
DEVICESTATE=@DeviceState ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,
NAS=@NAS ,
PARENTID=@ParentID ,
INTERFACE=@Interface ,
TESTDATE=@TestDate ,
TESTSTATE=@TestState ,
ACTIVITYID=@ActivityID ,
GLOBALTICKET=@GlobalTicket ,

INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;



CREATE INDEX IDXtick1
ON rcb_tickets (CLID,CID);

CREATE INDEX IDXtick2
ON rcb_tickets (CLID);

CREATE INDEX IDXtick3
ON rcb_tickets (CID);

CREATE INDEX IDXtick4
ON rcb_tickets (ID);

/*
CREATE INDEX IDXtick5
ON rcb_tickets (CID);
*/

select count(*) from rcb_tickets;

select * from rcbill.rcb_tickets;

-- select * from rcbill.rcb_tickets where id=863585;