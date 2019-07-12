
use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-09012019-12012019.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_vodtelemetry` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
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
RESOURCE=@Resource ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart ,
SESSIONEND=@SessionEnd ,

INSERTEDON=now()
;

explain select count(1) as vodtelemetry from rcb_vodtelemetry;
-- select * from rcbill.rcb_vodtelemetry order by insertedon desc limit 2000;
-- set sql_safe_updates=0;
-- delete from rcbill.rcb_vodtelemetry where ﻿ID=0;

use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllLIVETVTelemetry-09012019-12012019.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_livetvtelemetry` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
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
RESOURCE=@Resource ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart ,
SESSIONEND=@SessionEnd ,

INSERTEDON=now()


;

explain select count(1) as livetvtelemetry from rcbill.rcb_livetvtelemetry;

-- select sessionstart, sessionend, insertedon from rcbill.rcb_livetvtelemetry where date(insertedon)='2019-05-13'>='2019-05-13 11:48:10' sessionstart>'2019-01-09' and sessionstart<'2019-01-13' order by insertedon desc limit 1000;

-- set sql_safe_updates=0;
-- delete from rcbill.rcb_livetvtelemetry where insertedon>='2019-05-13 11:48:10';