drop table tempinvoicescontents201610;
drop table tempinvoicesheader201610;

SET GLOBAL innodb_buffer_pool_size=12582912;

CREATE TEMPORARY TABLE IF NOT EXISTS tempinvoicescontents201610 AS (

select 

IC.ID AS IC_ID
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


from rcb_invoicescontents IC 

where 
(IC.FROMDATE between '2016-10-01 00:00:00' AND '2016-10-31 00:00:00')
OR
(IC.TODATE between '2016-10-01 00:00:00' AND '2016-10-31 00:00:00')

order by 
-- upddate
IC.CLID,
IC.CID,
IC.INVOICENO,
IC.FROMDATE
)


;

CREATE TEMPORARY TABLE IF NOT EXISTS tempinvoicesheader201610 AS (

select 

IH.ID as IH_INVOICEID
,IH.TYPE as IH_TYPE
,IH.HARD as IH_HARD
,IH.CLID as IH_CLIENTID
,IH.CID as IH_CONTRACTID
,IH.INVOICENO as IH_INVOICENO
,IH.PROFORMANO as IH_PROFORMANO
,IH.SRCNO as IH_SRCNO
,IH.DKINO as IH_DKINO
,IH.DATA as IH_INVOICEDATE
,IH.SUMA as IH_SUMA
,IH.DDS as IH_DDS
,IH.TOTAL as IH_TOTAL
,IH.BEGDATE as IH_FROMDATE
,IH.ENDDATE as IH_TODATE
,IH.UPDDATE as IH_UPDDATE

from rcb_invoicesheader IH


where 
(IH.BEGDATE between '2016-10-01 00:00:00' AND '2016-10-31 00:00:00')
OR
(IH.BEGDATE between '2016-10-01 00:00:00' AND '2016-10-31 00:00:00')

order by 

IH.CLID,
IH.CID,
IH.INVOICENO,
IH.BEGDATE
)

;


select * from tempinvoicescontents201610;
select * from tempinvoicesheader201610;

select a.*, b.* from 
tempinvoicescontents201610 a
left join 
tempinvoicesheader201610 b
on
a.ic_invoiceid=b.ih_invoiceid
order by IH_FROMDATE;


-- NOV


drop table tempinvoicescontents201611;
drop table tempinvoicesheader201611;

-- SET GLOBAL innodb_buffer_pool_size=12582912;

CREATE TEMPORARY TABLE IF NOT EXISTS tempinvoicescontents201611 AS (

select 

IC.ID AS IC_ID
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


from rcb_invoicescontents IC 

where 
(IC.FROMDATE between '2016-11-01 00:00:00' AND '2016-11-30 00:00:00')
OR
(IC.TODATE between '2016-11-01 00:00:00' AND '2016-11-30 00:00:00')

order by 
-- upddate
IC.CLID,
IC.CID,
IC.INVOICENO,
IC.FROMDATE
)


;

CREATE TEMPORARY TABLE IF NOT EXISTS tempinvoicesheader201611 AS (

select 

IH.ID as IH_INVOICEID
,IH.TYPE as IH_TYPE
,IH.HARD as IH_HARD
,IH.CLID as IH_CLIENTID
,IH.CID as IH_CONTRACTID
,IH.INVOICENO as IH_INVOICENO
,IH.PROFORMANO as IH_PROFORMANO
,IH.SRCNO as IH_SRCNO
,IH.DKINO as IH_DKINO
,IH.DATA as IH_INVOICEDATE
,IH.SUMA as IH_SUMA
,IH.DDS as IH_DDS
,IH.TOTAL as IH_TOTAL
,IH.BEGDATE as IH_FROMDATE
,IH.ENDDATE as IH_TODATE
,IH.UPDDATE as IH_UPDDATE

from rcb_invoicesheader IH


where 
(IH.BEGDATE between '2016-11-01 00:00:00' AND '2016-11-30 00:00:00')
OR
(IH.BEGDATE between '2016-11-01 00:00:00' AND '2016-11-31 00:00:00')

order by 

IH.CLID,
IH.CID,
IH.INVOICENO,
IH.BEGDATE
)

;


select * from tempinvoicescontents201611;
select * from tempinvoicesheader201611;

select a.*, b.* from 
tempinvoicescontents201611 a
left join 
tempinvoicesheader201611 b
on
a.ic_invoiceid=b.ih_invoiceid
order by IH_FROMDATE;


SELECT @@innodb_buffer_pool_size/1024/1024/1024;

