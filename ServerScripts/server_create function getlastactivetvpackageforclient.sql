DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetLastActiveTVPackageForClient`(ccode text) RETURNS text
BEGIN
    DECLARE lastactivetvpackage text;

    SET lastactivetvpackage=(select package from rcbill_my.customercontractactivity where 
								servicecategory='TV' and servicesubcategory<>'ADDON'
								and
								ClientCode=ccode and period=GetLastActiveDateForClient(ccode)
							);

	RETURN lastactivetvpackage;
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

select package from rcbill_my.customercontractactivity where ClientCode='I977' and period=GetLastActiveDateForClient('I977') ;


select package from rcbill_my.customercontractactivity where 
servicecategory='TV' and servicesubcategory<>'ADDON'
and
ClientCode='I977' and period=GetLastActiveDateForClient('I977') ;