use rcbill_my;

-- PREPAID AND CAMERA REPORT FOR LYNSEY
	select distinct date(entrydate) as entrydate, rcbill_my.GetWeekdayName(weekday(entrydate)) as weekday
	, clientname
	, trim(SUBSTRING_INDEX(SUBSTRING_INDEX(salescomment, ',', 1),'/',-1)) as PrepaidType
	, trim(SUBSTRING_INDEX(SUBSTRING_INDEX(salescomment, ',', 2),',',-1)) as ValidityPeriod
	, place
	, cashpoint
	, count(*) as salescount, sum(amount) as salesamount

	from rcbill_my.dailysinglesales 
	group by 1,2,3,4,5,6, 7
	order by 1 desc;


-- ADDON REPORT FOR LYNSEY
	select a.*, b.clientclass, b.clienttype 
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
	;