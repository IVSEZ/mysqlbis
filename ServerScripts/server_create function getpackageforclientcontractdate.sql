use rcbill_my;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetPackageForClientContractDate`(clcode text, concode text, condate date) RETURNS varchar(100) CHARSET utf8
BEGIN
    DECLARE con_package varchar(100);

    SET con_package=(select package from rcbill_my.customercontractactivity where 
					clientcode=clcode
					and
					contractcode=concode
					and
					period=condate limit 1
				);

	RETURN con_package;
    
  END$$
DELIMITER ;