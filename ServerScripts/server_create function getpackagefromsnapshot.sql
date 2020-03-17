DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetPackageFromSnapshot`(clcode text, concode text) RETURNS varchar(100) CHARSET utf8
BEGIN
    DECLARE con_package varchar(100);

    SET con_package=(select package from rcbill_my.customercontractsnapshot where 
					clientcode=clcode
					and
					contractcode=concode
                    order by lastcontractdate desc
					limit 1
				);

	RETURN con_package;

  END$$
DELIMITER ;