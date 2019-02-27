DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetClientCode`(clientid int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE clientcode VARCHAR(255);

    SET clientcode=(select kod from rcbill.rcb_tclients where id=clientid);
 
    RETURN clientcode;
  END$$
DELIMITER ;
