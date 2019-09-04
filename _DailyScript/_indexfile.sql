exit;

mysql -h 192.168.1.166 -u root -pl3tm31n!@# 
mysql \T C:\workspace\cloud\code\sql\_log\output_20180712.out


####################################################################################
#RUN DAILY-SCRIPT-TELEMETRY.sql first#


mysql -h 192.168.1.166 -u root -pl3tm31n!@#mysql 
mysql \T C:\workspace\cloud\code\sql\_log\output_20190902_1.out

mysql \. C:\workspace\cloud\code\sql\_DailyScript\_setdates.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\load_RCB_VODTITLES.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-LIVETV-STATS.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-VODTS-STATS.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-RADIO-STATS.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY_SCRIPT_TELEMETRY_PIVOT.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\telemetry_livetv_ranking2019.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\telemetry_radio_ranking2019.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\telemetry_ts_ranking2019.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\telemetry_vod_ranking2019.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\telemetry_vod_ranking2019_1.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\telemetry_vod_ranking2019_2.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-CREATE-LOAD.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\ticket_analysis.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\load_DailyCalls.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-USAGE.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-SALES-TELEMETRY.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-ACTIVENUMBERS.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\GetActiveNumbers Average -Pivot.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\budget_actual_analysis_2019.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\reports-sales-addons-prepaid-camera.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\housing-estate-analysis.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\RCB_ClientAnalyticsReport_Script.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\REVENUE_PER_NODE_MXK.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql

mysql \. C:\workspace\cloud\code\sql\Analysis\service_tickets_assignments.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql


exit




## this has been moved out of the above code
mysql \. C:\workspace\cloud\code\sql\_DailyScript\sales-to-activenumber.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\currenttime.sql


####################################################################################

select * from rcbill_my.rep_livetvstats;
select * from rcbill_my.rep_vodstats;
select * from rcbill_my.rep_tsstats;
select * from rcbill_my.rep_radiostats;

use rcbill_my;

call sp_ActiveNumber(31,07,2019,'','');

call sp_GetActiveNumberFromTo('2019-08-01','2019-08-31');


select * from rcbill_my.clientstats where VOD>0 and DualView>0
and clientclass not in ('Employee','Intelvision Office')
;


select * from rcbill_my.clientstats where VOD>0 and MultiView>0
and clientclass not in ('Employee','Intelvision Office')
;
######################################################################################

#FOR EVERY NEW PRODUCT MAKE CHANGES IN THE FOLLOWING FILES
C:\workspace\cloud\code\sql\ActiveNumber\get lkpservicetype.sql
C:\workspace\cloud\code\sql\ActiveNumber\get lkpbaseservice.sql
C:\workspace\cloud\code\sql\ActiveNumber\get lkpreported.sql
####################################################################


mysql \. C:\workspace\cloud\code\sql\_DailyScript\DualView_sales.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\MultiView_sales.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\amber_sales.sql


exit


