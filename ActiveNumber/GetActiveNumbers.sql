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
WHERE
     periodday = 3 AND periodmth = 1
        AND periodyear = 2017
-- WHERE
/*    periodday = 5 AND periodmth = 11
        AND periodyear = 2016
        AND */
--        decommissioned = 'N'
--        AND reported = 'Y'
GROUP BY period , periodday , periodmth , periodyear , weekday , mthname , service , servicecategory , servicesubcategory , servicetype , clientclass, clienttype , region , decommissioned , reported
ORDER BY periodyear , periodmth , periodday


;