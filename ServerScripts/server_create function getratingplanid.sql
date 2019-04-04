DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetRatingPlanId`(contractcode text) RETURNS int(11)
BEGIN
    DECLARE rpid int(11);
						-- select ratingplanid from rcbill.rcb_contracts where kod in ('I.000197138');
	SET rpid = (select ratingplanid from rcbill.rcb_contracts where kod in (contractcode));

    RETURN rpid;
  END$$
DELIMITER ;
