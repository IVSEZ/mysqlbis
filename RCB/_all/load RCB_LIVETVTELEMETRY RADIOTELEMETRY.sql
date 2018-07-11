
#################################################################

# LIVE TV TELEMETRY

-- SET SESSION sql_mode = '';
use rcbill;


-- REPLACE INTO TABLE `rcbill`.`rcb_vodtelemetry` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllLIVETVTelemetry-01012018-31032018.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllLIVETVTelemetry-01042018-04072018.csv' 

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllLIVETVTelemetry-05072018.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_livetvtelemetry` CHARACTER SET UTF8 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@﻿ID ,
@Device ,
@Type ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
) 
set 
﻿ID=@﻿ID ,
DEVICE=@Device ,
TYPE=@Type ,
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

select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_livetvtelemetry
group by 1
order by 1 desc;


########################################################

# RADIO TELEMETRY

-- SET SESSION sql_mode = '';
use rcbill;


-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-04072018.csv'
-- REPLACE INTO TABLE `rcbill`.`rcb_tstelemetry` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllRADIOTelemetry-01012018-04072018.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllRADIOTelemetry-05072018.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_radiotelemetry` CHARACTER SET UTF8 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@﻿ID ,
@Device ,
@Type ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
) 
set 
﻿ID=@﻿ID ,
DEVICE=@Device ,
TYPE=@Type ,
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


select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_radiotelemetry
group by 1
order by 1 desc;
##############################################################################