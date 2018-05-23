select * from rcbill.clientextendedreport 
where CL_MOLADDRESS like '%anse poule%'
and CL_CLIENTCODE in (select CL_CLIENTCODE from rcbill.clientcontracts where VPNR_SERVICETYPE='Crimson')

;

select CON_CONTRACTCODE from rcbill.clientcontracts where VPNR_SERVICETYPE='Crimson';

select * from rcbill.clientextendedreport 
where 
cl_clientname like '%ferrari%'

;

select * from rcbill.clientextendedreport 
where CL_MOLADDRESS like '%raghwani%'
-- and CL_CLIENTCODE in (select CL_CLIENTCODE from rcbill.clientcontracts where VPNR_SERVICETYPE='Crimson')

;