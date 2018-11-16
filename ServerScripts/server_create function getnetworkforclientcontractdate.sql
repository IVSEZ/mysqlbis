use rcbill_my;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetNetworkForClientContractDate`(clcode text, concode text, condate date) RETURNS varchar(100) CHARSET utf8
BEGIN
    DECLARE network varchar(100);

    SET network=(select network from rcbill_my.customercontractactivity where 
					clientcode=clcode
					and
					contractcode=concode
					and
					period=condate limit 1
				);

	RETURN network;

  END$$
DELIMITER ;