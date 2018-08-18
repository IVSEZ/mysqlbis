DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetLiveTVDurationForResource`(res varchar(255), vd int, vm int, vy int) RETURNS bigint
BEGIN
    DECLARE ds bigint;

	set ds = (select duration_sec from rcbill_my.rep_livetvstats where resource=res and view_day=vd and view_month=vm and view_year=vy);

    RETURN ds;
  END$$
DELIMITER ;
