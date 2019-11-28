set @hikvision='I.000015720';

-- show index from 

select reportdate
, clientcode
, clientname
-- , rcbill.GetClientName(clientcode) as clientname
, IsAccountActive
, AccountActivityStage
, activenetwork
, clientarea
, activeservices
, TotalPaymentAmount2019
, AvgMonthlyPayment2019
, `201901`
, `201902`
, `201903`
, `201904`
, `201905`
, `201906`
, `201907`
, `201908`
, `201909`
from 
rcbill_my.rep_custconsolidated 
where
TotalPaymentAmount2019>0
and 
 clientclass='RESIDENTIAL'
 and
 clientcode not in (@hikvision)
;


select 
-- CLIENTCODE, isaccountactive, AccountActivityStage, activenetwork 
-- , clientlocation
reportdate
, IsAccountActive
-- , AccountActivityStage
, activenetwork
, clientarea
-- , clientlocation
, sum(TotalPaymentAmount2019) as s_2019
-- , sum(AvgMonthlyPayment2019) as a_2019
, count(clientcode) as clients
, sum(`201901`) as s_201901
-- , count(if(`201901`>0, `201901`,0))
, avg(`201901`) as a_201901
-- , count(if(`201902`>0, `201902`,0))
, sum(`201902`) as s_201902
, avg(`201902`) as a_201902
, sum(`201903`) as s_201903
, avg(`201903`) as a_201903
, sum(`201904`) as s_201904
, avg(`201904`) as a_201904
, sum(`201905`) as s_201905
, avg(`201905`) as a_201905
, sum(`201906`) as s_201906
, avg(`201906`) as a_201906
, sum(`201907`) as s_201907
, avg(`201907`) as a_201907
, sum(`201908`) as s_201908
, avg(`201908`) as a_201908
, sum(`201909`) as s_201909
, avg(`201909`) as a_201909
from rcbill_my.rep_custconsolidated 
where 
TotalPaymentAmount2019>0
and 
clientclass='RESIDENTIAL'
and clientcode not in (@hikvision)
group by reportdate
, IsAccountActive
-- , AccountActivityStage
, activenetwork
, clientarea
-- , clientlocation
;

select 
reportdate
, clientarea
, sum(TotalPaymentAmount2019) as s_2019
-- , sum(AvgMonthlyPayment2019) as a_2019
, count(clientcode) as clients
, sum(`201901`) as s_201901
-- , count(if(`201901`>0, `201901`,0))
, avg(`201901`) as a_201901
-- , count(if(`201902`>0, `201902`,0))
, sum(`201902`) as s_201902
, avg(`201902`) as a_201902
, sum(`201903`) as s_201903
, avg(`201903`) as a_201903
, sum(`201904`) as s_201904
, avg(`201904`) as a_201904
, sum(`201905`) as s_201905
, avg(`201905`) as a_201905
, sum(`201906`) as s_201906
, avg(`201906`) as a_201906
, sum(`201907`) as s_201907
, avg(`201907`) as a_201907
, sum(`201908`) as s_201908
, avg(`201908`) as a_201908
, sum(`201909`) as s_201909
, avg(`201909`) as a_201909
from rcbill_my.rep_custconsolidated 
where 
TotalPaymentAmount2019>0
and 
clientclass='RESIDENTIAL'
and clientcode not in (@hikvision)
group by reportdate
, clientarea
;


select 
reportdate
, activeservices
-- , clientarea
, sum(TotalPaymentAmount2019) as s_2019
-- , sum(AvgMonthlyPayment2019) as a_2019
, count(clientcode) as clients
, sum(`201901`) as s_201901
-- , count(if(`201901`>0, `201901`,0))
, avg(`201901`) as a_201901
-- , count(if(`201902`>0, `201902`,0))
, sum(`201902`) as s_201902
, avg(`201902`) as a_201902
, sum(`201903`) as s_201903
, avg(`201903`) as a_201903
, sum(`201904`) as s_201904
, avg(`201904`) as a_201904
, sum(`201905`) as s_201905
, avg(`201905`) as a_201905
, sum(`201906`) as s_201906
, avg(`201906`) as a_201906
, sum(`201907`) as s_201907
, avg(`201907`) as a_201907
, sum(`201908`) as s_201908
, avg(`201908`) as a_201908
, sum(`201909`) as s_201909
, avg(`201909`) as a_201909
from rcbill_my.rep_custconsolidated 
where 
TotalPaymentAmount2019>0
and 
clientclass='RESIDENTIAL'
and clientcode not in (@hikvision)
group by reportdate
-- , clientarea
, activeservices
;