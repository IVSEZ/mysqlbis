/*
select *, datediff(reportdate,lastactivedate) as dd from rcbill_my.rep_allcust
where datediff(reportdate,lastactivedate)>=30;
 
select * from rcbill_my.rep_clientcontractdevices;
select * from rcbill_my.customers_cmts_mxk;
*/

select a.reportdate, a.clientcode,a.clientname, a.firstcontractdate, a.lastpaymentdate, a.lastactivedate
, datediff(a.reportdate,a.lastactivedate) as dayssinceactive
, a.clientaddress
, a.clientlocation ,a.clientarea 
-- , a.*
, b.fsan, b.CONTRACT_CODE, b.SERVICE_TYPE
, c.mxk_name, c.mxk_interface, c.mxk_date
, c.hfc_node, c.cmts_date
from 
rcbill_my.rep_allcust a 
left join
rcbill_my.rep_clientcontractdevices b
on a.clientcode=b.CLIENT_CODE

left join
rcbill_my.customers_cmts_mxk c 
on a.clientcode=c.client_code
and b.CONTRACT_CODE=c.contract_code

where datediff(a.reportdate,a.lastactivedate)>=90
and ( b.fsan is not null and length(b.fsan)>0)
;

