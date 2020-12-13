select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCENUMBER in ('SIN_2755629_94378');

select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCENUMBER in ('SIN_2865802_112440');


select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER = 'CA_I9695';

select * from rcbill.rcb_tclients where kod='I.000001217';

select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR';

select * from rcbill_my.rep_custconsolidated;


set @clientcode1='I13400';
set @clientcode1='I298';
set @clientcode1 = 'I15793';

set @clientid1=667979;
set @clientid1=698115;
set @clientid1=693674;

select * from rcbill.clientreport where CL_CLIENTCODE=@clientcode1;
select * from rcbill.clientextendedreport where CL_CLIENTCODE=@clientcode1;
select * from clientcontractinvpmt where cl_clientcode=@clientcode1;


select clid, COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
		from rcb_invoicesheader
		where
		(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
		-- and year(data)>=2012
        and clid in  (@clientid1)
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
			(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
			-- and year(ENTERDATE)>=2012
            and clid in  (@clientid1)
			group by clid -- , cid
			order by 5 desc
            ;




select clid, cid, COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
		from rcb_invoicesheader
		where
		(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
		and year(data)>=2016
        and clid in (@clientid1)
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
			(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
			and year(ENTERDATE)>=2016
			and clid in (@clientid1)
			group by clid, cid
            order by 6 desc
            ;


select id, type, hard, clid, cid, data, invoiceno, total from rcb_invoicesheader where clid=@clientid1
and hard=999

; -- and cid=2108963; 



select cl_clientid, CON_CONTRACTID from clientcontracts where CL_CLIENTID=@clientid1 group by CL_CLIENTID, CON_CONTRACTID;

select clid, cid, COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
		from rcb_invoicesheader
		where
		-- (hard not in (100, 101, 102) or hard is null)
        (hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
        and clid=@clientid1
		group by clid, cid
        ;


			select clid
			 , cid
			, COALESCE(sum(money),0) as TotalPaymentAmount  
			-- , sum(money) as LastPaidAmount
			-- , (select sum(ac.money) from rcbill.rcb_casa ac where ac.clid=clid and date(ac.enterdate)=date(max(EnterDate))) as LastPaidAmount  
			, COALESCE(count(*),0) as TotalPayments, date(min(ENTERDATE)) as FirstPaymentDate, date(max(ENTERDATE)) as LastPaymentDate
			from rcb_casa
			where
			-- (hard not in (100, 101, 102) or hard is null)
            (hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
             
			and clid=@clientid1
			group by clid, cid
            ;
            
            
            select b.*, c.*
            from 
            (

				select clid, cid, COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
						from rcb_invoicesheader
						where
						-- (hard not in (100, 101, 102) or hard is null)
						(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
						and clid=@clientid1
						group by clid, cid
			) b 
            
            left join 
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
					(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
					 
					and clid=@clientid1
					group by clid, cid
			) c
            on b.clid=c.clid and b.cid=c.cid
            ;
            
            
            

select hard, type, sum(total) from rcb_invoicesheader where clid=@clientid1 group by hard, type;


select * from rcb_casa where  clid=@clientid1;

select hard, sum(money) from rcb_casa where  clid=@clientid1 group by hard;


select hard, type, sum(total) from rcb_invoicesheader group by hard, type;

select hard, sum(money) from rcb_casa group by hard;