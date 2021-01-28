select 
reportdate, clientarea, clientcode, currentdebt, IsAccountActive, AccountActivityStage
, clientname, clientclass, clientaddress
, clientemail, clientnin, clientphone
, clean_mxk_name, clean_mxk_interface
, firstactivedate, lastactivedate, dayssincelastactive, firstcontractdate, firstpaymentdate, lastpaymentdate
, lastpaidamount, totalpaymentamount, TotalPaymentAmount2019, AvgMonthlyPayment2019, TotalPaymentAmount2018, AvgMonthlyPayment2018


from rcbill_my.rep_custconsolidated
where (clientarea in ('PRASLIN') or clientaddress like '%PRASLIN%')
-- and IsAccountActive='InActive'

;


select 
reportdate, clientarea, clientcode, currentdebt, IsAccountActive, AccountActivityStage
, clientname, clientclass, clientaddress
, clientemail, clientnin, clientphone
, clean_mxk_name, clean_mxk_interface
, firstactivedate, lastactivedate, dayssincelastactive, firstcontractdate, firstpaymentdate, lastpaymentdate
, lastpaidamount, totalpaymentamount, TotalPaymentAmount2019, AvgMonthlyPayment2019, TotalPaymentAmount2018, AvgMonthlyPayment2018


from rcbill_my.rep_custconsolidated
where clientcode in 
(
	select clientcode from rcbill_my.clientstats
	where region='PRASLIN' and 
	(`services` = 'All'  or `services`  like '%Voice%')
)
;



/* 
-- limit 100;


select clientarea, count(clientcode) as clients from rcbill_my.rep_custconsolidated
group by clientarea
;

select * from rcbill_my.rep_custconsolidated where clientarea='Praslin';

select * from rcbill_my.clientstats
where region='PRASLIN' and 
(`Intel Voice 10`>0 or `Intel Voice 20`>0 or `Voice Plus`>0)
;



select * from rcbill_my.clientstats
where region='PRASLIN' and 
(`services` = 'All'  or `services`  like '%Voice%')
;


select * from rcbill_my.clientstats where region='Praslin';

*/