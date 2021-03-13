select 
clean_connection_type
, isaccountactive , accountactivitystage
, clean_mxk_name , clean_hfc_nodename 
, count(clientcode) as clients
from rcbill_my.rep_custconsolidated
-- where clean_mxk_name like '%BEAU%' or clean_hfc_nodename like '%OMBRE%' or clean_hfc_nodename like '%BEAU%'

group by 1, 2, 3 , 4, 5

;

select * from rcbill.rcb_tclients order by firm;



select * from rcbill_my.rep_custextract;
select * from rcbill_my.rep_custconsolidated;



select * from rcbill_my.rep_custconsolidated where clean_hfc_nodename like '%PASCAL%' or clean_hfc_nodename like '%GLACIS%' or clean_hfc_nodename like '%SERRET-ROAD-LEFT/ST.LOUIS/TOWN%';


select * from rcbill_my.rep_custconsolidated where clientaddress like '%PASCAL%';

### HFC CUSTOMERS IN PASCAL VILLAGE AND GLACIS
select * from rcbill_my.rep_custconsolidated where clean_connection_type='HFC' and ((clientaddress like '%PASCAL%' and clean_hfc_nodename is not null) or clean_hfc_nodename like '%GLACIS%');

select 
-- * 
reportdate, clientcode, currentdebt, IsAccountActive, AccountActivityStage, clientname, clientclass
, activenetwork, activeservices, activecontracts, activesubscriptions, clientaddress, clientlocation
, clean_connection_type, clean_hfc_node, clean_hfc_nodename, hfc_district, hfc_subdistrict
, clientarea, clientemail, clientnin, clientpassport, clientphone


from rcbill_my.rep_custconsolidated where (clientaddress like '%PASCAL%' and clean_hfc_nodename like '%SERRET-ROAD-LEFT/ST.LOUIS/TOWN%') or clean_hfc_nodename like '%GLACIS%';


