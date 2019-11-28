# INTELENOVELA as per New Sales #
-- set @startdate='2018-01-01';
-- set @enddate='2018-08-31';
-- set @package='INTELENOVELA';
SET @row_number = 0;

SET @startdate='2019-01-01';
-- select @startdate := subdate(current_date(),1);


-- select @enddate := subdate(current_date(),1);
SET @enddate='2019-08-31';

-- select *, datediff(lastactivedate, firstactivedate) as ActiveDays, if(datediff(lastactivedate, firstactivedate)=0 and IsAccountActive='InActive','Pending','Done') as InstallationStatus from rcbill_my.rep_custconsolidated where firstactivedate>=@startdate and firstactivedate<=@enddate;

SELECT 
    a.*,
    CASE
        WHEN
            IsAccountActive = 'InActive'
                AND activedays = 0
        THEN
            'Pending'
        WHEN
            IsAccountActive = 'InActive'
                AND activedays < 30
        THEN
            'Verify'
        ELSE
            'Done'
    END AS InstallationStatus
FROM
    (SELECT 
        *, DATEDIFF(lastactivedate, firstactivedate) AS ActiveDays
    FROM
        rcbill_my.rep_custconsolidated
    WHERE
        firstactivedate >= @startdate
            AND firstactivedate <= @enddate) a
            
order by a.firstactivedate desc
;

select * from rcbill_my.rep_servicetickets_2019 where tickettype='installation' order by ticketid desc, assgnopendate asc;

SELECT DISTINCT
    ticketid
FROM
    rcbill_my.rep_servicetickets_2019
WHERE
    tickettype = 'installation';


