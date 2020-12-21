select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCENUMBER in ('SIN_2755629_94378');

select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCENUMBER in ('SIN_2865802_112440');


select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER = 'CA_I9695';

select * from rcbill.rcb_tclients where kod='I.000001217';

select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR';

select * from rcbill_my.rep_custconsolidated;


set @clientcode1='I13400';
set @clientcode1='I298';
set @clientcode1 = 'I15793';
set @clientcode1='I5742';
set @clientcode1='91';


set @clientid1=667979;
set @clientid1=698115;
set @clientid1=693674;
set @clientid1=702439;
set @clientid1=712211;

set @clientid1=721961;



select * from rcbill.clientreport where CL_CLIENTCODE=@clientcode1;
select * from rcbill.clientextendedreport where CL_CLIENTCODE=@clientcode1;
select * from rcbill.clientcontractinvpmt where cl_clientcode=@clientcode1;
select * from rcbill.clientcontractinvpmt_stg where CLIENT_ID=@clientid1;





set @clientcode1='I14976';
set @clientid1=668288;

select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and CurrentDebt<>0;-- and CLIENTID=@clientid1;
select * from rcbill.clientcontractinvpmt where cl_clientcode in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and CurrentDebt<>0);-- and clientid=@clientid1);

select * from rcbill_extract.IV_BILLINGACCOUNT;-- where client_id=@clientid1;
select * from rcbill_extract.BILLINGACCOUNT_KEY;-- where client_id=@clientid1;

select a.*, b.*
from
(
	select 
	reportdate, CLIENTCODE, CLIENTID, IsAccountActive, AccountActivityStage, CurrentDebt, CLIENTNAME
	-- , clientclass, clientaddress, clientlocation, clientarea, clientemail, activenetwork, clientnin, clientphone, address, moladdress, MOLRegistrationAddress, firstcontractdate, firstinvoicedate, firstpaymentdate, firstactivedate, dayssincelastactive, a1_parcel, a2_parcel, a3_parcel, PARCEL_PRESENT, EMAIL_PRESENT, NIN_PRESENT, ADDRESS_PRESENT
	, ONE_YEAR

	from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and CurrentDebt<>0 -- and clientid=@clientid1
) a 
left join 
rcbill_extract.IV_BILLINGACCOUNT b
on 
a.clientid=b.client_id

;

select a.*, b.*
from 
(
	select * from rcbill.clientcontractinvpmt where cl_clientcode in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and CurrentDebt<>0)-- and CLIENTID=@clientid1) 
) a 
left join 
-- rcbill_extract.IV_BILLINGACCOUNT b
rcbill_extract.BILLINGACCOUNT_KEY b
on 
a.CL_CLIENTID=b.client_id
and
a.CON_CONTRACTID=b.contract_id
;


select b.clientcode, b.client_id
, b.BILLINGACCOUNTNUMBER
, b.CUSTOMERACCOUNTNUMBER
, b.BILLCYCLE
, a.CL_CLIENTCODE
, a.cl_clientid
, ifnull(sum(a.TotalInvoiceAmount),0) as sum_totalinvoiceamount
, ifnull(sum(a.TotalPaymentAmount),0) as sum_TotalPaymentAmount
, (ifnull(sum(a.TotalInvoiceAmount),0) - ifnull(sum(a.TotalPaymentAmount),0)) as sum_CurrentDebt
from 
(
	select * from rcbill.clientcontractinvpmt where cl_clientcode in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and CurrentDebt<>0) -- and CLIENTID=@clientid1) 
) a 
left join 
-- rcbill_extract.IV_BILLINGACCOUNT b
rcbill_extract.BILLINGACCOUNT_KEY b
on 
a.CL_CLIENTID=b.client_id
and
a.CON_CONTRACTID=b.contract_id

group by 1,2,3,4,5,6,7
;


select a.*
, ifnull(a.BILLINGACCOUNTNUMBER,
-- (select ab.BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT ab where ab.client_id=a.cl_clientid and ab.accountstatus=1 order by ab.accountstatus desc, ab.billingaccountnumber desc limit 1)) as REV_BILLINGACCOUNTNUMBER
(select max(ab.BILLINGACCOUNTNUMBER) from rcbill_extract.IV_BILLINGACCOUNT ab where ab.client_id=a.cl_clientid 
-- and ab.accountstatus=1 
limit 1)) as REV_BILLINGACCOUNTNUMBER

, ifnull(a.CUSTOMERACCOUNTNUMBER,
-- (select ab.BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT ab where ab.client_id=a.cl_clientid and ab.accountstatus=1 order by ab.accountstatus desc, ab.billingaccountnumber desc limit 1)) as REV_BILLINGACCOUNTNUMBER
(select max(ab.CUSTOMERACCOUNTNUMBER) from rcbill_extract.IV_BILLINGACCOUNT ab where ab.client_id=a.cl_clientid 
-- and ab.accountstatus=1 
limit 1)) as REV_CUSTOMERACCOUNTNUMBER

from 
(
	select b.clientcode, b.client_id
	, b.BILLINGACCOUNTNUMBER
	, b.CUSTOMERACCOUNTNUMBER
	, b.BILLCYCLE
	, a.CL_CLIENTCODE
    , a.CL_CLIENTID
	, ifnull(sum(a.TotalInvoiceAmount),0) as sum_totalinvoiceamount
	, ifnull(sum(a.TotalPaymentAmount),0) as sum_TotalPaymentAmount
	, (ifnull(sum(a.TotalInvoiceAmount),0) - ifnull(sum(a.TotalPaymentAmount),0)) as sum_CurrentDebt

	from 
	(
		select * from rcbill.clientcontractinvpmt where cl_clientcode in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and CurrentDebt<>0) -- and CLIENTID=@clientid1) 
	) a 
	left join 
	-- rcbill_extract.IV_BILLINGACCOUNT b
	rcbill_extract.BILLINGACCOUNT_KEY b
	on 
	a.CL_CLIENTID=b.client_id
	and
	a.CON_CONTRACTID=b.contract_id

	 group by 1,2,3,4,5,6,7
) a 
;


select REV_BILLINGACCOUNTNUMBER, REV_CUSTOMERACCOUNTNUMBER, sum(sum_CurrentDebt) as CurrentDebt
from 
(

	select a.*
	, ifnull(a.BILLINGACCOUNTNUMBER,
	-- (select ab.BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT ab where ab.client_id=a.cl_clientid and ab.accountstatus=1 order by ab.accountstatus desc, ab.billingaccountnumber desc limit 1)) as REV_BILLINGACCOUNTNUMBER
	(select max(ab.BILLINGACCOUNTNUMBER) from rcbill_extract.IV_BILLINGACCOUNT ab where ab.client_id=a.cl_clientid 
	-- and ab.accountstatus=1 
	limit 1)) as REV_BILLINGACCOUNTNUMBER

	, ifnull(a.CUSTOMERACCOUNTNUMBER,
	-- (select ab.BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT ab where ab.client_id=a.cl_clientid and ab.accountstatus=1 order by ab.accountstatus desc, ab.billingaccountnumber desc limit 1)) as REV_BILLINGACCOUNTNUMBER
	(select max(ab.CUSTOMERACCOUNTNUMBER) from rcbill_extract.IV_BILLINGACCOUNT ab where ab.client_id=a.cl_clientid 
	-- and ab.accountstatus=1 
	limit 1)) as REV_CUSTOMERACCOUNTNUMBER

	from 
	(
		select b.clientcode, b.client_id
		, b.BILLINGACCOUNTNUMBER
		, b.CUSTOMERACCOUNTNUMBER
		, b.BILLCYCLE
		, a.CL_CLIENTCODE
		, a.CL_CLIENTID
		, ifnull(sum(a.TotalInvoiceAmount),0) as sum_totalinvoiceamount
		, ifnull(sum(a.TotalPaymentAmount),0) as sum_TotalPaymentAmount
		, (ifnull(sum(a.TotalInvoiceAmount),0) - ifnull(sum(a.TotalPaymentAmount),0)) as sum_CurrentDebt

		from 
		(
			select * from rcbill.clientcontractinvpmt where cl_clientcode in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and CurrentDebt<>0) -- and CLIENTID=@clientid1) 
		) a 
		left join 
		-- rcbill_extract.IV_BILLINGACCOUNT b
		rcbill_extract.BILLINGACCOUNT_KEY b
		on 
		a.CL_CLIENTID=b.client_id
		and
		a.CON_CONTRACTID=b.contract_id

		 group by 1,2,3,4,5,6,7
	) a 


) a 
group by REV_BILLINGACCOUNTNUMBER, REV_CUSTOMERACCOUNTNUMBER
;



select REV_BILLINGACCOUNTNUMBER,REV_CUSTOMERACCOUNTNUMBER, sum(sum_CurrentDebt) as CurrentDebt
from 
(

	select a.*
	, ifnull(a.BILLINGACCOUNTNUMBER,
	-- (select ab.BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT ab where ab.client_id=a.cl_clientid and ab.accountstatus=1 order by ab.accountstatus desc, ab.billingaccountnumber desc limit 1)) as REV_BILLINGACCOUNTNUMBER
	(select max(ab.BILLINGACCOUNTNUMBER) from rcbill_extract.IV_BILLINGACCOUNT ab where ab.client_id=a.cl_clientid 
	-- and ab.accountstatus=1 
	limit 1)) as REV_BILLINGACCOUNTNUMBER
	from 
	(
		select b.clientcode, b.client_id
		, b.BILLINGACCOUNTNUMBER
		, b.CUSTOMERACCOUNTNUMBER
		, b.BILLCYCLE
		, a.CL_CLIENTCODE
		, a.CL_CLIENTID
		, ifnull(sum(a.TotalInvoiceAmount),0) as sum_totalinvoiceamount
		, ifnull(sum(a.TotalPaymentAmount),0) as sum_TotalPaymentAmount
		, (ifnull(sum(a.TotalInvoiceAmount),0) - ifnull(sum(a.TotalPaymentAmount),0)) as sum_CurrentDebt

		from 
		(
			select * from rcbill.clientcontractinvpmt where cl_clientcode in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and CurrentDebt<>0) -- and CLIENTID=@clientid1) 
		) a 
		left join 
		-- rcbill_extract.IV_BILLINGACCOUNT b
		rcbill_extract.BILLINGACCOUNT_KEY b
		on 
		a.CL_CLIENTID=b.client_id
		and
		a.CON_CONTRACTID=b.contract_id

		 group by 1,2,3,4,5,6,7
	) a 


) a 
group by REV_BILLINGACCOUNTNUMBER, REV_CUSTOMERACCOUNTNUMBER
;




###############################################################################




select clid, COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
		from rcbill.rcb_invoicesheader
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
			from rcbill.rcb_casa
			where
			(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
			-- and year(ENTERDATE)>=2012
            and clid in  (@clientid1)
			group by clid -- , cid
			order by 5 desc
            ;




select clid, cid, COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
		from rcbill.rcb_invoicesheader
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
			from rcbill.rcb_casa
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
            
            
            
            select  COALESCE(clid, c_clid) AS clid
            , COALESCE(cid, c_cid) AS cid
            , TotalInvoiceAmount, LastInvoiceAmount, TotalInvoices, FirstInvoiceDate, LastInvoiceDate, c_clid, c_cid, TotalPaymentAmount, TotalPayments, FirstPaymentDate, LastPaymentDate
            from 
            (
				(
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
							select clid as c_clid
							 , cid as c_cid
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
					on b.clid=c.c_clid and b.cid=c.c_cid
				)
				union 
				(
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
					
					right join 
					(
							select clid as c_clid
							 , cid as c_cid
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
					on b.clid=c.c_clid and b.cid=c.c_cid
				
				
				) 
            ) a
            ;
            
            
            

select hard, type, sum(total) from rcb_invoicesheader where clid=@clientid1 group by hard, type;


select * from rcbill.rcb_invoicesheader where CLID=@clientid1;
select * from rcbill.rcb_casa where  clid=@clientid1;
select * from rcbill.rcb_invoicescontents where CLID=@clientid1;

select * from  rcbill_extract.CLIENTCONTRACTLASTINVDATE where CLID=@clientid1;

select hard, sum(money) from rcb_casa where  clid=@clientid1 group by hard;


select hard, type, sum(total) from rcb_invoicesheader group by hard, type;

select hard, sum(money) from rcb_casa group by hard;