select * from rcbill.rcb_cmts;
select date(insertedon), hfc_node, count(*)
from rcbill.rcb_cmts
group by 1,2
order by 1
;

SELECT DISTINCT
    service
FROM
    rcbill_my.rep_servicetickets_2019;
    
SELECT DISTINCT
    clean_connection_type
FROM
    rcbill_my.rep_servicetickets_2019;
    
SELECT DISTINCT
    activenetwork
FROM
    rcbill_my.rep_servicetickets_2019;


#######################################################
-- ticket types: fault	Hardware	CreditNote	installation	Audit	Relocation	Survey


SELECT 
    *
    -- distinct tickettype
FROM
    (SELECT 
        *
        , rcbill_my.GetNetworkForClientContract(clientcode, contractcode) as CON_NETWORK
        , rcbill_my.GetServiceCategoryForClientContract(clientcode, contractcode) as CON_SERVICECATEGORY
    FROM
        rcbill_my.rep_servicetickets_2019) a 
WHERE
    YEAR(a.opendate) = 2019
    /*
        AND (clean_connection_type = 'HFC'
        OR clean_connection_type IS NULL)
        AND (activenetwork NOT IN ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON')
        OR activenetwork IS NULL)
	*/
    
    
    -- and a.CON_NETWORK='HFC'
    -- and a.CON_NETWORK='GPON'
    and a.CON_NETWORK is null
	
    
    and trim(upper(a.tickettype)) in ('FAULT','HARDWARE')
;

-- I22320	I.000320304
-- select * from rcbill_my.customercontractsnapshot where clientcode='I22320' and contractcode='I.000320304';
-- select rcbill_my.GetNetworkForClientContract('I22320','I.000320304');
-- select rcbill_my.GetServiceCategoryForClientContract('I22320','I.000320304');
/*
select distinct servicecategory from rcbill_my.customercontractsnapshot;

*/
#######################################################
set @cct='HFC';

### TV TICKETS FOR HFC
-- set @service='DTV';

### INTERNET TICKETS FOR HFC
-- set @service='INTERNET';

### VOIP TICKETS FOR HFC
-- set @service='VOIP';


### SERVICE TICKETS FOR HFC

drop table if exists rcbill_my.rep_faulttickets;


SELECT 
    CON_NETWORK AS network,
    CON_SERVICECATEGORY AS service,
    IFNULL(clean_hfc_nodename, '-') AS hfcnode,
    MONTH(opendate) AS openmonth,
    COUNT(DISTINCT ticketid) AS d_tickets
FROM
    (SELECT 
        *,
            rcbill_my.GetNetworkForClientContract(clientcode, contractcode) AS CON_NETWORK,
            rcbill_my.GetServiceCategoryForClientContract(clientcode, contractcode) AS CON_SERVICECATEGORY
    FROM
        rcbill_my.rep_servicetickets_2019) a
WHERE
    YEAR(a.opendate) >= 2018
        AND a.CON_NETWORK = 'HFC'
        AND TRIM(UPPER(a.tickettype)) IN ('FAULT' , 'HARDWARE')
GROUP BY 1 , 2 , 3 , 4
ORDER BY 1 ASC , 2 ASC , 3 ASC , 4 ASC
;


#########################################################


### SERVICE TICKETS FOR GPON
SELECT 
    CON_NETWORK AS network,
    CON_SERVICECATEGORY AS service,
    IFNULL(clean_mxk_name, '-') AS mxkname,
    MONTH(opendate) AS openmonth,
    COUNT(DISTINCT ticketid) AS d_tickets
FROM
    (SELECT 
        *,
            rcbill_my.GetNetworkForClientContract(clientcode, contractcode) AS CON_NETWORK,
            rcbill_my.GetServiceCategoryForClientContract(clientcode, contractcode) AS CON_SERVICECATEGORY
    FROM
        rcbill_my.rep_servicetickets_2019) a
WHERE
    YEAR(opendate) = 2019
        AND a.CON_NETWORK = 'GPON'
        AND TRIM(UPPER(a.tickettype)) IN ('FAULT' , 'HARDWARE')
GROUP BY 1 , 2 , 3 , 4
ORDER BY 1 ASC , 2 ASC , 3 ASC , 4 ASC
;


### SERVICE TICKETS FOR NULL network
SELECT 
    CON_NETWORK AS network,
    CON_SERVICECATEGORY AS service,
    IFNULL(clean_mxk_name, '-') AS mxkname,
    MONTH(opendate) AS openmonth,
    COUNT(DISTINCT ticketid) AS d_tickets
FROM
    (SELECT 
        *,
            rcbill_my.GetNetworkForClientContract(clientcode, contractcode) AS CON_NETWORK,
            rcbill_my.GetServiceCategoryForClientContract(clientcode, contractcode) AS CON_SERVICECATEGORY
    FROM
        rcbill_my.rep_servicetickets_2019) a
WHERE
    YEAR(opendate) = 2019
        AND a.CON_NETWORK is null
        AND TRIM(UPPER(a.tickettype)) IN ('FAULT' , 'HARDWARE')
GROUP BY 1 , 2 , 3 , 4
ORDER BY 1 ASC , 2 ASC , 3 ASC , 4 ASC
;


##########################################################

############### PIVOT ###########################


