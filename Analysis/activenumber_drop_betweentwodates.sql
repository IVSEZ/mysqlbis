select * from rcbill_my.customercontractsnapshot where servicecategory2='TV' and lastcontractdate='2021-07-31';
select * from rcbill_my.customercontractsnapshot where clientcode in 
(
	select clientcode from rcbill_my.customercontractsnapshot where servicecategory2='TV' and lastcontractdate='2021-07-31'
)
and CurrentStatus='Active'
;

select * from rcbill_my.rep_custconsolidated where clientcode in 
(
	select clientcode from rcbill_my.customercontractsnapshot where servicecategory2='TV' and lastcontractdate='2021-07-31'
)
;


select * from rcbill_my.dailyactivenumber where PERIOD='2021-07-31' and SERVICECATEGORY='TV';
select * from rcbill_my.dailyactivenumber where PERIOD='2021-08-01' and SERVICECATEGORY='TV';

select sum(activecount) from rcbill_my.dailyactivenumber where PERIOD='2021-07-31' and SERVICECATEGORY='TV';
select sum(activecount) from rcbill_my.dailyactivenumber where PERIOD='2021-08-01' and SERVICECATEGORY='TV';

select * from rcbill_my.dailyactivenumber where PERIOD='2021-07-31' and SERVICECATEGORY='TV'
and contractid not in 
(
 select contractid from rcbill_my.dailyactivenumber where PERIOD='2021-08-01' and SERVICECATEGORY='TV'
)
;