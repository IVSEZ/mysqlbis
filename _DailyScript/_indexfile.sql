exit;

mysql -h 192.168.1.166 -u root -pl3tm31n!@# 
mysql \T C:\workspace\cloud\code\sql\_log\output_20180712.out


####################################################################################
#RUN DAILY-SCRIPT-TELEMETRY.sql first#


mysql -h 192.168.1.166 -u root -pl3tm31n!@# 
mysql \T C:\workspace\cloud\code\sql\_log\output_20180818_1.out


mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-LIVETV-STATS.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-VODTS-STATS.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-RADIO-STATS.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY_SCRIPT_TELEMETRY_PIVOT.sql


mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-CREATE-LOAD.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\ticket_analysis.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\load DailyCalls.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-USAGE.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-SALES-TELEMETRY.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-ACTIVENUMBERS.sql


mysql \. C:\workspace\cloud\code\sql\_DailyScript\reports-sales-addons-prepaid-camera.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\housing-estate-analysis.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\sales-to-activenumber.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\RCB_ClientAnalyticsReport_Script.sql


exit



####################################################################################


mysql \. C:\workspace\cloud\code\sql\_DailyScript\DualView_sales.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\MultiView_sales.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\amber_sales.sql

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-LIVETV-STATS.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-VODTS-STATS.sql


exit 



mysql -h 192.168.1.166 -u root -pl3tm31n!@# 
mysql \T C:\workspace\cloud\code\sql\_log\output_20180713_2.out


mysql -h 192.168.1.166 -u root -pl3tm31n!@# 
mysql \T C:\workspace\cloud\code\sql\_log\output_20180713_3_1.out

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-TELEMETRY.sql
exit 




mysql -h 192.168.1.166 -u root -pl3tm31n!@# 
mysql \T C:\workspace\cloud\code\sql\_log\output_20180713_4.out

mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-ACTIVENUMBERS.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\reports-sales-addons-prepaid-camera.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\housing-estate-analysis.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\sales-to-activenumber.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\RCB_ClientAnalyticsReport_Script.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-LIVETV-STATS.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-VODTS-STATS.sql


exit


mysql \. C:\workspace\cloud\code\sql\_DailyScript\DualView_sales.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\MultiView_sales.sql
mysql \. C:\workspace\cloud\code\sql\_DailyScript\amber_sales.sql


use rcbill_my;

call sp_ActiveNumber(02,08,2018,'','');

call sp_GetActiveNumberFromTo('2018-08-02','2018-08-09');

exit


