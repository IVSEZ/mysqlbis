/*
Error Code: 1406. Data too long for column 'SerNo' at row 260813 - put quotes on "96HBN97FS48429"
Error Code: 1292. Incorrect datetime value: '0' for column 'UpdDate' at row 408985 - remove quotes from "01802014467
Error Code: 1406. Data too long for column 'SerNo' at row 1048246 - put quotes on "96HBN97FS48429"
*/

-- duration 94.219 sec

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevicesOld-29012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevicesOld-05022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevicesOld-21022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevicesOld-28022017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevicesOld-04122017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_devicesold` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@ContractID ,
@SERVICEID ,
@CSID ,
@DevTypeID ,
@PhoneNo ,
@UserName ,
@Password ,
@Address ,
@IP ,
@NATIP ,
@DeviceName ,
@MAC ,
@SerNo ,
@GKID ,
@ProtNo ,
@CreditLimit ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@ActivatedDate ,
@NoTrigger ,
@AddressID ,
@CustomConfig ,
@OutVLAN 
) 
set 

ID=@ID ,
ContractID=@ContractID ,
SERVICEID=@SERVICEID ,
CSID=@CSID ,
DevTypeID=@DevTypeID ,
PhoneNo=@PhoneNo ,
UserName=@UserName ,
Password=@Password ,
Address=upper(trim(@Address)) ,
IP=@IP ,
NATIP=@NATIP ,
DeviceName=@DeviceName ,
MAC=@MAC ,
SerNo=@SerNo ,
GKID=@GKID ,
ProtNo=@ProtNo ,
CreditLimit=@CreditLimit ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
ActivatedDate=@ActivatedDate ,
NoTrigger=@NoTrigger ,
AddressID=@AddressID ,
CustomConfig=@CustomConfig ,
OutVLAN=@OutVLAN ,

INSERTEDON=now(),
REPORTDATE=@REPORTDATE 


;

CREATE INDEX IDXDevicesOld1
ON rcb_devicesold (ID);

CREATE INDEX IDXDevicesOld2
ON rcb_devicesold (ContractID);

CREATE INDEX IDXDevicesOld3
ON rcb_devicesold (SERVICEID);

CREATE INDEX IDXDevicesOld4
ON rcb_devicesold (CSID);

CREATE INDEX IDXDevicesOld5
ON rcb_devicesold (MAC);

-- select * from rcb_devicesold limit 1000;