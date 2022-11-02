DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetLastPackageDateFromSnapshot`(ccode text, sc text) RETURNS text CHARSET latin1
BEGIN
    DECLARE lastpackagedate text;

    SET lastpackagedate=(select concat(package,'|',lastcontractdate) from rcbill_my.customercontractsnapshot where 
								servicecategory=sc and packagetype='STANDALONE'
								and
								ClientCode=ccode 
                                -- and CurrentStatus='Active'
                                order by contractid desc, lastcontractdate desc
                                limit 1
							);

	RETURN lastpackagedate;
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
