use rcbill_my;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetIsContractActiveOnDate`(ccode text, rundate date) RETURNS varchar(45) CHARSET utf8
BEGIN
    DECLARE isactive VARCHAR(45);

    SET isactive=(select count(*) from rcbill_my.dailyactivenumber where CONTRACTCODE=ccode and period=rundate);

	-- RETURN isactive;
	RETURN IF(isactive=0, 'NO', 'YES'); 
    
    /*
	case isactive
		when NULL then return 'NO';
		else return 'YES';
	end case;
*/

 
    -- RETURN isactive;
  END$$
DELIMITER ;
