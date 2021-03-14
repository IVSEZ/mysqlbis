/*
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname like 'PARENT%';

select * from rcbill_my.rep_custextract where clientname like 'PARENT%';

select * from rcbill_extract.IV_CUSTOMERACCOUNT where CLIENT_ID in (select clientid from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname like 'PARENT%');


select * from rcbill_extract.IV_CUSTOMERACCOUNT where PARENTACCOUNTNUMBER is not null;


select *, length(CUSTOMERACCOUNTNUMBER) as C_L, length(BILLINGACCOUNTNUMBER) as B_L, length(SERVICEACCOUNTNUMBER) as S_L, length(SERVICEINSTANCEIDENTIFIER) as SI_L, length(SERVICEINSTANCENUMBER) as SIN_L  
from rcbill_extract.IV_SERVICEINSTANCE
-- where CLIENT_ID='723711'
;


*/

select * from rcbill_extract.parentaccount;

select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%AIR SEY%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%AVANI%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%ABSA%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%AIRTEL%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% CARANA %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%MASON%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%CBS %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% CD %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% EPH %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% CTS %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%FSA %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%GUY MOREL%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% ISS %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%JUDICIARY%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%PRINT%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% UNIVERSAL %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%UNISEY%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%H RESORT%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% STC %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% SPTC %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and (clientname like '%SPA STAFF%' or clientname like '%SPA REP%') and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% SPF %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and (clientname like '% MAIA %' or clientname like '% -MAIA %' or clientname like '%-MAIA %') and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and (clientname like '%NOUVOBAN%' or clientname like '%NVB%') and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');

select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%OCEANA%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% SCAA %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% SCB %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% SPO %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% SKYCHEF %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% DOC %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
-- select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%ABSA%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');












