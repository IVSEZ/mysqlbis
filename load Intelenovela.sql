LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Intelnovela Payment Report - 2013-2016.csv'

INTO TABLE intelenovela 
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@clientcode,
@clientname,
@servicetype,
@paydate,
@paymentamt,
@substart,
@subend,
@isdup,
@iscontinuous
) 
set 
clientcode= @clientcode,
clientname=@clientname,
servicetype=@servicetype,
paydate=STR_TO_DATE(@paydate,'%d-%m-%y %k:%i'),
paymentamt=@paymentamt,
substart=STR_TO_DATE(@substart,'%d-%m-%y %k:%i'),
subend=STR_TO_DATE(@subend,'%d-%m-%y %k:%i'),
isdup=@isdup,
iscontinuous=@iscontinuous
;
