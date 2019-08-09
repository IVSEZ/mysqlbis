select reportdate, clientcode, IsAccountActive, AccountActivityStage, clientname
, clientclass, clientaddress, clientarea, clientemail, clientnin, clientpassport, clientphone
, firstactivedate, lastactivedate, dayssincelastactive
, totalpaymentamount, TotalPaymentAmount2019, AvgMonthlyPayment2019, TotalPaymentAmount2018, AvgMonthlyPayment2018

from rcbill_my.rep_custconsolidated where IsAccountActive='InActive' and firstactivedate is not null
and AccountActivityStage not in ('1. Alive','2. Snoozing (1 to 7 days)','3. Asleep (8 to 30 days)')
;


select distinct AccountActivityStage from rcbill_my.rep_custconsolidated;

select * from rcbill.rcb_casa where CLID in (select id from rcbill.rcb_tclients where kod='I19613');

select * from rcbill_my.cust_cont_payment_cmts_mxk where c_clientid='I19613';