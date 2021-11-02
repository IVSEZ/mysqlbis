DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetLastPackageFromSnapshot`(ccode text, sc text) RETURNS text CHARSET latin1
BEGIN
    DECLARE lastpackage text;

    SET lastpackage=(select package from rcbill_my.customercontractsnapshot where 
								servicecategory=sc and packagetype='STANDALONE'
								and
								ClientCode=ccode 
                                -- and CurrentStatus='Active'
                                order by contractcode desc
                                limit 1
							);

	RETURN lastpackage;
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