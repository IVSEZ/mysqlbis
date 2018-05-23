DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetLastActiveDateForClient`(ccode text) RETURNS date 
BEGIN
    DECLARE lastactivedate date;

    SET lastactivedate=(select max(period) from rcbill_my.customercontractactivity where ClientCode=ccode);

	RETURN lastactivedate;
	-- RETURN IF(isactive=0, 'NO', 'YES'); 
    
    /*
	case isactive
		when NULL then return 'NO';
		else return 'YES';
	end case;
*/

 
    -- RETURN isactive;
  END$$
DELIMITER ;
