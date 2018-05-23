DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetCleanOrigPrice`(ContractType varchar(100), OrigPrice decimal(12,5)) RETURNS decimal(12,5)
BEGIN
    DECLARE CleanOrigPrice decimal(12,5);
	
    SET CleanOrigPrice = CASE ContractType
		WHEN 'Adding Contracts::81' THEN 0
		ELSE OrigPrice

    END;
 
 
    RETURN CleanOrigPrice;
  END$$
DELIMITER ;
