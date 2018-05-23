use rcbill;

select * from rcb_clientclasses;

select a.id, a.firm, a.kod, a.clclass 
from 
rcb_tclients a 
left join
rcb_clientclasses b

on 
a.CLClass=b.ID
where a.clclass=0
order by 4
;

SELECT id, firm, kod, trim(SUBSTRING_INDEX(SUBSTRING_INDEX(t.mphone, ',', n.n), ',', -1)) as mphone
  FROM rcbill.rcb_tclients t CROSS JOIN 
(
   SELECT a.N + b.N * 10 + 1 n
     FROM 
    (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
   ,(SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
    ORDER BY n
) n
 WHERE n.n <= 1 + (LENGTH(t.mphone) - LENGTH(REPLACE(t.mphone, ',', '')))
 ORDER BY firm;
        
 select *, replace(mphone,'00248','') as m1, replace(mphone,'0248','') as m2, replace(mphone,'248','') as m3 from rcbill.rcb_clientphones;
 
 select FIND_IN_SET ('0248', mphone) from rcbill.rcb_clientphones order by 1 desc;
        
		select a.*,b.KOD,b.BULSTAT,b.DANNO,b.PASSNo,b.MPHONE,b.MEMAIL,b.MOLADDRESS,b.MOL
		,c.firm as Dup_ClientName,
		c.kod as Dup_ClientCode,
		c.danno as Dup_NIN,
		c.PASSNo as Dup_PassNo,
		c.MPHONE as Dup_MPhone,
		c.MEMAIL as DUP_MEMAIL,
		c.MOLADDRESS as DUP_MOLADDRESS
/*		,d.firm as Dup1_ClientName,
		d.kod as Dup1_ClientCode,
		d.danno as Dup1_NIN,
		d.PASSNo as Dup1_PassNo,
		d.MPHONE as Dup1_MPhone,
		d.MEMAIL as DUP1_MEMAIL,
		d.MOLADDRESS as DUP1_MOLADDRESS
*/

		from 
		temptopinactiveclients a 
		inner join
		rcb_tclients b
		on
		a.cl_clientid=b.id

		left join
 		rcb_tclients c
-- 		on
-- 		a.cl_clientname=c.firm

-- 		inner join
-- 		rcb_tclients d
 		on
		b.danno=c.danno
 		where b.danno not like '%9999%'
 		and b.DANNO <> ''
    

		order by
		a.lastpaymentdate
        