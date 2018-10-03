
select distinct mxk_name from rcbill_my.rep_cust_cont_payment_cmts_mxk order by 1;
select distinct hfc_node from rcbill_my.rep_cust_cont_payment_cmts_mxk order by 1 ;

select distinct clean_mxk_name from rcbill_my.rep_cust_cont_payment_cmts_mxk order by 1 ;
select distinct clean_hfc_node from rcbill_my.rep_cust_cont_payment_cmts_mxk order by 1 ;


select reportdate, clean_mxk_name, clean_hfc_node
, (select district from rcbill.rcb_techregions where INTERFACENAME=clean_hfc_node limit 1) as hfc_district
, network, clean_connection_type, services, clientlocation
, count(clientcode) as clients, count(distinct clientcode) as uniqueclients
, sum(activecontracts) as activecontracts
, sum(totalpaymentamount) as totalpaymentamount
, sum(`201801`) as `201801`, sum(`201802`) as `201802`, sum(`201803`) as `201803`, sum(`201804`) as `201804`
, sum(`201805`) as `201805`, sum(`201806`) as `201806`, sum(`201807`) as `201807`, sum(`201808`) as `201808`
, sum(`201809`) as `201809`, sum(`201810`) as `201810`, sum(`201811`) as `201811`, sum(`201812`) as `201812`
, sum(`TotalPayments2018`) as `TotalPayments2018`
, sum(`TotalPaymentAmount2018`) as `TotalPaymentAmount2018` 
from rcbill_my.rep_cust_cont_payment_cmts_mxk
group by 
-- reportdate, clean_mxk_name, clean_hfc_node, network, clean_connection_type, services, clientlocation
1,2,3,4,5,6,7,8
;


