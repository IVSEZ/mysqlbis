/*
select * from rcbill_my.clientstats
where 
-- services like '%TV%' or services like '%ALL%'
-- and 
`Indian`>0 
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
;
*/

-- TV CUSTOMERS
select distinct clientcode, clientname from rcbill_my.clientstats
where services like '%TV%' or services like '%ALL%'
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
;
select count(distinct clientcode) as clientaccounts from rcbill_my.clientstats
where services like '%TV%' or services like '%ALL%'
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
;

select distinct period, clientclass, count(distinct clientcode) as disclients 
from rcbill_my.customercontractactivity
where clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
group by 
1,2
;


-- select  distinct kod, firm from rcbill.rcb_tclients where clclass in (10,13,14);

-- INDIAN TV Customers
select distinct clientcode, clientname from rcbill_my.clientstats
where 
-- services like '%TV%' or services like '%ALL%'
-- and 
`Indian`>0 
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
;
select count(distinct clientcode) as clientaccounts from rcbill_my.clientstats
where 
-- services like '%TV%' or services like '%ALL%'
-- and 
`Indian`>0 
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
;

-- FRENCH TV Customers
select distinct clientcode, clientname from rcbill_my.clientstats
where 
-- services like '%TV%' or services like '%ALL%'
-- and 
`French`>0 
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
;
select count(distinct clientcode) as clientaccounts from rcbill_my.clientstats
where 
-- services like '%TV%' or services like '%ALL%'
-- and 
`French`>0 
 and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
;

-- INTERNET CUSTOMERS
select distinct clientcode, clientname from rcbill_my.clientstats
where services like '%Internet%' or services like '%ALL%'
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
;
select count(distinct clientcode) as clientaccounts from rcbill_my.clientstats
where services like '%Internet%' or services like '%ALL%'
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
;

-- VOICE CUSTOMERS
select distinct clientcode, clientname from rcbill_my.clientstats
where services like '%Voice%' or services like '%ALL%'
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
;
select count(distinct clientcode) as clientaccounts from rcbill_my.clientstats
where services like '%Voice%' or services like '%ALL%'
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
;
