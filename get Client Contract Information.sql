select * from clientcontracts;
select * from clientcontracts where S_SERVICENAME like '%SUBSCRIPTION%' or S_SERVICENAME is null;



drop table if exists clientcontracthistory;


CREATE TABLE IF NOT EXISTS clientcontracthistory AS (
select distinct(a.cl_clientname) as cl_clientname, 
a.CL_CLIENTCODE,
a.CL_CLIENTID, count(*) as TotalServices, 
count(distinct(a.con_contractid)) as TotalContracts
-- , CONTRACTCURRENTSTATUS
, (select count(distinct(b.CON_CONTRACTID)) from clientcontracts b where b.CONTRACTCURRENTSTATUS not in ('INACTIVE') and b.CL_CLIENTID in (a.CL_CLIENTID)) as ActiveContracts
, (select count(distinct(b.CON_CONTRACTID)) from clientcontracts b where b.CONTRACTCURRENTSTATUS in ('INACTIVE') and b.CL_CLIENTID in (a.CL_CLIENTID)) as InActiveContracts 
,min(a.CON_STARTDATE) as firstcontractdate
-- ,(sum(CONPERIOD)/count(distinct(con_contractid))) as ContractPeriod
,sum(a.CONPERIOD) as CombinedSubscriptionContractPeriod
-- ,(select sum(c.CONPERIOD) from clientcontracts c where c.CL_CLIENTID in (a.CL_CLIENTID) and c.CON_CONTRACTID in (a.CON_CONTRACTID) and (c.S_SERVICENAME like '%SUBSCRIPTION%' or c.S_SERVICENAME is null)) as ContractPeriod2

-- ,(select count(c.ID) from rcb_invoicesheader c where c.CLID in (a.CL_CLIENTID) and c.HARD not in (101)) as TotalBills
-- ,(select sum(c.TOTAL) from rcb_invoicesheader c where c.CLID in (a.CL_CLIENTID) and c.HARD not in (101)) as TotalAmount
-- ,sum(c.TOTAL) as TotalAmount


from 
clientcontracts a
-- left join
-- rcb_invoicesheader c
-- on
-- a.CL_CLIENTID=c.CLID

-- -- where 
-- (((a.S_SERVICENAME like '%SUBSCRIPTION%') and (a.VPNR_SERVICETYPE not like '%ONLY%')) or a.S_SERVICENAME is null)

-- and 
-- -- (a.CL_CLCLASSNAME ='RESIDENTIAL')
-- and 
-- c.HARD not in (101)

group by a.CL_CLIENTNAME, a.CL_CLIENTCODE
-- , CONTRACTCURRENTSTATUS
order by 9 desc , 1 asc
-- limit 100
)
;
CREATE INDEX IDXcch1
ON clientcontracthistory (cl_clientname);

CREATE INDEX IDXcch2
ON clientcontracthistory (CL_CLIENTCODE);

CREATE INDEX IDXcch3
ON clientcontracthistory (CL_CLIENTID);


drop table clientcontractinvpmt;
#QUERY Takes 53 minutes
#now it takes 139 seconds
 SET global innodb_buffer_pool_size=12582912;

CREATE TABLE IF NOT EXISTS clientcontractinvpmt AS (

/*
select 
distinct(a.cl_clientname) as cl_clientname, 
a.CL_CLIENTCODE,
a.CL_CLIENTID, 
a.CON_CONTRACTCODE,
a.CON_CONTRACTID,
(select sum(b.total) from rcb_invoicesheader b where b.CID in (a.con_contractid) and (b.HARD not in (101,102) or b.HARD is null)) as TotalInvoiceAmount,
(select sum(c.money) from rcb_casa c where c.CID in (a.con_contractid) and (c.hard not in (101,102) or c.HARD is null)) as TotalPaymentAmount

from 
clientcontracts a

group by a.CL_CLIENTNAME, 
a.CL_CLIENTCODE,
a.CL_CLIENTID, 
a.CON_CONTRACTCODE,
a.CON_CONTRACTID

order by a.cl_clientname, a.CL_CLIENTCODE, a.CON_CONTRACTCODE

)
*/


select 
distinct(a.cl_clientname) as cl_clientname, 
a.CL_CLIENTCODE,
a.CL_CLIENTID, 
a.CON_CONTRACTCODE,
a.CON_CONTRACTID,
b.TotalInvoiceAmount,
b.LastInvoiceAmount,
b.TotalInvoices,
b.FirstInvoiceDate,
b.LastInvoiceDate,
c.TotalPaymentAmount,
c.LastPaidAmount,
c.TotalPayments,
c.FirstPaymentDate,
c.LastPaymentDate

from 
clientcontracts a
left join
(select clid, cid, sum(total) as TotalInvoiceAmount , max(total) as LastInvoiceAmount, count(*) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
from rcb_invoicesheader
where
(hard not in (100, 101, 102) or hard is null)
group by clid, cid) as b

on a.CL_CLIENTID=b.clid
and a.CON_CONTRACTID=b.cid

left join
(
select clid, cid, sum(money) as TotalPaymentAmount , 
max(money) as LastPaidAmount, 
count(*) as TotalPayments, min(ENTERDATE) as FirstPaymentDate, max(ENTERDATE) as LastPaymentDate
from rcb_casa
where
(hard not in (100, 101, 102) or hard is null)
group by clid, cid) as c

on a.CL_CLIENTID=c.clid
and a.CON_CONTRACTID=c.cid

order by a.cl_clientname, a.CL_CLIENTCODE, a.CON_CONTRACTCODE
)
;

 SET global innodb_buffer_pool_size=8388608;

CREATE INDEX IDXccip1
ON clientcontractinvpmt (cl_clientname);
CREATE INDEX IDXccip2
ON clientcontractinvpmt (CL_CLIENTCODE);
CREATE INDEX IDXccip3
ON clientcontractinvpmt (CL_CLIENTID);
CREATE INDEX IDXccip4
ON clientcontractinvpmt (CON_CONTRACTCODE);
CREATE INDEX IDXccip5
ON clientcontractinvpmt (CON_CONTRACTID);




#for file clientreport-ddmmyyyy-n.csv
DROP TABLE IF EXISTS clientreport;
create table clientreport as (
select a.*, (select distinct(b.CL_CLCLASSNAME) from clientcontracts b where b.CL_CLIENTID=a.CL_CLIENTID and b.cl_clientname=a.cl_clientname ) as ClassName,
-- a.cl_clientname,a.CL_CLIENTCODE, a.CL_CLIENTID,
sum(b.TotalInvoices) as TotalInvoices, sum(b.TotalInvoiceAmount) as TotalInvoiceAmount, 
-- max(b.LastInvoiceAmount) as LastInvoiceAmount, 
min(b.FirstInvoiceDate) as FirstInvoiceDate, max(b.LastInvoiceDate) as LastInvoiceDate,
sum(b.TotalPayments) as TotalPayments, sum(b.TotalPaymentAmount) as TotalPaymentAmount, 
-- max(b.LastPaidAmount) as LastPaidAmount, 
min(b.FirstPaymentDate) as FirstPaymentDate, max(b.LastPaymentDate) as LastPaymentDate,
-- str_to_date('2017-01-19','%Y-%m-%d') as REPORTDATE,
@REPORTDATE as REPORTDATE,
(sum(b.TotalInvoiceAmount)-sum(b.TotalPaymentAmount)) as CLIENTDEBT_ASON_19JAN2017

from
clientcontracthistory a
left join 
clientcontractinvpmt b
on
a.CL_CLIENTID=b.CL_CLIENTID

group by a.cl_clientname,a.CL_CLIENTCODE, a.CL_CLIENTID
-- , c.CL_CLCLASSNAME

order by 
a.cl_clientname
)
;

#Final Report Table
select * from clientreport;

#Top 1000 paying residential customers still active
/*
select * from clientreport 
where 
ClassName in ('RESIDENTIAL')
and 
ActiveContracts > 0
order by 
TotalPaymentAmount desc
limit 1000;
*/
#Top 1000 paying residential customers not currently active 
/*
select a.* from 
(
select * from clientreport 
where 
ClassName in ('RESIDENTIAL')
and 
ActiveContracts = 0
order by 
TotalPaymentAmount desc
limit 1000
) a

order by a.lastpaymentdate desc
;
*/

#Temp table for top active clients 

DROP TABLE IF EXISTS temptopactiveclients;
create temporary table temptopactiveclients as
(
select * from clientreport 
where 
ClassName in ('RESIDENTIAL')
and 
ActiveContracts > 0
order by 
TotalPaymentAmount desc
limit 1000
)
;


select a.*,b.KOD,b.BULSTAT,b.DANNO,b.PASSNo,b.MPHONE,b.MEMAIL,b.MOLADDRESS,b.MOL 
,c.firm as Dup_ClientName,
c.kod as Dup_ClientCode,
c.danno as Dup_NIN,
c.PASSNo as Dup_PassNo,
c.MPHONE as Dup_MPhone,
c.MEMAIL as DUP_MEMAIL,
c.MOLADDRESS as DUP_MOLADDRESS
/*
,
c.KOD as ContractCode,
c.StartDate,
c.EndDate
*/
from 
temptopactiveclients a 
inner join
rcb_tclients b
on
a.cl_clientid=b.id

left join
rcb_tclients c
on
a.cl_clientname=c.firm
;

select cl_clientname, cl_clientcode from 
clientreport
where
cl_clientname in (select cl_clientname from temptopactiveclients)
;


#Temp table for top inactive clients 

DROP TABLE IF EXISTS temptopinactiveclients;
create temporary table temptopinactiveclients as
(
select a.* from 
(
select * from clientreport 
where 
ClassName in ('RESIDENTIAL')
and 
ActiveContracts = 0
order by 
TotalPaymentAmount desc
limit 1000
) a

order by a.lastpaymentdate desc
)
;


select a.*,b.KOD,b.BULSTAT,b.DANNO,b.PASSNo,b.MPHONE,b.MEMAIL,b.MOLADDRESS,b.MOL
,c.firm as Dup_ClientName,
c.kod as Dup_ClientCode,
c.danno as Dup_NIN,
c.PASSNo as Dup_PassNo,
c.MPHONE as Dup_MPhone,
c.MEMAIL as DUP_MEMAIL,
c.MOLADDRESS as DUP_MOLADDRESS


from 
temptopinactiveclients a 
inner join
rcb_tclients b
on
a.cl_clientid=b.id

left join
rcb_tclients c
on
a.cl_clientname=c.firm

order by
a.lastpaymentdate
;

select cl_clientname, cl_clientcode from 
clientreport
where
cl_clientname in (select cl_clientname from temptopinactiveclients)
;
#################################################################################################


select * from  clientcontractinvpmt
where CL_CLIENTID in (700121)
;

select * from  rcb_invoicesheader
where clid in (700121)
and
(hard not in (100, 101, 102) or hard is null)
order by clid, cid, data
;


select * from  rcb_casa
where clid in (700121)
and
(hard not in (100, 101, 102) or hard is null)
order by clid, cid, enterdate
;


#for file topallclients-contracts-bydate-ddmmyyyy-n.csv
select * from clientcontracthistory 
order by 
firstcontractdate asc;

#for file topallclients-contracts-byperiod-ddmmyyyy-n.csv
select * from clientcontracthistory 
order by 
CombinedSubscriptionContractPeriod desc;

















































#for file topallclients-casa-ddmmyyyy-n.csv
select a.cl_clientname,a.CL_CLIENTCODE, a.CL_CLIENTID, 
count(b.id) as TotalPayments, sum(b.money) as TotalPaidAmount
from
clientcontracthistory a
left join 
rcb_casa b
on
a.CL_CLIENTID=b.CLID

where
(b.HARD not in (101) or b.HARD is null) 

group by a.cl_clientname,a.CL_CLIENTCODE, a.CL_CLIENTID

order by 
5 desc
;







select 

IH.ID as IH_INVOICEID

-- ,CASA.invid as CASA_INVOICEID


,IH.TYPE as IH_TYPE
,IH.HARD as IH_HARD

-- ,CASA.hard as CASA_HARD

,IH.CLID as IH_CLIENTID

-- ,CASA.clid as CASA_CLIENTID 

,IH.CID as IH_CONTRACTID

-- ,CASA.cid as CASA_CONTRACTID

,IH.INVOICENO as IH_INVOICENO


,IH.PROFORMANO as IH_PROFORMANO
,IH.SRCNO as IH_SRCNO
,IH.DKINO as IH_DKINO
,IH.DATA as IH_INVOICEDATE
,IH.SUMA as IH_SUMA
,IH.DDS as IH_DDS
,IH.TOTAL as IH_TOTALAMOUNT
,IH.BEGDATE as IH_FROMDATE
,IH.ENDDATE as IH_TODATE
,IH.UPDDATE as IH_UPDDATE


/*
,CASA.paydate as CASA_PAYDATE
,CASA.enterdate as CASA_ENTRYDATE
,CASA.money as CASA_PAYAMOUNT

,CASA.begdate as CASA_STARTDATE
,CASA.enddate as CASA_ENDDATE
*/

/*
,IC.ID AS IC_ID
,IC.INVOICENO AS IC_INCOICENO
,IC.INVOICEID AS IC_INVOICEID
,IC.CLID AS IC_CLIENTID
,IC.CID AS IC_CONTRACTID
,IC.SCOST AS IC_SCOST
,IC.COST AS IC_COST
,IC.SUMCOST AS IC_SUMCOST
,IC.COSTVAT AS IC_VATCOST
,IC.COSTTOTAL AS IC_TOTALCOST
,IC.FROMDATE AS IC_FROMDATE
,IC.TODATE AS IC_TODATE
,IC.TEXT AS IC_SUBSCRIPTION
,IC.UPDDATE AS IC_UPDDATE
*/
from 

rcb_invoicesheader IH

-- left join

-- rcb_casa CASA
-- on 
-- IH.ID=CASA.INVID


/*
right join

rcb_invoicescontents IC

on
IH.ProformaNO=IC.INVOICENO
*/
where 
IH.CLID in (698454)
and
IH.HARD not in (101)
/*and  
(
 IH.HARD not in (101) 
 or 
 CASA.HARD not in (101)
)*/
order by
IH.CLID,
IH.CID,
IH.DATA
-- ,CASA.PAYDATE
;



select * from rcb_invoicesheader where id in (236654);
select * from rcb_casa where invid in (236654);



select a.cl_clientname, a.cl_clientcode, a.cl_contract_count,a.cl_distcontract_count, a.firstcontractdate, a.ContractPeriod, 
b.CL_CLCLASSNAME,
b.con_contractcode,b.contractcurrentstatus,b.CON_STARTDATE, b.CON_ENDDATE
,b.CONPERIOD
,b.S_SERVICENAME
,b.VPNR_SERVICETYPE
,b.VPNR_SERVICEPRICE
from 
clientcontracthistory a
left join
clientcontracts b
on 
a.cl_clientname=b.CL_CLIENTNAME
where 
b.S_SERVICENAME like '%SUBSCRIPTION%' or b.S_SERVICENAME is null
order by 
a.ContractPeriod desc, a.cl_clientname asc
;


select * from clientcontracts where cl_clientcode in (select CL_CLIENTCODE from clientcontracthistory);




/*
select distinct(cl_clientname) as cl_name, CL_CLIENTCODE, count(distinct(con_contractid)) as cl_contract_count, CONTRACTCURRENTSTATUS
from 
clientcontracts
group by CL_CLIENTNAME, CL_CLIENTCODE, CONTRACTCURRENTSTATUS
order by 1 asc;
*/

/*
select distinct(cl_clientname) as cl_name, count(distinct(con_contractid)) as cl_contract, CONTRACTCURRENTSTATUS
from 
clientcontracts
group by CL_CLIENTNAME, con_contractid, CONTRACTCURRENTSTATUS
order by 2 desc;


select CL_CLIENTNAME,CL_CLIENTCODE,CL_CLIENTID, CON_CONTRACTCODE
-- ,count(CON_CONTRACTCODE) as contractcount 
, CONTRACTCURRENTSTATUS
from 
clientcontracts where 
CL_CLIENTID in (668998,708220)
-- CL_CLIENTNAME like 'aaron z%'

group by CL_CLIENTNAME,CL_CLIENTCODE,CON_CONTRACTCODE, CONTRACTCURRENTSTATUS
order by CONTRACTCURRENTSTATUS, CL_CLIENTCODE
*/
