DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetNewClientCode`(ccode1 varchar(45), ccode2 varchar(45)) RETURNS varchar(100) CHARSET utf8
BEGIN
    DECLARE newccode VARCHAR(100);
	
    SET newccode = CASE strcmp(ccode1, ccode2) 
		WHEN 0 THEN concat('[',ccode1,']|[',ccode2,']')
		WHEN 1 THEN concat('[',ccode2,']|[',ccode1,']')
		WHEN -1 THEN concat('[',ccode1,']|[',ccode2,']')

    END;
 
 
    RETURN newccode;
  END$$
DELIMITER ;
