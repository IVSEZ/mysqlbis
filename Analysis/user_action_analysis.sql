select * from rcbill.rcb_useractions where clid=717788;



set @clientcode = 'I.000019616';
set @clientid = rcbill.GetClientID(@clientcode);
select *, (select name from rcbill.rcb_users where id =a.userid) as action_user from rcbill.rcb_useractions a 
where clid in (@clientid);

select *, (select name from rcbill.rcb_users where id =a.userid) as action_user 
from rcbill.rcb_useractions a 
where USERID=324907;

select *, (select name from rcbill.rcb_users where id =a.userid) as action_user 
from rcbill.rcb_useractions a 
where USERID=248288;



select * from rcbill.rcb_users where name like '%Francis m%';

select * from rcbill.rcb_users where name like '%reza%';

####################
## ALL USER ACTIONS
select userid,  (select name from rcbill.rcb_users where id =a.userid) as action_user 
, starttime, endtime, comment, label
, clid, rcbill.GetClientCode(a.clid) as clientcode
, cid, rcbill.GetContractCode(a.cid) as contractcode
, paymentid, amount
from rcbill.rcb_useractions a 

; 


select userid,  (select name from rcbill.rcb_users where id =a.userid) as action_user 
, starttime, endtime, comment, label
, clid, rcbill.GetClientCode(a.clid) as clientcode
, cid, rcbill.GetContractCode(a.cid) as contractcode
, paymentid, amount
from rcbill.rcb_useractions a 
where clid in (@clientid)
;
-- where USERID=248288;
select * from rcbill.rcb_useractions where USERID=324907;
select userid,  (select name from rcbill.rcb_users where id =a.userid) as action_user 
, starttime, endtime, comment, label
, clid, rcbill.GetClientCode(a.clid) as clientcode
, cid, rcbill.GetContractCode(a.cid) as contractcode
, paymentid, amount
from rcbill.rcb_useractions a 
 where USERID=324907

-- where USERID=248288;
; 
select userid,  (select name from rcbill.rcb_users where id =a.userid) as action_user 
, starttime, endtime, comment, label
, clid, rcbill.GetClientCode(a.clid) as clientcode
, cid, rcbill.GetContractCode(a.cid) as contractcode
, paymentid, amount
from rcbill.rcb_useractions a 
where label in ('Invoice Anulled')
; 

select label, count(*)
from rcbill.rcb_useractions a 
group by label;

select date(starttime) as startdate, label, count(*)
from rcbill.rcb_useractions a 
group by 1,2;
