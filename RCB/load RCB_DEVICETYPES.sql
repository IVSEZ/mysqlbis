
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDeviceTypes-28022017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDeviceTypes-14122020.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_devicetypes` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@id ,
@name ,
@ServiceTypeID ,
@SubDevice ,
@ID_OLD ,
@UpdDate ,
@USERID 
) 
set 
id=@id ,
name=@name ,
ServiceTypeID=@ServiceTypeID ,
SubDevice=@SubDevice ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE 


;

CREATE INDEX IDXDT1
ON rcb_devicetypes (ID);

CREATE INDEX IDXDT2
ON rcb_devicetypes (name);

/*
CREATE INDEX IDXDT3
ON rcb_devicetypes (CID);

CREATE INDEX IDXDT4
ON rcb_devicetypes (INVID);
*/
-- select * from rcb_devicetypes;