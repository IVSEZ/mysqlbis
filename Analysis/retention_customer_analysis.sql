select * from rcbill_my.rep_custconsolidated where upper(clientname) like '%RETENTION%';


### CUSTOMERS WHO GOT RETENTION DISCOUNT ON HARDWARE
select * from  rcbill_my.clientticketjourney 
where 
commentuser in ('Rahul Walavalkar') 
and 
(trim(upper(comment)) REGEXP 'APPROVED FOR RETENTION')
order by commentdate desc;

SELECT * FROM rcbill_my.rep_custconsolidated
where clientcode in 
(
	select clientcode from  rcbill_my.clientticketjourney 
	where 
	commentuser in ('Rahul Walavalkar') 
	and 
	(trim(upper(comment)) REGEXP 'APPROVED FOR RETENTION')
	order by commentdate desc
)
order by IsAccountActive desc, AccountActivityStage desc
;

### CUSTOMERS WHO GOT 1 MONTH RETENTION DISCOUNTS ON SUBSCRIPTION
select * from  rcbill_my.clientticketjourney 
where 
commentuser in ('Rahul Walavalkar') 
and 
(trim(upper(comment)) regexp 'APPROVED FOR 1 MONTH RETENTION')
order by commentdate desc;


SELECT * FROM rcbill_my.rep_custconsolidated
where clientcode in 
(
	select clientcode from  rcbill_my.clientticketjourney 
	where 
	commentuser in ('Rahul Walavalkar') 
	and 
	(trim(upper(comment)) regexp 'APPROVED FOR 1 MONTH RETENTION')
	order by commentdate desc
)
order by IsAccountActive desc, AccountActivityStage desc
;


	SELECT 
    a.reportdate,
    DATE(b.commentdate) AS discountapproveddate,
    a.clientcode,
    a.currentdebt,
    a.IsAccountActive,
    a.AccountActivityStage,
    a.lastactivedate,
    a.dayssincelastactive,
    a.clientname,
    a.clientclass,
    a.activenetwork,
    a.activeservices,
    a.activecontracts,
    a.activesubscriptions,
    a.clientaddress,
    a.totalpaymentamount,
    a.TotalPaymentAmount2019,
    a.AvgMonthlyPayment2019,
    a.TotalPaymentAmount2018,
    a.AvgMonthlyPayment2018,
    a.clientemail,
    a.clientphone
FROM
    rcbill_my.rep_custconsolidated a
        LEFT JOIN
    rcbill_my.clientticketjourney b ON a.clientcode = b.clientcode
WHERE
    b.commentuser IN ('Rahul Walavalkar')
        AND (TRIM(UPPER(b.comment)) REGEXP 'APPROVED FOR 1 MONTH RETENTION')
ORDER BY a.IsAccountActive DESC , a.AccountActivityStage DESC

;


	SELECT 
    a.reportdate,
    DATE(b.commentdate) AS discountapproveddate,
    a.clientcode,
    a.currentdebt,
    a.IsAccountActive,
    a.AccountActivityStage,
    a.lastactivedate,
    a.dayssincelastactive,
    a.clientname,
    a.clientclass,
    a.activenetwork,
    a.activeservices,
    a.activecontracts,
    a.activesubscriptions,
    a.clientaddress,
    a.totalpaymentamount,
    a.TotalPaymentAmount2019,
    a.AvgMonthlyPayment2019,
    a.TotalPaymentAmount2018,
    a.AvgMonthlyPayment2018,
    a.clientemail,
    a.clientphone
FROM
    rcbill_my.rep_custconsolidated a
        LEFT JOIN
    rcbill_my.clientticketjourney b ON a.clientcode = b.clientcode
WHERE
    b.commentuser IN ('Rahul Walavalkar')
        AND (TRIM(UPPER(b.comment)) REGEXP 'APPROVED FOR RETENTION')
ORDER BY a.IsAccountActive DESC , a.AccountActivityStage DESC

;

/*
	select clientcode, count(*) from  rcbill_my.clientticketjourney 
	where 
	commentuser in ('Rahul Walavalkar') 
	and 
	(trim(upper(comment)) like '%APPROVED FOR 1 MONTH RETENTION%')-- or trim(upper(comment)) like 'APPROVED FOR RETENTION%' or trim(upper(comment)) like '%APPROVED FOR RETENTION')
	group by clientcode
    order by 2 desc
*/