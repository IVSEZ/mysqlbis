select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname like 'PARENT%';

select * from rcbill_my.rep_custextract where clientname like 'PARENT%';

select * from rcbill_extract.IV_CUSTOMERACCOUNT where CLIENT_ID in (select clientid from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR' and clientname like 'PARENT%');


select * from rcbill_extract.IV_CUSTOMERACCOUNT where PARENTACCOUNTNUMBER is not null;