use rcbill_my;


drop table if exists rcbill_my.rep_prepaid_camera;

create table rcbill_my.rep_prepaid_camera as 
(
-- PREPAID AND CAMERA REPORT FOR LYNSEY
	select distinct date(entrydate) as PAYMENT_DATE, rcbill_my.GetWeekdayName(weekday(entrydate)) as WEEKDAY
	, trim(SUBSTRING_INDEX(SUBSTRING_INDEX(salescomment, ',', 1),'/',-1)) as SALE_TYPE
	, trim(SUBSTRING_INDEX(SUBSTRING_INDEX(salescomment, ',', 2),',',-1)) as VALIDITY_PERIOD
	, PLACE as SALE_MEDIUM
	, CASHPOINT as SALE_POINT
 
	, CLIENTCODE AS CLIENT_CODE
    , CLIENTNAME as CLIENT_NAME
	, count(*) as SALES_COUNT
    , sum(amount) as PAYMENT_AMOUNT  

	from rcbill_my.dailysinglesales 
	group by 1,2,3,4,5,6, 7
	order by 1 desc
    
);

-- select * from rcbill_my.rep_prepaid_camera;
-- select * from rcbill_my.dailysinglesales ;

drop table if exists rcbill_my.rep_addon;

create table rcbill_my.rep_addon (INDEX IDXrepadd1(CLIENT_CODE)) as 
(
-- ADDON REPORT FOR LYNSEY
	select 
    date(a.paymentdate) as PAYMENT_DATE
    ,rcbill_my.GetWeekdayName(weekday(a.paymentdate)) as WEEKDAY
    ,a.salestype as SALE_TYPE
    ,a.place as SALE_MEDIUM
    ,a.cashpoint as SALE_POINT
    ,a.paymentamount as PAYMENT_AMOUNT
    ,a.clientcode as CLIENT_CODE
    ,upper(a.clientname) as CLIENT_NAME
    ,a.contractcode as CONTRACT_CODE
    ,b.clientclass as CLIENT_CLASS
    , b.clienttype as CLIENT_TYPE
    ,a.salescomment as SALE_COMMENT
    ,a.CANCELLATIONREASON as CANCELLATION_REASON
    ,a.RECEIPTID as RECEIPT_ID

	from 
	rcbill_my.dailyaddonsales a
	left join 
	rcbill_my.customercontractactivity b
	on
	a.CLIENTCODE=b.clientcode
	and 
	a.CONTRACTCODE=b.contractcode
	and
	date(a.paymentdate)=b.period
	order by a.paymentdate desc
);



select count(*) as rep_prepaid_camera from rcbill_my.rep_prepaid_camera;
select count(*) as rep_addon from rcbill_my.rep_addon;

-- select * from rcbill_my.rep_addon;

