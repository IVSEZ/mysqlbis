DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetOrigCost`(OrigService varchar(100), OrigPrice decimal(12,5)) RETURNS decimal(12,5)
BEGIN
    DECLARE OrigCost decimal(12,5);
	
    SET OrigCost = CASE OrigService
		WHEN 'Subscription Capped Internet' THEN OrigPrice/1.15
		WHEN 'Subscription Internet' THEN OrigPrice/1.15
		WHEN 'Subscription Capped gNet' THEN OrigPrice/1.15
		WHEN 'Subscription gNet' THEN OrigPrice/1.15
        
		ELSE OrigPrice

    END;
 
 
    RETURN OrigCost;
  END$$
DELIMITER ;
