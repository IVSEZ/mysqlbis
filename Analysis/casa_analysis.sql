select a.*,b.username from 
 rcbill.rcb_casa a 
 left join
 rcbill.rcb_users b
 on a.userid=b.id
	-- only the residential customers
    -- (select * from rcbill.rcb_casa where CLID in (select id from rcbill.rcb_tclients where CLClass=13)) tx
	where
	(a.hard not in (100, 101, 102) or a.hard is null)
   -- and date(PAYDATE)>=@startdate and date(PAYDATE)<=@enddate
    -- limit 100
    and 
    a.clid=694972 
    
    ;

select * from rcbill.rcb_invoicesheader where clid=694972;

-- select * from rcbill.rcb_users where id=304801;

-- select * from rcbill.rcb_tclients where kod='I6124';