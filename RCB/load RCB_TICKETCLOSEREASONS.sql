LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketCloseReasons-21112017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_ticketclosereasons` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@TCRID ,
@KOD ,
@CloseReasonName ,
@TechServiceID ,
@TechLevelID ,
@TicketCloseReasonTypeID ,
@TicketTypeID ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@Success ,
@Active 
) 
set
TCRID=@TCRID ,
KOD=@KOD ,
CLOSEREASONNAME=@CloseReasonName ,
TECHSERVICEID=@TechServiceID ,
TECHLEVELID=@TechLevelID ,
TICKETCLOSEREASONTYPEID=@TicketCloseReasonTypeID ,
TICKETTYPEID=@TicketTypeID ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,
SUCCESS=@Success ,
ACTIVE=@Active ,
INSERTEDON=now()
-- ,
-- REPORTDATE=@REPORTDATE

;



select * from rcbill.rcb_ticketclosereasons;

