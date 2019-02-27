DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetClientID`(clientcode varchar(255)) RETURNS int
BEGIN
    DECLARE clientid int;

    SET clientid=(select id from rcbill.rcb_tclients where kod=clientcode);
 
    RETURN clientid;
  END$$
DELIMITER ;
