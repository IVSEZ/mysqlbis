DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetActiveDaysForContract`(ccode text, concode text, pkg text) RETURNS int
BEGIN
    DECLARE activedays int;

    SET activedays=(select count(distinct period) from rcbill_my.customercontractactivity where ClientCode=ccode and ContractCode=concode and Package=pkg);

	RETURN activedays;

  END$$
DELIMITER ;
