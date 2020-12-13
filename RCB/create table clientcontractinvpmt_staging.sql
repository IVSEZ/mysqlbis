-- select * from rcbill.rcb_contracts where id=1214510;

set @clientid1=667979;


		drop table if exists rcbill.clientcontractinvpmt_stg;
        
        create table rcbill.clientcontractinvpmt_stg
        (


            select
            rcbill.GetClientCode(b.clid) as CLIENTCODE,
            rcbill.GetContractCode(b.cid) as CONTRACTCODE,
            b.clid as CLIENT_ID,
            b.cid as CONTRACT_ID,
            b.TotalInvoiceAmount,
            b.LastInvoiceAmount,
            b.TotalInvoices,
            b.FirstInvoiceDate,
            b.LastInvoiceDate,
            c.TotalPaymentAmount, 
            c.TotalPayments, 
            c.FirstPaymentDate, 
            c.LastPaymentDate, 
            c.LastPaidAmount
            from 
            (

				select clid, cid, COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
						from rcb_invoicesheader
						where
						-- (hard not in (100, 101, 102) or hard is null)
						(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
						-- and clid=@clientid1
						group by clid, cid
			) b 
            
            left join 
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
					(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)

					-- and clid=@clientid1
					group by clid, cid
				) a
            
            

			) c
            on b.clid=c.clid and b.cid=c.cid
		)
		;
        
		CREATE INDEX IDXccipstg2
		ON rcbill.clientcontractinvpmt_stg (CLIENTCODE);
		CREATE INDEX IDXccipstg3
		ON rcbill.clientcontractinvpmt_stg (CLIENT_ID);
		CREATE INDEX IDXccipstg4
		ON rcbill.clientcontractinvpmt_stg (CONTRACTCODE);
		CREATE INDEX IDXccipstg5
		ON rcbill.clientcontractinvpmt_stg (CONTRACT_ID);