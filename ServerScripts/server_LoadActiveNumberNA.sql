use rcbill_my;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/activenumber/DailySubscriptionStats-NotAll-05022017.csv'

INTO TABLE rcbill_my.activenumberna 
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@periodorig,
@baseservice,
@service,
@servicetypeold,
@clientclassold,
@regionallevel3,
@regionallevel2,
@regionallevel1,
@regionold,
@distributor,
@promotion,
@validity,
@open,
@new,
@newconverted,
@renew,
@closed,
@closednonpayment,
@suspended,
@closedconverted,
@closedother,
@disconnected,
@disconnectedtotal,
@disconnectedall,
@connected,
@connectedtotal,
@pendingorders
) 
set 
activenumberid=null,
periodorig = @periodorig,
period = (select substring_index(@periodorig,';',1)),
periodday = (select extract(day from period)),
periodmth = (select extract(month from period)),
periodyear = (select extract(year from period)),
weekday=(select dayname(period)),
mthname=(select monthname(period)),
baseservice = @baseservice,
service = @service,
servicecategory = (select servicecategory from rcbill_my.lkpbaseservice where service=@service),
servicesubcategory = (select servicesubcategory from rcbill_my.lkpbaseservice where service=@service),

servicetypeold = @servicetypeold,
servicetypeold1 = (select servicenewtype from rcbill_my.lkpservicetype where servicetype=@servicetypeold),
servicetype = (select GetServiceType(servicetypeold,servicetypeold1,service)),

clientclassold = @clientclassold,
clientclass = (select NewClientClass from rcbill_my.lkpclienttype where origclientclass=@clientclassold),
clienttype = (select clienttype from rcbill_my.lkpclienttype where origclientclass=@clientclassold),

regionallevel1 = @regionallevel1,
regionallevel2 = @regionallevel2,
regionallevel3 = @regionallevel3,
regionold = @regionold,
region = (select newregion from rcbill_my.lkpregion where origregion=@regionold),

distributor = @distributor,
promotion = @promotion,
validity = @validity,

open = @open,
new = @new,
newconverted = @newconverted,
renew = @renew,
closed = @closed,
closednonpayment = @closednonpayment,
suspended = @suspended,
closedconverted = @closedconverted,
closedother = @closedother,
disconnected = @disconnected,
disconnectedtotal = @disconnectedtotal,
disconnectedall = @disconnectedall,
connected = @connected,
connectedtotal = @connectedtotal,
pendingorders = @pendingorders,

totalopened = (new+newconverted+renew),
totalclosed = (closed+closednonpayment+closedconverted+closedother),
difference = (totalopened - totalclosed),
totalcheck = (open+new+newconverted+renew+closed+closednonpayment+closedconverted+closedother+disconnected+disconnectedtotal+disconnectedall+connected+connectedtotal),
decommissioned = (select IsDecom(totalcheck)),
reported = (select reported from rcbill_my.lkpreported where servicenewtype=servicetype)
;
