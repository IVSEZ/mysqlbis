/*
select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname like 'PARENT%';

select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname like '%STAFF%'  and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE','EMPLOYEE');

select * from rcbill_my.rep_custextract where clientname like 'PARENT%';

select * from rcbill_extract.IV_CUSTOMERACCOUNT where CLIENT_ID in (select clientid from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname like 'PARENT%');


select * from rcbill_extract.IV_CUSTOMERACCOUNT where PARENTACCOUNTNUMBER is not null;


select *, length(CUSTOMERACCOUNTNUMBER) as C_L, length(BILLINGACCOUNTNUMBER) as B_L, length(SERVICEACCOUNTNUMBER) as S_L, length(SERVICEINSTANCEIDENTIFIER) as SI_L, length(SERVICEINSTANCENUMBER) as SIN_L  
from rcbill_extract.IV_SERVICEINSTANCE
-- where CLIENT_ID='723711'
;


*/

select * from rcbill_extract.parentaccount;


drop table if exists rcbill_extract.childaccount;

create table rcbill_extract.childaccount(index idxIVCA12(CLIENTID)) as
(
	select *, cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – AIR SEYCHELLES') as PARENTACCOUNTNUMBER 
    from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%AIR SEY%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE')
);

insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – AVANI RESORT STAFF') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%AVANI%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – ABSA SEYCHELLES') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%ABSA%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – AIRTEL SEYCHELLES') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%AIRTEL%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – CARANA SEYCHELLES') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% CARANA %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – MASON TRAVEL SEYCHELLES') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%MASON%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – CENTRAL BANK OF SEYCHELLES (CBS)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%CBS %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – COMMUNITY DEVELOPMENT (CD)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% CD %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – CONSTANCE EPHELIA RESORT (EPH)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% EPH %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – CREOLE TRAVEL SEYCHELLES (CTS)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% CTS %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – FINANCIAL SERVICES AUTHORITY  (FSA)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%FSA %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – GUY MOREL INSTITUTE SEYCHELLES') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%GUY MOREL%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – INTERNATIONAL SCHOOL SEYCHELLES (ISS)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% ISS %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT –JUDICIARY SEYCHELLES') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%JUDICIARY%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – PRINTHOUSE') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%PRINT%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – UNIVERSAL TRANSPORT (UT)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% UNIVERSAL %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT - UNIVERSITY OF SEYCHELLES (UNISEY)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%UNISEY%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – H RESORT') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%H RESORT%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – SEYCHELLES TRADING COMPANY (STC)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% STC %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – SEYCHELLES PUBLIC TRANSPORT CORPORATION (') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% SPTC %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT –SEYCHELLES PORT AUTHORITY (SPA)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and (clientname like '%SPA STAFF%' or clientname like '%SPA REP%') and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – SEYCHELLES PENSION FUND STAFF (SPF)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '% SPF %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – ANANTARA MAIA SEYCHELLES VILLAS (MAIA)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and (clientname like '% MAIA %' or clientname like '% -MAIA %' or clientname like '%-MAIA %') and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT - NOUVOBANQ SEYCHELLES (NVB)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and (clientname like '%NOUVOBAN%' or clientname like '%NVB%') and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT - OCEANA FISHERIES (OF)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%OCEANA%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT - SEYCHELLES CIVIL AVIATION AUTHORITY (SCAA') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%SCAA %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT –SEYCHELLES COMMERCIAL BANK (SCB)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%SCB %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT –SEYCHELLES POST OFFICE (SPO)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%POST %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT –SKYCHEF') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%SKYCHEF %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');
insert into rcbill_extract.childaccount
select *,  cast(concat('CA_',CLIENTCODE) as char(255)) AS ACCOUNTNUMBER, (select ACCOUNTNUMBER from rcbill_extract.parentaccount where clientname='PARENT – DEPARTMENT OF CULTURE (DOC)') as PARENTACCOUNTNUMBER from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%DOC %' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');

-- select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname not like 'PARENT%' and clientname like '%ABSA%' and clientclass not in  ('CORPORATE LARGE','CORPORATE LITE');



select * from rcbill_extract.childaccount;
select PARENTACCOUNTNUMBER, count(*) from rcbill_extract.childaccount group by 1;

select a.*, b.clientname
from 
(
select PARENTACCOUNTNUMBER, count(*) from rcbill_extract.childaccount group by 1
) a 
right join 
 rcbill_extract.parentaccount b
 on a.PARENTACCOUNTNUMBER=b.ACCOUNTNUMBER
 ;


select a.CLIENTNAME, a.ACCOUNTNUMBER from rcbill_extract.parentaccount a ;
select * from rcbill_extract.IV_CUSTOMERACCOUNT where PARENTACCOUNTNUMBER is not null;

select * from rcbill_extract.IV_CUSTOMERACCOUNT where PARENTACCOUNTNUMBER is not null;




