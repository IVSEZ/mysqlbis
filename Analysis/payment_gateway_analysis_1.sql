select * from rcbill.clientcontractip
--  where CLIENTCODE='I.000011750' 
order by USAGEDATE desc;
select * from rcbill.clientcontractipmonth where CLIENTCODE='I.000011750' order by USAGE_MTH desc, USAGE_YR desc;


select * from rcbill.clientcontractip where PROCESSEDCLIENTIP='41.220.106.136' limit 100;



### GET DETAILS OF ICARE PAYMENT FROM RCBOSS ONLINE PAYMENTS TABLE
select * from 
(
select *, datediff(debtperiodto, debtperiodfrom) as paiddays from rcbill_my.onlinepayments where date(paymentdate)>'2018-06-30' order by paymentdate desc
) a
-- where paiddays>40 -- and PAYMENTAMOUNT>3000
order by PAYMENTDATE desc
;



### GET LOGS OF PAYMENTS MADE
select * from rcbill_analysis.payment_gateway_log order by log_date desc;


### JOIN THEM TOGETHER ON CLIENTID
select a.*, b.*
from 
(
	select * from rcbill_analysis.payment_gateway_log order by log_date desc
) a
left join
(

	select * from 
	(
	select *, datediff(debtperiodto, debtperiodfrom) as paiddays from rcbill_my.onlinepayments where date(paymentdate)>'2018-06-30' order by paymentdate desc
	) a
	-- where paiddays>40 -- and PAYMENTAMOUNT>3000
	order by PAYMENTDATE desc

) b
on
a.icare_id=b.clientid
and date(a.log_date)=date(b.paymentdate)
order by b.paymentdate desc
;


###############################################################################################################

### GET CLIENT CONTRACT IP FOR THAT USAGE DATES
drop table if exists rcbill_analysis.tempccip;
create table rcbill_analysis.tempccip
(index idxud(usagedate), index idxcc(clientcode), index idxcid(clientid), index idxip(processedclientip) )
as
(
	select * from rcbill.clientcontractip where USAGEDATE>'2018-06-30' order by usagedate desc
)
;


### JOIN CLIENTCONTRACTIP WITH PAYMENT GATEWAY LOGS TO SEE WHICH PAYMENTLOG TIES TO WHICH INTELVISION IP ADDRESS AND CUSTOMER
drop table if exists rcbill_analysis.temppglccip;
create table rcbill_analysis.temppglccip
(
index idxpglccip1(log_icare_id), index idxpglccip2(log_date)
)
as 
(

	select a.id as log_id, date(a.log_date) as log_date, a.log_date as log_datetime, a.icare_user as log_icare_user, a.icare_id as log_icare_id, a.ip_address as log_ip_address
    , a.price as log_price, a.message as log_message
    ,b.clientid as ip_clientid,b.clientcode as ip_clientcode, b.clientname as ip_clientname, b.contractcode as ip_contractcode
    , b.processedclientip as ip_processedclientip, b.usagedate as ip_usagedate 
	from 
	(
		select * from rcbill_analysis.payment_gateway_log order by log_date desc
	) a
	left join
	rcbill_analysis.tempccip b 
	on 
	date(a.log_date)=b.usagedate
	and a.ip_address=b.processedclientip


)
;

### JOIN ABOVE TABLE WITH ONLINE PAYMENT TO SEE WHICH PAYMENTS WERE MADE BY ABOVE LOG

drop table if exists rcbill_analysis.logippayment;

create table rcbill_analysis.logippayment 
(
	index idxlip1(log_icare_id),
    index idxlip2(log_date)
)
as
(

	select a.*
	, b.clientid as pay_clientid, b.paymentid as pay_paymentid, b.externalref as pay_externalref, date(b.paymentdate) as pay_date, b.paymentdate as pay_datetime
	, b.user as pay_user, b.cashpoint as pay_cashpoint, b.clientcode as pay_clientcode, b.clientname as pay_clientname 
	, b.paymentamount as pay_amount, b.service as pay_service, b.package as pay_package
	, b.paymentcomment as pay_comment, b.clientclass as pay_clientclass, b.contractcode as pay_contractcode, b.receiptid as pay_receiptid
	, b.debtperiodfrom as pay_debtperiodfrom, b.debtperiodto as pay_debtperiodto, b.paiddays as pay_paiddays
	from 
	rcbill_analysis.temppglccip a
	left join
	(

		select * from 
		(
		select *, datediff(debtperiodto, debtperiodfrom) as paiddays from rcbill_my.onlinepayments where date(paymentdate)>'2018-06-30' order by paymentdate desc
		) a
		-- where paiddays>40 -- and PAYMENTAMOUNT>3000
		order by PAYMENTDATE desc

	) b
	on
	a.log_icare_id=b.clientid
	and date(a.log_date)=date(b.paymentdate)
	order by a.log_datetime desc
)
;

select * from rcbill_analysis.logippayment;
select * from rcbill_analysis.logippayment where pay_paiddays>40 or log_price>2000;-- where pay_clientname like '%estelle mona%';
-- select * from rcbill_analysis.logippayment where ip_clientid is null;-- where pay_clientname like '%estelle mona%';
select distinct log_message, count(*) from rcbill_analysis.logippayment group by log_message order by 2 desc;
select distinct log_message, count(*) from rcbill_analysis.logippayment where log_message not like '%Confirmed payment%' group by log_message order by 2 desc;

select * from rcbill_analysis.logippayment where log_message='CyberSourceError:Do not honor:05:DCARDREFUSED';
select * from rcbill_analysis.logippayment where log_message='CyberSourceError:Lost card, pick up (fraud account):41:DCARDREFUSED';
select * from rcbill_analysis.logippayment where log_message='CyberSourceError:Stolen card, pick up (fraud account):43:DCARDREFUSED';

select log_icare_user, log_icare_id, log_message, count(*) as count_message 
from rcbill_analysis.logippayment
-- where log_message like ('%DCARDREFUSED%','%DINVALIDDATA%','%DCARDEXPIRED%','%DINVALIDCARD%','%error%','%invalid%')
where log_message REGEXP 'DCARDREFUSED|DINVALIDDATA|DCARDEXPIRED|DINVALIDCARD|error|invalid|refused'
group by log_icare_user, log_icare_id, log_message
;

select log_icare_id, log_icare_user
, rcbill.GetClientCode(log_icare_id) as log_clientcode
, rcbill.GetClientNameFromID(log_icare_id) as log_clientname
, log_date, count(distinct log_datetime) as attempts
from rcbill_analysis.logippayment
group by 1,2,3, 4, 5
order by 6 desc
;
		-- select *, datediff(debtperiodto, debtperiodfrom) as paiddays from rcbill_my.onlinepayments where date(paymentdate)>'2018-06-30' order by paymentdate desc
