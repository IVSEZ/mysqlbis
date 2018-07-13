#################################################################

# VOD TELEMETRY

use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-12072018.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_vodtelemetry` CHARACTER SET UTF8 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
( 
 @ID,
 @Device,
 @Type1,
 @Resource,
 @StartPosition,
 @EndTime,
 @Duration,
 @Subscriber,
 @SessionStart,
 @SessionEnd
)
set
ID=@ID,
DEVICE=@Device,
`TYPE`=@Type1,
RESOURCE=upper(trim(@Resource)),
STARTPOSITION=@StartPosition,
ENDTIME=@EndTime,
DURATION=@Duration,
SUBSCRIBER=@Subscriber,
SESSIONSTART=@SessionStart,
SESSIONEND=@SessionEnd,
INSERTEDON=now()
;

select count(1) as vodtelemetry from rcb_vodtelemetry;

/*
select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_vodtelemetry
group by 1
order by 1 desc;
*/

########################################################

# TS TELEMETRY

use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-12072018.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_tstelemetry` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
(
@ID ,
@Device ,
@Type1 ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
) 
set 
ID=@ID,
DEVICE=@Device ,
`TYPE`=@Type1 ,
RESOURCE=upper(trim(@Resource)) ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart ,
SESSIONEND=@SessionEnd ,

INSERTEDON=now()
;

select count(1) as tstelemetry from rcbill.rcb_tstelemetry;

/*
select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_tstelemetry
group by 1
order by 1 desc;
*/
##############################################################################


#################################################################

# LIVE TV TELEMETRY

use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllLIVETVTelemetry-12072018.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_livetvtelemetry` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
(
@ID ,
@Device ,
@Type1 ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
) 
set 
ID=@ID,

DEVICE=@Device ,

`TYPE`=@Type1 ,

RESOURCE=upper(trim(@Resource)) ,

STARTPOSITION=@StartPosition ,

ENDTIME=@EndTime ,

DURATION=@Duration ,

SUBSCRIBER=@Subscriber ,

SESSIONSTART=@SessionStart ,

SESSIONEND=@SessionEnd ,


INSERTEDON=now()




;

select count(1) as livetvtelemetry from rcbill.rcb_livetvtelemetry;

/*
select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_livetvtelemetry
group by 1
order by 1 desc;
*/

########################################################

# RADIO TELEMETRY

use rcbill;


LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllRADIOTelemetry-12072018.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_radiotelemetry` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
(
@ID ,
@Device ,
@Type1 ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
) 
set 
ID=@ID,
DEVICE=@Device ,
`TYPE`=@Type1 ,
RESOURCE=upper(trim(@Resource)) ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart ,
SESSIONEND=@SessionEnd ,

INSERTEDON=now()



;

select count(1) as radiotelemetry from rcbill.rcb_radiotelemetry;

/*
select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_radiotelemetry
group by 1
order by 1 desc;
*/
##############################################################################