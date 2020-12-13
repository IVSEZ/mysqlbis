select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCENUMBER in ('SIN_2755629_94378');

select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCENUMBER in ('SIN_2865802_112440');


select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER = 'CA_I9695';

select * from rcbill.rcb_tclients where kod='I.000001217';

select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR';

select * from rcbill_my.rep_custconsolidated;


set @clientcode1='I13400';
set @clientcode1='I298';

set @clientid1=667979;
set @clientid1=698115;

select * from rcbill.clientreport where CL_CLIENTCODE=@clientcode1;


select clid, COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
		from rcb_invoicesheader
		where
		(hard not in (100, 101, 102) or hard is null)
		and year(data)>=2016
        and
        clid in  (@clientid1)
 		group by clid
        order by 6 desc
        ;
        

			select clid
			 
			, COALESCE(sum(money),0) as TotalPaymentAmount  
			-- , sum(money) as LastPaidAmount
			-- , (select sum(ac.money) from rcbill.rcb_casa ac where ac.clid=clid and date(ac.enterdate)=date(max(EnterDate))) as LastPaidAmount  
			, COALESCE(count(*),0) as TotalPayments, date(min(ENTERDATE)) as FirstPaymentDate, date(max(ENTERDATE)) as LastPaymentDate
			from rcb_casa
			where
			(hard not in (100, 101, 102) or hard is null)
			and year(ENTERDATE)>=2016
            and 
			clid in  (@clientid1)
			group by clid -- , cid
			order by 5 desc
            ;




select clid, cid, COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
		from rcb_invoicesheader
		where
		(hard not in (100, 101, 102) or hard is null)
		and year(data)>=2016
        and
        clid in (@clientid1)
 		group by clid, cid
        order by 7 desc
        -- with rollup
        ;
        

			select clid, cid
			 
			, COALESCE(sum(money),0) as TotalPaymentAmount  
			-- , sum(money) as LastPaidAmount
			-- , (select sum(ac.money) from rcbill.rcb_casa ac where ac.clid=clid and date(ac.enterdate)=date(max(EnterDate))) as LastPaidAmount  
			, COALESCE(count(*),0) as TotalPayments, date(min(ENTERDATE)) as FirstPaymentDate, date(max(ENTERDATE)) as LastPaymentDate
			from rcb_casa
			where
			(hard not in (100, 101, 102) or hard is null)
			and year(ENTERDATE)>=2016
			and 
			clid in (@clientid1)
			group by clid, cid
            order by 6 desc
            ;


select * from rcb_invoicesheader where clid=@clientid1 and cid=2108963; 