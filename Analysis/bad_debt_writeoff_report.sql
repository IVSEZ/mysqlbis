/*
select * -- b.USERNAME 
from rcbill.rcb_users b 
-- where b.USERID=a.userid
;
*/
select *, rcbill.GetClientNameFromID(a.CLID) as ClientName
, (select b.name from rcbill.rcb_users b where b.id=a.userid) as UserName 
, (select sum(c.total) from rcbill.rcb_invoicesheader c where c.type=11 and c.HARD=0 
and date(c.UPDDATE)=date(a.UPDDATE) 
and c.CLID=a.CLID and c.USERID=a.USERID) as WrittenOffAmount
from rcbill.rcb_comments a 
where 
-- a.clid=694304 and
a.COMMENT like '%BAD DEBT%' and year(a.UPDDATE)=2021 order by a.UPDDATE desc
;

/*
select *, rcbill.GetClientNameFromID(a.CLID) as ClientName
, (select b.name from rcbill.rcb_users b where b.id=a.userid) as UserName 
, (select sum(c.total) from rcbill.rcb_invoicesheader c where c.type=11 and date(c.UPDDATE)=date(a.UPDDATE) and c.USERID=a.USERID)
from rcbill.rcb_comments a where COMMENT like '%BAD DEBT%' and year(UPDDATE)=2021 order by UPDDATE desc;
*/


-- select * from rcbill.rcb_casa where CLID=694304;
select * from rcbill.rcb_invoicesheader where CLID=690751;
select * from rcbill.rcb_invoicesheader where CLID=668304;
select * from rcbill.rcb_invoicesheader where CLID=718015;