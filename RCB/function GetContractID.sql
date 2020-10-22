DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetContractID`(contractcode varchar(255)) RETURNS int
BEGIN
    DECLARE contractid int;

    SET contractid=(select id from rcbill.rcb_contracts where kod=contractcode);
 
    RETURN contractid;
  END$$
DELIMITER ;
