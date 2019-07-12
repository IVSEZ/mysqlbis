DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetServiceCategoryForClientContract`(clcode text, concode text) RETURNS varchar(100) CHARSET utf8
BEGIN
    DECLARE package varchar(100);

    SET package=(select trim(upper(servicecategory)) from rcbill_my.customercontractsnapshot where 
					clientcode=clcode
					and
					contractcode=concode
                    limit 1
				);

	RETURN package;

  END$$
DELIMITER ;
