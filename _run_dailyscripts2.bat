
mysql -h 192.168.1.166 -u root -pl3tm31n!@# 
mysql \T C:\workspace\cloud\code\sql\_log\output_20180711.out
mysql \. C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-CREATE-LOAD.sql

exit

C:\workspace\cloud\code\sql\_DailyScript\DAILY-SCRIPT-CREATE-LOAD.sql
mysql \T C:\workspace\cloud\code\sql\_log\output_$(date +"%Y-%m-%d_%H-%M").out
mysql \. C:\workspace\cloud\code\sql\test.sql
mysql \. C:\workspace\cloud\code\sql\test.sql

exit

 