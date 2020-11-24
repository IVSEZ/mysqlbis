select CLIENTCODE, CLIENTNAME, CURRENTDEBT, IsAccountActive, activeservices, clientclass, clientaddress, clean_mxk_interface, clean_mxk_name 
from rcbill_my.rep_custconsolidated 
where 0=0
and 
clean_mxk_name like '%BEAUVALLON%'
and 
IsAccountActive='Active'


(
activeservices in ('All')
or 
activeservices like '%Voice%'
)
;


select 
*
-- CLIENTCODE, CLIENTNAME, CURRENTDEBT, IsAccountActive, activeservices, clientclass, clientaddress
-- , clean_hfc_node, clean_hfc_nodename 
from rcbill_my.rep_custconsolidated 
where 0=0
-- and 
-- clean_hfc_nodename like '%BEAU-VALLON%' 
and 
IsAccountActive='Active'

;


select 
-- *
reportdate, clientcode, IsAccountActive, AccountActivityStage, clientname, clientclass, activenetwork, activeservices
, activecontracts, activesubscriptions, clientaddress, clientlocation, clean_connection_type
, clean_mxk_name, clean_mxk_interface, clean_hfc_node, clean_hfc_nodename, hfc_district, hfc_subdistrict
, firstactivedate, lastactivedate, dayssincelastactive
, clientarea, clientemail, clientnin, clientpassport, clientphone


 from rcbill_my.rep_custconsolidated where clean_hfc_nodename like '%BEAU%'
or (clientaddress like '%BEAU VAL%' ) -- and activenetwork like '%HFC%')
;


select HFC_NODE, NODENAME, CMTS_DATE, date(INSERTEDON) as INSERTED_ON
, count(distinct CLIENT_CODE) as UNIQUE_ACCOUNTS, count(distinct CONTRACT_CODE) as UNIQUE_CONTRACTS
, count(distinct MAC) as UNIQUE_MAC_INRCBOSS, count(distinct MAC_ADDRESS) as UNIQUE_MAC_INCMTS
from rcbill_my.customers_cmts
group by HFC_NODE, NODENAME, CMTS_DATE, date(INSERTEDON)
order by HFC_NODE
;

select MXK_NAME, MXK_DATE, date(INSERTEDON) as INSERTED_ON
, count(distinct CLIENT_CODE) as UNIQUE_ACCOUNTS, count(distinct CONTRACT_CODE) as UNIQUE_CONTRACTS
, count(distinct FSAN2) as UNIQUE_FSAN_INRCBOSS, count(distinct SERIAL_NUM2) as UNIQUE_FSAN_INMXK
from rcbill_my.customers_mxk
group by MXK_NAME, MXK_DATE, date(INSERTEDON)
order by MXK_NAME
;
