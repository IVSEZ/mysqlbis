
show index from rcbill_my.rep_tkt_irs_level1;
show index from rcbill_my.rep_tkt_irs_level2;
show index from rcbill_my.rep_tkt_irs_level3;

SELECT * FROM rcbill_my.rep_tkt_irs_level1;

SELECT * FROM rcbill_my.rep_tkt_irs_level2;

SELECT * FROM rcbill_my.rep_tkt_irs_level3;

SELECT * FROM rcbill_my.rep_tkt_f_level1;

SELECT * FROM rcbill_my.rep_tkt_f_level2;

SELECT * FROM rcbill_my.rep_tkt_f_level3;

SELECT * FROM rcbill_my.rep_tkt_irs_level3 
WHERE 0=0
and open_D='2021-08-09'
and district='POINTE LARUE'
;

SELECT * FROM rcbill_my.rep_tkt_f_level3 
WHERE 0=0
and open_D='2021-08-18'
and island='MAHE'
-- and district='POINTE LARUE'
and openreason='SPECIAL SERVICE REQUEST'
;

SELECT * FROM rcbill_my.rep_tkt_f_level2 
WHERE 0=0
and open_D='2021-08-17'
and island='MAHE'
-- and district='POINTE LARUE'
and openreason='NO ACCESS TO INTERNET'
;

-- select *  from rcbill_my.clientticket_cmmtjourney where ticketid=1014346;
-- select * from rcbill_my.clientticket_assgnjourney where ticketid=1014346;
