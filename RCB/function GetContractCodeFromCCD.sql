DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetContractCodeFromCCD`(device varchar(255), ccode varchar(255)) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE contractcode VARCHAR(255);

    SET contractcode=(select contractcode from rcbill.clientcontractdevices where phoneno=device and clientcode=ccode);
 
    RETURN contractcode;
  END$$
DELIMITER ;
