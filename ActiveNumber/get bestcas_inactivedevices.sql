select * from rcbill.clientcontracts;

select * from rcbill.rcb_devices;

select * from rcbill_my.bc_inactdevices;


select phoneno, contractid, serviceid, csid from rcbill.rcb_devices where 
upper(trim(phoneno)) in 
(select upper(trim(bestcasid)) from rcbill_my.bc_inactdevices);


-- Get all client contracts which feature in the BestCAS inactive devices
drop table if exists rcbill.bc_contracts;
create table rcbill.bc_contracts as 
(
	select * from rcbill.clientcontracts
	where CON_CONTRACTID in 
	(
	select contractid from rcbill.rcb_devices where 
	upper(trim(phoneno)) in 
	(select upper(trim(bestcasid)) from rcbill_my.bc_inactdevices)
	)
	and S_SERVICENAME like '%SUBSCRIPTION%'
)
;

select * from rcbill.bc_contracts;

#GET client contracts and client details
select 
a.CL_CLIENTID, a.CL_CLIENTNAME, a.CL_CLIENTCODE, a.CL_CLCLASSNAME, a.CON_CONTRACTCODE, a.CON_ACTIVE
, a.CON_CONTRACTTYPE, a.RDT_DEVICENAME, a.S_SERVICENAME, a.VPNR_SERVICETYPE, a.VPNR_SERVICEPRICE 
, a.CONTRACTCURRENTSTATUS, a.CONPERIOD2, a.CONPERIOD
, b.TotalContracts, b.InActiveContracts, b.ActiveContracts, b.ActiveSubscriptions, b.DevicesCount, b.TotalContractsWithDevices, b.firstcontractdate, b.ClassName, b.TotalInvoices
, b.TotalInvoiceAmount, b.FirstInvoiceDate, b.LastInvoiceDate, b.TotalPayments, b.TotalPaymentAmount, b.FirstPaymentDate, b.LastPaymentDate, b.REPORTDATE, b.CLIENTDEBT_REPORTDATE
, b.CL_NIN, b.CL_PassNo, b.CL_MPhone, b.CL_MEMAIL, b.CL_MOLADDRESS
from
rcbill.bc_contracts a 
 left join
rcbill.clientextendedreport b
 on a.cl_clientcode = b.cl_clientcode
;




/*
GET INACTIVE DEVICES AND THEIR CONTRACTS
*/
select a.phoneno, a.contractid, a.serviceid, a.csid, b.bestcasid, b.lastactivedate
from 
rcbill.rcb_devices a 
inner join
rcbill_my.bc_inactdevices b
on
upper(trim(a.phoneno))=upper(trim(b.bestcasid))
;


select * from rcbill.clientcontracts where
con_contractid in 
(
select a.contractid
from 
rcbill.rcb_devices a 
inner join
rcbill_my.bc_inactdevices b
on
upper(trim(a.phoneno))=upper(trim(b.bestcasid))


)
;


select a.cl_clientname,a.cl_clientcode,a.cl_clclassname,a.con_contractcode,a.con_contractdate, a.con_startdate, a.con_enddate, a.s_servicename, a.cs_serviceid, a.vpnr_servicetype
, b.phoneno, b.contractid, b.serviceid, b.csid
, c.bestcasid, c.lastactivedate
from 
rcbill.clientcontracts a
inner join
rcbill.rcb_devices b 
on 
a.con_contractid=b.contractid

inner join
rcbill_my.bc_inactdevices c 
on
upper(trim(b.phoneno))=upper(trim(c.bestcasid))
;


select a.* , b.*
from 
rcbill.clientcontracts a
inner join
(
select c.phoneno, c.contractid, c.serviceid, c.csid, d.bestcasid, d.lastactivedate
from 
rcbill.rcb_devices c 
inner join
rcbill_my.bc_inactdevices d
on
upper(trim(c.phoneno))=upper(trim(d.bestcasid))
) b
on
a.con_contractid=b.contractid
;

