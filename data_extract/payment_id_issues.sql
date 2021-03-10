
set @custid1 = 'CA_I9520';
set @clid1 = 691507;
set @clid1 = 723711;
set @custid1 = 'CA_I.000002989';
set @custid1 = 'CA_I53';


select a.* from rcbill_extract.IV_BILLSUMMARY a where a.CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_BILLDETAIL where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_PAYMENTHISTORY where CUSTOMERACCOUNTNUMBER in (@custid1) order by PAYMENTRECEIPTID desc;



select a.* from rcbill_extract.IV_BILLSUMMARY a where a.CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_BILLDETAIL where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_PAYMENTHISTORY where CUSTOMERACCOUNTNUMBER in (@custid1) order by PAYMENTRECEIPTID desc;


select a.* from rcbill_extract.IV_BILLSUMMARY_SAMPLE a where a.CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_BILLDETAIL_SAMPLE where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_PAYMENTHISTORY_SAMPLE where CUSTOMERACCOUNTNUMBER in (@custid1) order by PAYMENTRECEIPTID desc;


select a.*
, b.PAYMENTDATE, b.fromdate as PAY_FROM, b.todate as PAY_TO

from rcbill_extract.IV_BILLSUMMARY_SAMPLE a 
left join 
rcbill_extract.IV_PAYMENTHISTORY_SAMPLE b 
on a.paymentreceiptid=b.paymentreceiptid
where a.CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc
;

select a.*
,
case when a.FROMDATE<>a.pay_from then 1
else 0 end as FROMDATE_CHECK
, 
case when a.TODATE<>a.pay_to then 1
else 0 end as TODATE_CHECK
from
(
	select a.*
	, b.PAYMENTDATE, b.fromdate as PAY_FROM, b.todate as PAY_TO

	from rcbill_extract.IV_BILLSUMMARY_SAMPLE a 
	left join 
	rcbill_extract.IV_PAYMENTHISTORY_SAMPLE b 
	on a.paymentreceiptid=b.paymentreceiptid
	where a.CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc
) a
;






set @custid1 = 'CA_999';
select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );

set @custid1 = 'CA_I.000000009';
select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );



select * from rcbill_extract.IV_PAYMENTHISTORY_SAMPLE where PAYMENTMODE in ('OTHER') order by PAYMENTRECEIPTID desc;


select * from rcbill.rcb_invoicesheader where CLID in (691507);