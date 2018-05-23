DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetDiscount`(clientcode text, contractcode text) RETURNS decimal(50,5)
BEGIN
    DECLARE discount decimal(50,5);

	SET discount = (select Discount from rcbill.rcb_invoicescontents where id in (select max(ID) from rcbill.rcb_invoicescontents where CLID in (select ID from rcbill.rcb_tclients a where a.KOD=clientcode) and CID in (select ID from rcbill.rcb_contracts b where b.KOD=contractcode) and RPDiscountID is not null));

-- select * from rcbill.rcb_invoicescontents where id in (select max(id) from rcbill.rcb_invoicescontents where clid in (712268) and cid in (1410424) and rpdiscountid is not null);
-- (select max(Discount) from rcbill.rcb_invoicescontents where	CLID in (select ID from rcbill.rcb_tclients a where a.KOD=clientcode) and CID in (select ID from rcbill.rcb_contracts b where b.KOD=contractcode) and RPDiscountID is not null);

    RETURN discount;
  END$$
DELIMITER ;

-- select `rcbill`.`GetDiscount`('I20355','I.000269851');
