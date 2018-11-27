select * from rcbill.rcb_tclients;


select a.kod as kod1, a.firm as  firm1, a.danno as danno1 
     from 
     ( 
		select kod, firm, danno from rcbill.rcb_tclients  
		where 
		/*
		firm not like "%?%" 
		-- and firm not like "%close%" and firm not like "%PREPAID CARDS%" 
		and firm not like "%close%" and firm not like "%PREPAID%" 
		and danno <> '' 
		and danno not like "%999999%" 
		and danno like "%-%" 
		and danno not like "000-0000-0-0-00" and danno not like "999-9999-9-9-99" 
		*/
		firm not regexp 'prepaid|"?"|close'
		and 
		danno not regexp '999999|000-0000-0-0-00|999-9999-9-9-99'
		and 
		danno regexp '-'
		order by firm 
     limit 10
     ) a 
     
     ;
     
     
     select danno, count(*) as nincount
     from 
	 rcbill.rcb_tclients
     group by danno
     order by 2 desc;
     
     select danno, count(*) as nincount
     from 
     -- rcbill.rcb_tclients
     ( 
			/*
		 select kod, firm, danno from rcbill.rcb_tclients  where firm not like "%?%" 
		 and firm not like "%close%" and firm not like "%PREPAID CARDS%" 
		 and danno <> '' and danno not like "%999999%" 
		 and danno like "%-%" 
		 and danno not like "000-0000-0-0-00" and danno not like "999-9999-9-9-99" 
		 -- and danno not in ('986-1145-1-0-94','005-0521-7-1-23','986-0567-1-1-10')
		 order by firm
         */
			select kod, firm, danno from rcbill.rcb_tclients  
			where 
			/*
			firm not like "%?%" 
			-- and firm not like "%close%" and firm not like "%PREPAID CARDS%" 
			and firm not like "%close%" and firm not like "%PREPAID%" 
			and danno <> '' 
			and danno not like "%999999%" 
			and danno like "%-%" 
			and danno not like "000-0000-0-0-00" and danno not like "999-9999-9-9-99" 
			*/
			firm not regexp 'prepaid|"?"|close'
			and 
			danno not regexp '999999|000-0000-0-0-00|999-9999-9-9-99'
			and 
			danno regexp '-'
			order by firm 
     ) a      
          
     group by danno
     order by 2 desc;
     
     
     select mphone, count(*) as phonecount
     from 
	 rcbill.rcb_tclients
     group by mphone
     order by 2 desc;
     
     select mphone, count(*) as phonecount
     from 
	 ( 	
     
			select kod, firm, mphone from rcbill.rcb_tclients  
            where 
            /*
            firm not like "%?%" 
			and firm not like "%close%" and firm not like "%PREPAID CARDS%" 
			and mphone is not null and mphone <> '' and mphone not like "%4414243%" 
            and mphone not like '%248248-0%' and mphone not like '%248248-248%'
			and length(mphone) >= 7 
			*/
            firm not regexp 'prepaid|"?"|close'
            AND
			mphone <> '' and mphone is not null and length(mphone)>=7
            and 
            mphone not regexp '4414243|248248-0|248248-248|248248|24800248-248|0248111111'
            -- and 
            -- mphone regexp '-'
            order by firm
	 ) a 
     group by mphone
     order by 2 desc     
	;
     