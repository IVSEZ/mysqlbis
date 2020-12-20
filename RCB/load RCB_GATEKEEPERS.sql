
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllGateKeepers-14122020.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_gatekeepers` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@﻿id,
@name,
@ServiceTypeID,
@IP,
@Prefix,
@CityPrefix ,
@TftpUrl ,
@FtpUrl ,
@FtpUser ,
@FtpPass ,
@STOREALL ,
@STOREALLRAD ,
@DisAllowForward ,
@LOGRETRYES ,
@LOCKTIME ,
@PinLen ,
@OwnerID ,
@RequireStaticIPAddress ,
@UseStaticIPAddress ,
@UseDDNS ,
@DefaultDomain ,
@RequireSubDeviceKnowledge ,
@InterimInterval ,
@SessionTimeout ,
@InternalMultilink ,
@RejectToPoolID ,
@ParentID ,
@AllowChildReAuthentication ,
@SimpleAuthentication ,
@ProvisioningType ,
@RadiusModel ,
@RequireFreeDevice ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@RejectToTraficSpeed ,
@TempActivateToPoolID ,
@TempActivateToTraficSpeed ,
@UserAuthentication 
) 
set
ID=@﻿id ,
NAME=@name ,
SERVICETYPEID=@ServiceTypeID ,
IP=@IP ,
PREFIX=@Prefix ,
CITYPREFIX=@CityPrefix ,
TFTPURL=@TftpUrl ,
FTPURL=@FtpUrl ,
FTPUSER=@FtpUser ,
FTPPASS=@FtpPass ,
STOREALL=@STOREALL ,
STOREALLRAD=@STOREALLRAD ,
DISALLOWFORWARD=@DisAllowForward ,
LOGRETRYES=@LOGRETRYES ,
LOCKTIME=@LOCKTIME ,
PINLEN=@PinLen ,
OWNERID=@OwnerID ,
REQUIRESTATICIPADDRESS=@RequireStaticIPAddress ,
USESTATICIPADDRESS=@UseStaticIPAddress ,
USEDDNS=@UseDDNS ,
DEFAULTDOMAIN=@DefaultDomain ,
REQUIRESUBDEVICEKNOWLEDGE=@RequireSubDeviceKnowledge ,
INTERIMINTERVAL=@InterimInterval ,
SESSIONTIMEOUT=@SessionTimeout ,
INTERNALMULTILINK=@InternalMultilink ,
REJECTTOPOOLID=@RejectToPoolID ,
PARENTID=@ParentID ,
ALLOWCHILDREAUTHENTICATION=@AllowChildReAuthentication ,
SIMPLEAUTHENTICATION=@SimpleAuthentication ,
PROVISIONINGTYPE=@ProvisioningType ,
RADIUSMODEL=@RadiusModel ,
REQUIREFREEDEVICE=@RequireFreeDevice ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,
REJECTTOTRAFICSPEED=@RejectToTraficSpeed ,
TEMPACTIVATETOPOOLID=@TempActivateToPoolID ,
TEMPACTIVATETOTRAFICSPEED=@TempActivateToTraficSpeed ,
USERAUTHENTICATION=@UserAuthentication ,

INSERTEDON=now()

;

CREATE INDEX IDXDT1
ON rcbill.rcb_gatekeepers(ID);

-- CREATE INDEX IDXDT2
-- ON rcbill.rcb_gatekeepers (name);

-- select * from rcbill.rcb_gatekeepers where ID=3;



