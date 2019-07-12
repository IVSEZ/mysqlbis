DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetClientNameFromID`(clientid int(11)) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE clientname VARCHAR(255);

    SET clientname=(select firm from rcbill.rcb_tclients where id=clientid);
 
    RETURN clientname;
  END$$
DELIMITER ;
