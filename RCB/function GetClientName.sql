DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetClientName`(clientcode varchar(255)) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE clientname VARCHAR(255);

    SET clientname=(select firm from rcbill.rcb_tclients where upper(trim(kod))=upper(trim(clientcode)));
 
    RETURN clientname;
  END$$
DELIMITER ;
