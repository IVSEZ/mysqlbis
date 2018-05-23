DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetServicePrice`(service text, servicetype text) RETURNS decimal(12,5) 
BEGIN
    DECLARE serviceprice decimal(12,5);

	SET serviceprice = (select max(price) from rcbill.rcb_vpnrates where ServiceID in (select id from rcbill.rcb_services where trim(upper(name)) in (trim(upper(service))))	and trim(upper(name)) in (trim(upper(servicetype))));

    RETURN serviceprice;
  END$$
DELIMITER ;
