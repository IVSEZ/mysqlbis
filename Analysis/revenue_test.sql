	use rcbill;
  
-- set @custid=693929; -- GILBERT ELISA
-- set @custid=723470; -- gert corenlius
-- set @custid=694263; -- chalets d'anse forbans 

select *, (select name from rcbill.rcb_payobjects where id=payobjectid) as PAYOBJECTNAME
, (select name from rcbill.rcb_services where id=(paytype*-1)) as PAYTYPENAME
, (select name from rcbill.rcb_cashpoints where id=CashPointID) as CASHPOINTNAME 
from rcbill.rcb_casa where clid=@custid
-- and (hard not in (100, 101, 102) or hard is null)
order by PAYDATE
;

select * from rcbill.rcb_tclients where id=@custid;

select hard, sum(money), count(*), min(paydate), max(paydate) from rcbill.rcb_casa where clid=@custid group by hard;

select hard, sum(money), count(*), min(paydate), max(paydate) from rcbill.rcb_casa group by hard order by 5;

select month(PAYDATE) as PAYMONTH, year(PAYDATE) as PAYYEAR, hard, sum(money) as totalpaid, count(*) as totalpayments 
from rcbill.rcb_casa 
group by 1,2,3 
order by 2 desc, 1 desc
-- with rollup
;

select * from rcbill_my.customers_collection where clid=@custid;


select * from rcbill.rcb_invoicesheader where clid=@custid;
select * from rcbill.rcb_invoicesheader where type=11 and clid=@custid;
select * from rcbill.rcb_invoicescontents where clid=@custid;
  
    
		(select clid
         , cid
        , COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
		from rcb_invoicesheader
		where
		-- (hard not in (100, 101, 102) or hard is null)
        -- and 
        clid=@custid
		group by clid
         , cid
        );
        
        /*
		group by clid, cid) as b

		on a.CL_CLIENTID=b.clid
		and a.CON_CONTRACTID=b.cid

		left join
		*/
        
        (
			select a.*, (select sum(ac.money) from rcbill.rcb_casa ac where ac.clid=a.clid 
            and ac.cid=a.cid 
            and date(ac.enterdate)=date(LastPaymentDate)) as LastPaidAmount
            from 
            (
			select clid
			 , cid
			, COALESCE(sum(money),0) as TotalPaymentAmount  
			-- , sum(money) as LastPaidAmount
			-- , (select sum(ac.money) from rcbill.rcb_casa ac where ac.clid=clid and date(ac.enterdate)=date(max(EnterDate))) as LastPaidAmount  
			, COALESCE(count(*),0) as TotalPayments, date(min(ENTERDATE)) as FirstPaymentDate, date(max(ENTERDATE)) as LastPaymentDate
			from rcb_casa
			where
			-- (hard not in (100, 101, 102) or hard is null)
			-- and 
			clid=@custid
			group by clid, cid
            ) a
        );-- as c

		/*
		on a.CL_CLIENTID=c.clid
		and a.CON_CONTRACTID=c.cid
        
        */
        
        -- select sum(cciv.LastPaidAmount) from clientcontractinvpmt cciv where cciv.CL_CLIENTID=@custid and date(cciv.LastPaymentDate)=date('2018-08-01')


--  select * from rcbill_my.rep_clientcontractdevices where client_id=722866 