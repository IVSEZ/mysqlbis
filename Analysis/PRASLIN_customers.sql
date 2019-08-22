select 
reportdate, clientarea, clientcode, currentdebt, IsAccountActive, AccountActivityStage
, clientname, clientclass, clientaddress
, clientemail, clientnin, clientphone
, clean_mxk_name, clean_mxk_interface
, firstactivedate, lastactivedate, dayssincelastactive, firstcontractdate, firstpaymentdate, lastpaymentdate
, lastpaidamount, totalpaymentamount, TotalPaymentAmount2019, AvgMonthlyPayment2019, TotalPaymentAmount2018, AvgMonthlyPayment2018


from rcbill_my.rep_custconsolidated
where (clientarea in ('PRASLIN') or clientaddress like '%PRASLIN%')
and IsAccountActive='InActive'
;



/* 
-- limit 100;


select clientarea, count(clientcode) as clients from rcbill_my.rep_custconsolidated
group by clientarea
;


select * from rcbill_my.rep_custconsolidated
where clientarea='SILHOUETTE ISLAND'
;

*/