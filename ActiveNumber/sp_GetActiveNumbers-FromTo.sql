DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetActiveNumberFromTo`(IN periodfrom date, IN periodto date)
BEGIN

SELECT 
    period,
    periodday,
    periodmth,
    periodyear,
    weekday,
    mthname,
    service,
    servicecategory,
    servicesubcategory,
    servicetype,
    clientclass,
    clienttype,
    region,
    decommissioned,
    reported,
    SUM(open) AS open_s,
    SUM(new) AS new_s,
    SUM(newconverted) AS newc_s,
    SUM(renew) AS renew_s,
    SUM(closed) AS closed_s,
    SUM(closednonpayment) AS closednon_s,
    SUM(suspended) AS suspended_s,
    SUM(closedconverted) AS closedcon_s,
    SUM(closedother) AS closedoth_s,
    SUM(totalopened) AS totopn_s,
    SUM(totalclosed) AS totcld_s,
    SUM(difference) AS diff_s
FROM
    rcbill_my.activenumber

where 
period >= periodfrom
and
period <= periodto
/*
and 
decommissioned in (decom) 
and 
reported in (rpt)
*/

GROUP BY period , periodday , periodmth , periodyear , weekday , mthname , service , servicecategory , servicesubcategory , servicetype , clientclass, clienttype , region , decommissioned , reported
ORDER BY period
;

END$$
DELIMITER ;
