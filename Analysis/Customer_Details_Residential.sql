
use rcbill_my;

select reportdate, clientcode, currentdebt, IsAccountActive, AccountActivityStage, clientname, clientclass, activenetwork, activeservices, activecontracts, activesubscriptions, clientaddress, clientlocation
, firstactivedate, lastactivedate, dayssincelastactive
, firstcontractdate, firstinvoicedate, firstpaymentdate, lastinvoicedate, lastpaidamount, lastpaymentdate, totalpayments, totalpaymentamount
, clientarea, subdistrict, clientparcel, coord_x, coord_y, latitude, longitude, clientemail, clientnin, clientpassport, clientphone

from rcbill_my.rep_custconsolidated
where clientclass in ('Residential','Corporate','Corporate Bulk')
;
