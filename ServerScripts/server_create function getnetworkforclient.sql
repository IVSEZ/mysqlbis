DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetNetworkForClient`(clcode text) RETURNS varchar(100) CHARSET utf8
BEGIN
    DECLARE network varchar(100);

    SET network=(select ccs.network 
					from rcbill_my.customercontractsnapshot ccs 
                    where ccs.clientcode=clcode 
                    order by ccs.currentstatus asc, ccs.contractcode desc LIMIT 1
				);

	RETURN network;

  END$$
DELIMITER ;


-- select ccs.network from rcbill_my.customercontractsnapshot ccs where ccs.clientcode=a.KOD order by ccs.currentstatus asc, ccs.contractcode desc LIMIT 1