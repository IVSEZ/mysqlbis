set @custcode='I3733';

				select *
				from rcbill_my.customers_collection a
				where 
				a.clientcode=@custcode
				
				order by a.lastpaymentdate desc;
                
                
	select
    -- *,
    ENTERDATE as TransactionDate
    , ID as PAYMENTID
    , rcbill.GetCashPoint(CashPointID) as CashPoint
    , rcbill.GetPayObject(PAYOBJECTID) as PayObject
    
    , rcbill.GetClientCode(clid) as ClientCode, rcbill.GetContractCode(cid) as ContractCode
    -- , PAYDATE as PayDate
    , MONEY as PaymentAmount
    , (SELECT INVOICENO FROM rcbill.rcb_invoicesheader where id=a.INVID) as InvoiceNo
    , (Select `name` from rcbill.rcb_tickettechusers where RCBUSERID=a.USERID) as TransactionUser
    , ZAB as TransactionComment
    , rcbill.GetPayType(PAYTYPE*-1) as SubType
	, date(BegDate) as SubStartDate
	, date(EndDate) as SubEndDate

    , hard
    /*clid
	, cid
    , rcbill.GetClientCode(clid) as ClientCode, rcbill.GetContractCode(cid) as ContractCode
	, month(PAYDATE) as PAYMONTH, year(PAYDATE) as PAYYEAR 
	, COALESCE(sum(money),0) as TotalPaymentAmount  
	, COALESCE(count(*),0) as TotalPayments, date(min(ENTERDATE)) as FirstPaymentDate, date(max(ENTERDATE)) as LastPaymentDate
    , now() as InsertedOn
    */
	from rcbill.rcb_casa a 
	where clid=(select id from rcbill.rcb_tclients where kod in ('I3733'))
	and (hard not in (100, 101, 102) or hard is null)
    order by ENTERDATE desc
	;
    
    
    				select
				ENTERDATE as TransactionDate
				, ID as PAYMENTID
				, rcbill.GetCashPoint(CashPointID) as CashPoint
				, rcbill.GetPayObject(PAYOBJECTID) as PayObject
				
				, rcbill.GetClientCode(clid) as ClientCode, rcbill.GetContractCode(cid) as ContractCode
				, MONEY as PaymentAmount
				, (SELECT INVOICENO FROM rcbill.rcb_invoicesheader where id=a.INVID) as InvoiceNo
				, (Select `name` from rcbill.rcb_tickettechusers where RCBUSERID=a.USERID) as TransactionUser
				, ZAB as TransactionComment
				, rcbill.GetPayType(PAYTYPE*-1) as SubType
				, BegDate as SubStartDate
				, EndDate as SubEndDate
				, hard
				from rcbill.rcb_casa a 
				where a.clid=(select id from rcbill.rcb_tclients where kod in ('I3733'))
				and (hard not in (100, 101, 102) or hard is null)
				order by ENTERDATE desc
    
    