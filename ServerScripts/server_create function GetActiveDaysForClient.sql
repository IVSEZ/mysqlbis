DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetActiveDaysForClient`(ccode text) RETURNS int
BEGIN
    DECLARE activedays int;

    SET activedays=(select count(distinct period) from rcbill_my.customercontractactivity where ClientCode=ccode);

	RETURN activedays;

  END$$
DELIMITER ;
