-- CUSTOMERS WHO HAVE EXTRAVAGANCE AND CRIMSON OR AMBER FOR MULTIVIEW PROMOTION
-- CUSTOMERS WHO ARE NOT EMPLOYEES, INTELVISION OFFICE, VIP


select a.clientcode, a.clientname, a.activecount, a.contractcount, a.network, a.Amber, a.Crimson, a.Extravagance,a.`DualView`,a.`MultiView`
, b.CL_MEMAIL, b.CL_MPhone, b.ActiveContracts, b.activesubscriptions, b.firstcontractdate, b.totalpaymentamount, b.classname

from 
(
  select * from rcbill_my.clientstats where `Extravagance`=1 and (`Crimson`=1 or `Amber`=1) and trim(upper(clientclass)) not in ('INTELVISION OFFICE','EMPLOYEE','VIP')
) a 
inner join
rcbill.clientextendedreport b 
on
a.clientcode=b.cl_clientcode
order by totalpaymentamount desc
;

select clientcode as accountnumber, clientname as name, network, TotalPaymentAmount as value, ClassName as customertype, cl_memail as email, cl_mphone as phone from 
(

	select a.clientcode, a.clientname, a.activecount, a.contractcount, a.network, a.Amber, a.Crimson, a.Extravagance,a.`DualView`,a.`MultiView`
	, b.CL_MEMAIL, b.CL_MPhone, b.ActiveContracts, b.activesubscriptions, b.firstcontractdate, b.totalpaymentamount, b.classname

	from 
	(
	  select * from rcbill_my.clientstats where `Extravagance`=1 and (`Crimson`=1 or `Amber`=1) and trim(upper(clientclass)) not in ('INTELVISION OFFICE','EMPLOYEE','VIP')
	) a 
	inner join
	rcbill.clientextendedreport b 
	on
	a.clientcode=b.cl_clientcode
	order by totalpaymentamount desc
) a 
where clientcode in 
(
'I8782',
'I.000001884',
'I22396',
'I5274',
'I10733',
'I13460',
'I.000001210',
'I.000006115',
'I15443',
'I16771'

)