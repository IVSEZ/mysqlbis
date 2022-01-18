select reportdate, count(*) as cust_count from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and PARCEL_PRESENT='NOT PRESENT' group by reportdate;

select *
-- , clientcode, clientname, clientclass, IsAccountActive, accountactivitystage 
from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and PARCEL_PRESENT='NOT PRESENT';