## LOOK FOR TICKETS WHERE COMMENT IS ABOUT VOD
Select * from rcbill_my.clientticket_cmmtjourney 
where 
(comment like '%VOD%')
-- and 
-- (comment not like '%install%')
and 
(comment like '%not work%')
;

## LOOK FOR TICKETS WHERE COMMENT IS ABOUT DUALVIEW
select * from rcbill_my.clientticket_cmmtjourney 
where 
(comment like '%dual%')
-- and 
-- (comment not like '%install%')
and 
(comment like '%not work%')

;


## GPON CONVERSION APPROVAL TICKETS
select 
*
-- distinct clientcode, month(opendate) as TKT_MONTH, year(OPENDATE) as TKT_YEAR -- , comment
from rcbill_my.clientticket_cmmtjourney 
where 
(comment like '%GPON conversion%')
-- and 
-- (comment like '%Approved as per%')
-- and year(OPENDATE)=2019
;

/*
## GPON CONVERSION APPROVAL TICKETS
select * from rcbill_my.clientticket_cmmtjourney 
where 
(comment like '%GPON%')
-- and 
-- (comment like '%Approved as per%')
and year(OPENDATE)=2019
;
*/


### GPON CONVERSION CUSTOMERS
select a.clientcode, a.currentdebt, a.IsAccountActive, a.AccountActivityStage, c.TKT_MONTH as GPONMonth, c.TKT_YEAR as GPONYear
, a.clientname, a.clientemail, a.clientnin, a.clientpassport, a.clientphone
, a.clientclass, a.activenetwork, a.activeservices, a.clientaddress
, b.a1_parcel, b.a2_parcel, b.a3_parcel
, a.clientlocation
, a.clean_mxk_name, a.clean_mxk_interface, a.clean_hfc_nodename, a.clean_hfc_node
, a.firstactivedate, a.lastactivedate, a.TotalPaymentAmount2019, a.AvgMonthlyPayment2019 


from rcbill_my.rep_custconsolidated a 
inner join 
(
	select distinct clientcode, month(opendate) as TKT_MONTH, year(OPENDATE) as TKT_YEAR 
    from rcbill_my.clientticket_cmmtjourney 
	where 
	(comment like '%GPON conversion%')

) c 
on a.clientcode=c.clientcode
left join
rcbill.rcb_clientparcels b
on 
a.CLIENTCODE=b.clientcode

/*
where a.clientcode 
in 
(
select clientcode from rcbill_my.clientticket_cmmtjourney 
where 
(comment like '%GPON conversion%')
-- and year(OPENDATE)=2019
)
*/


;

select * from rcbill_my.rep_custconsolidated 
where
connection_type like '%HFC|GPON%'
;