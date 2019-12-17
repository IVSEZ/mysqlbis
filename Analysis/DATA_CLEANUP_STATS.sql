use rcbill_my;


-- ==========================================================



#### PARCEL PRESENT
select  parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
group by parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

select  parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a
where a.dayssincelastactive<=365 
group by parcel_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

#### EMAIL PRESENT
select  email_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
group by email_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

select  email_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
where a.dayssincelastactive<=365 
group by email_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

#### NIN PRESENT
select  nin_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
group by nin_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

select  nin_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
where a.dayssincelastactive<=365 
group by nin_present
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

#### ADDRESS PRESENT
select  ADDRESS_PRESENT
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
group by ADDRESS_PRESENT
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;

select  ADDRESS_PRESENT
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
where a.dayssincelastactive<=365 
group by ADDRESS_PRESENT
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;


## ONE YEAR
select  ONE_YEAR
-- , clientarea, clientclass
, isaccountactive, accountactivitystage, count(clientcode) as clients
from 
rcbill_my.rep_custextract a 
group by ONE_YEAR
-- , clientarea, clientclass
, isaccountactive, accountactivitystage
with rollup
;


-- ==========================================================



select '2019-12-11' as BaseLineDate;

set @tablename='rcbill_my.rep_custextract_compare20191215';

SET @qs = CONCAT('SELECT * FROM ', @tablename);
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_CLASS_STATUS, count(*) from ', @tablename, ' group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_ADDRESS_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_LOCATION_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_AREA_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_EMAIL_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_PHONE_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, PARCEL_ADD_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;


-- ===========================================================

set @tablename='rcbill_my.rep_custextract_compare20191216';

SET @qs = CONCAT('SELECT * FROM ', @tablename);
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_NAME_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_CLASS_STATUS, count(*) from ', @tablename, ' group by 1, 2, 3 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_ADDRESS_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_LOCATION_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_AREA_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_EMAIL_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_NIN_STATUS, NIN_PRESENT, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, CLIENT_PHONE_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

SET @qs = CONCAT('select REPORTDATE, CLIENT_STATUS, PARCEL_ADD_STATUS, CLIENTCLASS, count(*) from ', @tablename, ' group by 1, 2, 3, 4 with rollup' );
PREPARE ps FROM @qs;
EXECUTE ps;

-- ===========================================================
