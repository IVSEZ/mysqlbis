select count(*) from rcbill.clientlivetvstats;
show columns from rcbill.clientlivetvstats;
show index from rcbill.clientlivetvstats;

 select * from rcbill.rcb_iptv_package_channels_list;
 
  select * from rcbill_my.rep_livetvranking2021 order by overall asc;
  select * from rcbill_my.rep_livetvpivot2021 order by total_duration desc ;
  
  select * from rcbill.rcb_useractions;
  
  
  select * from rcbill_my.clientticket_cmmtjourney
  where year(commentdate)=2021
  and commentuser in ('Vanessa Aglae')
  ;
  
  select * from rcbill_my.clientticket_cmmtjourney
  where year(commentdate)=2021
  and 
   (
      openuser in ('Vanessa Aglae')
      or 
      commentuser in ('Vanessa Aglae')
	)
  ;
  
  			select commentuser, count(distinct ticketid) as d_tickets, count(comment) as comments 
			, min(date(commentdate)) as firstdate, max(date(commentdate)) as lastdate
            /*
            , count(distinct date(commentdate)) as cmmtdays
			, datediff(date_add(max(date(commentdate)),INTERVAL 1 day), min(date(commentdate))) as totaldays
			, count(distinct ticketid)/count(distinct date(commentdate)) as avgtktday
			, count(comment)/count(distinct date(commentdate)) as avgcmtday
			, (count(distinct date(commentdate))/datediff(date_add(max(date(commentdate)),INTERVAL 1 day), min(date(commentdate)))) as consistency
			*/
            from 
			rcbill_my.clientticket_cmmtjourney
			where year(commentdate)=2021
			and 
				(
					commentuser in ('Vanessa Aglae','Ervin Estico')
                    -- or 
                    -- openuser in ('Vanessa Aglae','Ervin Estico')
				)
			group by commentuser
			order by 2 desc
            ;
            
            
  			select openuser, count(distinct ticketid) as d_tickets, count(comment) as comments 
			, min(date(commentdate)) as firstdate, max(date(commentdate)) as lastdate
            /*
            , count(distinct date(commentdate)) as cmmtdays
			, datediff(date_add(max(date(commentdate)),INTERVAL 1 day), min(date(commentdate))) as totaldays
			, count(distinct ticketid)/count(distinct date(commentdate)) as avgtktday
			, count(comment)/count(distinct date(commentdate)) as avgcmtday
			, (count(distinct date(commentdate))/datediff(date_add(max(date(commentdate)),INTERVAL 1 day), min(date(commentdate)))) as consistency
			*/
            from 
			rcbill_my.clientticket_cmmtjourney
			where year(commentdate)=2021
			and 
				(
					-- commentuser in ('Vanessa Aglae','Ervin Estico')
                    -- or 
                    openuser in ('Vanessa Aglae','Ervin Estico')
				)
			group by openuser
			order by 2 desc
            ;  
            
            
            