DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetCleanString`(oldstring text) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE newstring VARCHAR(255);

    SET newstring=(select SUBSTRING_INDEX(oldstring,':',1));
 
    RETURN newstring;
  END$$
DELIMITER ;
