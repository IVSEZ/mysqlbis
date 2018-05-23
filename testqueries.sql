-- select * from clientcontracts limit 1000;

			select distinct cl_clientid, cl_clientname, cl_clientcode, cl_clclassname, CON_CONTRACTCODE, S_SERVICENAME, VPNR_SERVICETYPE, CS_SUBSCRIPTIONCOUNT
			from clientcontracts 
			where 
            -- CL_CLCLASSNAME='CORPORATE LARGE'
			-- and 
            CONTRACTCURRENTSTATUS not in ('INACTIVE')
			-- and S_SERVICENAME like '%subscription%'
			group by cl_clientid, cl_clientname, cl_clientcode, cl_clclassname, CON_CONTRACTCODE ,S_SERVICENAME, VPNR_SERVICETYPE
			order by cl_clientname, CON_CONTRACTCODE;
            
            select * from rcb_services;
            select * from rcb_payobjects;
            select * from rcb_ratingplans;
            select * from rcb_vpnrates;
            select * from rcb_devicetypes;
            select * from rcb_contractslastaction;
            select * from rcb_cashpoints;
            
            
            
            select * from rcb_contracts where clid in (726362)
            order by contracttype, startdate
            ; 
            
            select * from clientcontracts where CL_CLIENTID in (726362) 
            -- and conperiod>0 
            -- and s_servicename like '%subscription%'
            order by con_contracttype, con_startdate; 
            
            
            select * from rcb_contracts where clid in (725060)
            order by contracttype, startdate
            ; 
            select * from clientcontracts where CL_CLIENTID in (725060) 
            -- and conperiod>0 
			-- and s_servicename like '%subscription%'
            order by con_contracttype, con_startdate; 
            
            
            select * from rcb_contracts where clid in (723711) 
            order by contracttype, startdate
            ;
            select * from clientcontracts where CL_CLIENTID in (723711) 
            -- and conperiod>0 
            -- and s_servicename like '%subscription%'
            order by con_contracttype, con_startdate;          

#TICKETS FROM RCBillFaults 
select a.*, b.*
from 
[RCBillFaults].[dbo].[Tickets] a
inner join
[RCBillFaults].[dbo].[TicketComments] b
on a.id=b.ticketid
where
a.id in (837779)