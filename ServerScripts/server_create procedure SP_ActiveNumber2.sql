DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActiveNumber2`()
BEGIN
drop table if exists rcbill_my.anreport;

create table rcbill_my.anreport as
(
SELECT 
    period,
    periodday,
    periodmth,
    periodyear,
    weekday,
    mthname,
    service,
    servicecategory,
    GetServiceCategory2(service) as servicecategory2,
    servicesubcategory,
    servicetype,
    getcleanstring(servicetypeold) as package,
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
/*
where 
periodday = pdday
and
periodmth = pdmth
and
periodyear = pdyr
*/
/*
and 
decommissioned in (decom) 
and 
reported in (rpt)
*/

GROUP BY period , periodday , periodmth , periodyear , weekday , mthname , 
service , servicecategory , servicecategory2, servicesubcategory , servicetype , package,
clientclass, clienttype , region , decommissioned , reported
ORDER BY periodyear , periodmth , periodday
)
;

CREATE INDEX IDXan1
ON rcbill_my.anreport (period);

CREATE INDEX IDXan2
ON rcbill_my.anreport (servicetype);

CREATE INDEX IDXan3
ON rcbill_my.anreport (package);

CREATE INDEX IDXan4
ON rcbill_my.anreport (clienttype);

CREATE INDEX IDXan5
ON rcbill_my.anreport (clientclass);

END$$
DELIMITER ;
