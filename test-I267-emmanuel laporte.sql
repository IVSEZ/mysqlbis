select * from rcb_casa where clid in (698454)
and hard is null;


select clid,cid, sum(money) 
from rcb_casa where CLID in (
698454
)	

group by clid,cid
;


select clid, cid, sum(money) 
from rcb_casa where CLID in (
698454
)	
and (hard not in (101) or hard is null)
group by clid, cid
;


select * from rcb_casa where clid in (700121) order by paydate;
select * from rcb_invoicesheader where clid in (723483) order by data;
select * from rcb_invoicescontents where clid in (700121) order by fromdate;

select clid, cid, sum(money) as TotalPaymentAmount 
from rcb_casa
where
(hard not in (101,102) or hard is null)
group by clid, cid
; 

select clid, cid, sum(total) as TotalInvoiceAmount 
from rcb_invoicesheader
where
(hard not in (101,102) or hard is null)
group by clid, cid
; 




select distinct(hard) as hard, count(*) as hardcount
from 
rcb_casa
group by hard
order by hardcount desc
;

select clid, cid, sum(money) from rcb_casa where hard in (99)
group by clid, cid

;


select distinct(hard) from rcb_casa where clid in (698454);


select * from clientcontracts where CL_CLIENTID in (698454) 
-- and  (((S_SERVICENAME like '%SUBSCRIPTION%') and (VPNR_SERVICETYPE not like '%ONLY%')) or S_SERVICENAME is null)
order by CL_CLIENTID, CL_CLIENTCODE, CONTRACTCURRENTSTATUS,CON_STARTDATE;


select a.cl_clientname,a.CL_CLIENTCODE, a.CL_CLIENTID, 
-- a.TotalServices,a.TotalContracts,a.ActiveContracts,
-- a.InActiveContracts,a.firstcontractdate, a.CombinedSubscriptionContractPeriod,
count(b.id) as TotalBills, sum(b.total) as TotalAmount
from
clientcontracthistory a
left join 
rcb_invoicesheader b
on
a.CL_CLIENTID=b.CLID

where
a.CL_CLIENTID in (698454)
and

(b.HARD not in (101) or b.HARD is null)

group by a.cl_clientname,a.CL_CLIENTCODE, a.CL_CLIENTID
-- , a.TotalServices,a.TotalContracts,a.ActiveContracts,
-- a.InActiveContracts,a.firstcontractdate, a.CombinedSubscriptionContractPeriod
order by 
a.firstcontractdate asc
;



select a.cl_clientname,a.CL_CLIENTCODE, a.CL_CLIENTID, 
-- a.TotalServices,a.TotalContracts,a.ActiveContracts,
-- a.InActiveContracts,a.firstcontractdate, a.CombinedSubscriptionContractPeriod,
count(b.id) as TotalBills, sum(b.total) as TotalAmount
from
clientcontracthistory a
left join 
rcb_invoicesheader b
on
a.CL_CLIENTID=b.CLID

where
a.CL_CLIENTID in (698454)
-- and

-- b.HARD not in (101)

group by a.cl_clientname,a.CL_CLIENTCODE, a.CL_CLIENTID
-- , a.TotalServices,a.TotalContracts,a.ActiveContracts,
-- a.InActiveContracts,a.firstcontractdate, a.CombinedSubscriptionContractPeriod
order by 
a.firstcontractdate asc
;