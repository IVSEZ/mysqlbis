SELECT * FROM rcbill.rcb_tclients
where firm like '%retention%'

;

select * from rcbill.rcb_tclients;
select * from rcbill.clientextendedreport;


select a.id, a.firm,a.kod,a.danno,a.passno, a.Mphone, a.memail, b.id,b.firm,b.kod,b.danno,b.passno,b.mphone, b.memail
from
rcbill.rcb_tclients a
inner join
rcbill.rcb_tclients b
on
a.danno=b.danno
where a.danno not like '%9999%'
and a.DANNO <> ''
;


select a.id, a.firm,a.kod,a.danno,a.passno, a.Mphone, a.memail
-- , b.id,b.firm,b.kod,b.danno,b.passno,b.mphone, b.memail
from
rcbill.rcb_tclients a
-- inner join
-- rcbill.rcb_tclients b
-- on
-- a.danno=b.danno
where 
(a.danno like '%9999%'
or a.DANNO = '')
and
firm not like '%prepaid cards%'
order by firm

;


select distinct danno, count(*) from rcbill.rcb_tclients
group by danno
order by 2 desc, danno
;


select * from rcbill.rcb_tclients where DANNO not like '%9999%' and DANNO <> '';
select * from rcbill.rcb_tclients where DANNO like '%-%';