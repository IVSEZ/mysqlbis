use rcbill;
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevices-29012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevices-05022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevices-21022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevices-28022017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllDevices-04122017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_devices` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
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

CREATE INDEX IDXDevices1
ON rcb_devices (ID);

CREATE INDEX IDXDevices2
ON rcb_devices (ContractID);

CREATE INDEX IDXDevices3
ON rcb_devices (SERVICEID);

CREATE INDEX IDXDevices4
ON rcb_devices (CSID);

CREATE INDEX IDXDevices5
ON rcb_devices (MAC);

CREATE INDEX IDXDevices6
ON rcb_devices (PhoneNo);

-- select * from rcb_devices;
-- select * from rcb_devices where mac = '68.db.67.59.9b.37' order by upddate;
select count(*) from rcb_devices;

/*
create table client contract devices
*/

drop table if exists rcbill.clientcontractdevices;
create table rcbill.clientcontractdevices(INDEX idxccd1 (mac), INDEX idxccd2 (contractcode), INDEX idxccd3 (clientcode)) as 
(
select a.contractid as CONID, a.phoneno, a.mac, a.address, b.id as ContractId,b.kod as ContractCode, b.ContractType, b.clid, c.id as ClientId, c.kod as ClientCode, c.firm as ClientName, c.address as ClientAddress
from 
rcbill.rcb_devices a 
inner join 
rcbill.rcb_contracts b 

on a.contractid=b.id


inner join 
rcbill.rcb_tclients c

on b.clid=c.id
)
;



-- optimize table rcbill.clientcontractdevices;