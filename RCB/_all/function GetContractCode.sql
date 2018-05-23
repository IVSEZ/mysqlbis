DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetContractCode`(contractid int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE contractcode VARCHAR(255);

    SET contractcode=(select kod from rcbill.rcb_contracts where id=contractid);
 
    RETURN contractcode;
  END$$
DELIMITER ;