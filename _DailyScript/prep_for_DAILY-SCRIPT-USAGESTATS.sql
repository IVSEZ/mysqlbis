			explain 
            select CLIENTCODE, CLIENTID, CID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, (select name from rcbill.rcb_traffictypes tt where tt.TRAFFICID=i1.TRAFFICTYPE) as TRAFFICTYPE, USAGEDIRECTION, SUM(MB_USED) as MB_USED 
            from rcbill.rcb_ipusage i1
            where 0=0
			-- and CLIENTCODE=@kod3
            -- and date(USAGEDATE)<>date(now())
            and USAGEDATE<>date(now())
			group by CLIENTCODE, CLIENTID, CID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE, USAGEDIRECTION
            ;
            
            
            
            select i1.CLIENTCODE, i1.CLIENTID, i1.CID, i1.CONTRACTCODE, i1.CLIENTIP, i1.PROCESSEDCLIENTIP, i1.USAGEDATE
            , (select name from rcbill.rcb_traffictypes tt where tt.TRAFFICID=i1.TRAFFICTYPE) as TRAFFICTYPE
            , i1.USAGEDIRECTION, SUM(i1.MB_USED) as MB_USED 
            from rcbill.rcb_ipusage i1
            left join 
            rcbill.rcb_traffictypes tt
            on i1.TRAFFICTYPE=tt.TRAFFICID
            
            where 0=0
			-- and CLIENTCODE=@kod3
            -- and date(USAGEDATE)<>date(now())
            and i1.USAGEDATE<>date(now())
			group by 1,2,3,4,5,6,7,8,9
            ;
            
            


insert into rcbill.clientcontractipusage
(
	select CLIENTCODE, CLIENTID as CLIENT_ID, CID as CONTRACT_ID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE
	, ifnull(sum(MB_UL),0) as MB_UL, ifnull(sum(MB_DL),0) as MB_DL, (ifnull(sum(MB_UL),0) + ifnull(sum(MB_DL),0)) as MB_TOTAL
	from 
	(
		select a.*
		, case when a.USAGEDIRECTION='O' then MB_USED end as MB_UL
		, case when a.USAGEDIRECTION='I' then MB_USED end as MB_DL

		from 
		(
			select i1.CLIENTCODE, i1.CLIENTID, i1.CID, i1.CONTRACTCODE, i1.CLIENTIP, i1.PROCESSEDCLIENTIP, i1.USAGEDATE
            -- , i1.TRAFFICTYPE
            , (select name from rcbill.rcb_traffictypes tt where tt.TRAFFICID=i1.TRAFFICTYPE) as TRAFFICTYPE
				, i1.USAGEDIRECTION, SUM(i1.MB_USED) as MB_USED 
			from 
            (
				select * from rcbill.rcb_ipusage i1
				where 0=0
				-- and CLIENTCODE=@kod3
				-- and date(USAGEDATE)<>date(now())
				-- and i1.USAGEDATE<date(now())
                and (USAGEDATE>(select max(usagedate) from rcbill.clientcontractipusage_stg) and USAGEDATE<date(now()) )
             ) i1
             group by 1,2,3,4,5,6,7,8,9
		) a
	) a 
	group by CLIENTCODE, CLIENTID, CID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE
	
)    
;

            select i1.CLIENTCODE, i1.CLIENTID, i1.CID, i1.CONTRACTCODE, i1.CLIENTIP, i1.PROCESSEDCLIENTIP, i1.USAGEDATE, tt.name as TRAFFICTYPE
				, i1.USAGEDIRECTION, i1.MB_USED 
            from 
            (
				select i1.CLIENTCODE, i1.CLIENTID, i1.CID, i1.CONTRACTCODE, i1.CLIENTIP, i1.PROCESSEDCLIENTIP, i1.USAGEDATE, i1.TRAFFICTYPE
				, i1.USAGEDIRECTION, SUM(i1.MB_USED) as MB_USED 
				from rcbill.rcb_ipusage i1
				where 0=0
				-- and CLIENTCODE=@kod3
				-- and date(USAGEDATE)<>date(now())
				-- and i1.USAGEDATE<date(now())
                and (USAGEDATE>(select max(usagedate) from rcbill.clientcontractipusage_stg) and USAGEDATE<date(now()) )
				group by 1,2,3,4,5,6,7,8,9
			) i1
            left join 
            rcbill.rcb_traffictypes tt
            on i1.TRAFFICTYPE=tt.TRAFFICID
            ;
            
            


drop table if exists rcbill.clientcontractipusage_stg;
create table rcbill.clientcontractipusage_stg(index idxcciu1(clientcode),index idxcciu2(contractcode),index idxcciu3(CLIENT_ID),index idxcciu4(CONTRACT_ID), index idxcciu5(PROCESSEDCLIENTIP), index idxcciu6(USAGEDATE)) as 
(
	select * from rcbill.clientcontractipusage
)
;


create index idxcciu6 on rcbill.clientcontractipusage_stg(USAGEDATE);

select max(usagedate) from rcbill.clientcontractipusage_stg;


select max(usagedate) from rcbill.clientcontractipusage;

delete from rcbill.clientcontractipusage where usagedate='2020-12-20';

delete from rcbill.clientcontractipusage_stg where usagedate='2020-12-20';




            select CLIENTCODE, CLIENTID, CID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, (select name from rcbill.rcb_traffictypes tt where tt.TRAFFICID=i1.TRAFFICTYPE) as TRAFFICTYPE, USAGEDIRECTION, SUM(MB_USED) as MB_USED 
            from rcbill.rcb_ipusage i1
            where 0=0
			-- and CLIENTCODE=@kod3
            -- and date(USAGEDATE)<>date(now())
            and (USAGEDATE>(select max(usagedate) from rcbill.clientcontractipusage_stg) and USAGEDATE<date(now()) )
			group by CLIENTCODE, CLIENTID, CID, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE, USAGEDIRECTION
            ;