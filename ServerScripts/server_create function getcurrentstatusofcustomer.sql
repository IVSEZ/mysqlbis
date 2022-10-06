DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetCurrentStatusOfCustomer`(ccode text) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE currentstatus VARCHAR(255);

    SET currentstatus=(select concat(ifnull(IsAccountActive,""),"|",ifnull(AccountActivityStage,""),"|", ifnull(lastactivedate,""),"|", ifnull(activeservices,"")) from rcbill_my.rep_custconsolidated where clientcode=ccode);

	-- RETURN isactive;
	-- RETURN IF(isactive=0, 'NO', 'YES'); 
    RETURN currentstatus;
    /*
	case isactive
		when NULL then return 'NO';
		else return 'YES';
	end case;
*/

 
    -- RETURN isactive;
  END$$
DELIMITER ;

-- select * from rcbill_my.rep_custconsolidated where clientcode='I.000006992';