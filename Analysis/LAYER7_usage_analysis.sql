use rcbill_my;

 select * from rcbill_my.IV_IP_POOL;
 select *
, ((INCOMINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as INCOMING_TB
, ((OUTGOINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as OUTGOING_TB
, ((TOTALBYTES))/(1024.0*1024.0*1024.0*1024.0) as TOTAL_TB
from rcbill_my.dailyallusage_l7;
 select * from rcbill.clientcontractipmonth where USAGE_YR=2020;
 
 
select a.*, b.*
, ((b.INCOMINGBYTES))/(1024.0*1024.0) as INCOMING_MB
, ((b.OUTGOINGBYTES))/(1024.0*1024.0) as OUTGOING_MB
, ((b.TOTALBYTES))/(1024.0*1024.0) as TOTAL_MB

, ((b.INCOMINGBYTES))/(1024.0*1024.0*1024.0) as INCOMING_GB
, ((b.OUTGOINGBYTES))/(1024.0*1024.0*1024.0) as OUTGOING_GB
, ((b.TOTALBYTES))/(1024.0*1024.0*1024.0) as TOTAL_GB

, ((b.INCOMINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as INCOMING_TB
, ((b.OUTGOINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as OUTGOING_TB
, ((b.TOTALBYTES))/(1024.0*1024.0*1024.0*1024.0) as TOTAL_TB

from 
rcbill_my.IV_IP_POOL a 
left join
rcbill_my.dailyallusage_l7 b 
on a.IPADDRESS=b.IP
;

select ﻿POOL, count(IPADDRESS) as ips, count(distinct IPADDRESS) as d_ips
from 
(
select a.*, b.*
from 
rcbill_my.IV_IP_POOL a 
left join
rcbill_my.dailyallusage_l7 b 
on a.IPADDRESS=b.IP
) a
group by ﻿POOL
;


select a.*
, (TOTAL_MB/TOTAL_IP) as MB_PER_IP
, (TOTAL_GB/TOTAL_IP) as GB_PER_IP
, (TOTAL_TB/TOTAL_IP) as TB_PER_IP
from 
(
		select ﻿POOL, count(IPADDRESS) as TOTAL_IP
        -- , count(distinct IPADDRESS) as d_ips
        , sum(TOTALBYTES) as TOTALBYTES
        , sum(TOTAL_MB) as TOTAL_MB
        , sum(TOTAL_GB) as TOTAL_GB
        , sum(TOTAL_TB) as TOTAL_TB
		from 
		(
		select a.*, b.*
		from 
		rcbill_my.IV_IP_POOL a 
		left join
		(
			select *
			, ((INCOMINGBYTES))/(1024.0*1024.0) as INCOMING_MB
			, ((OUTGOINGBYTES))/(1024.0*1024.0) as OUTGOING_MB
			, ((TOTALBYTES))/(1024.0*1024.0) as TOTAL_MB

			, ((INCOMINGBYTES))/(1024.0*1024.0*1024.0) as INCOMING_GB
			, ((OUTGOINGBYTES))/(1024.0*1024.0*1024.0) as OUTGOING_GB
			, ((TOTALBYTES))/(1024.0*1024.0*1024.0) as TOTAL_GB

			, ((INCOMINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as INCOMING_TB
			, ((OUTGOINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as OUTGOING_TB
			, ((TOTALBYTES))/(1024.0*1024.0*1024.0*1024.0) as TOTAL_TB
			from rcbill_my.dailyallusage_l7

		) b
		-- rcbill_my.dailyallusage_l7 b 
		on a.IPADDRESS=b.IP
		) a
		group by ﻿POOL
) a 

;




-- select * from rcbill.clientcontractipmonth where PROCESSEDCLIENTIP='41.220.111.133';

select PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, USAGE_MTH, count(distinct PROCESSEDCLIENTIP) as INSTANCES
from rcbill.clientcontractipmonth
where USAGE_YR=2020 and PROCESSEDCLIENTIP<>'0.0.0.0'
group by PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, USAGE_MTH
;

select PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, FROM_DATE, TO_DATE, count(distinct PROCESSEDCLIENTIP) as INSTANCES
from rcbill.clientcontractipmonth
where USAGE_YR=2020 and PROCESSEDCLIENTIP<>'0.0.0.0'
group by PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, FROM_DATE, TO_DATE
;





set @ip='41.220.111.133';
set @ip='154.70.161.79';


select a.*, b.*
, ((b.INCOMINGBYTES))/(1024.0*1024.0) as INCOMING_MB
, ((b.OUTGOINGBYTES))/(1024.0*1024.0) as OUTGOING_MB
, ((b.TOTALBYTES))/(1024.0*1024.0) as TOTAL_MB

, ((b.INCOMINGBYTES))/(1024.0*1024.0*1024.0) as INCOMING_GB
, ((b.OUTGOINGBYTES))/(1024.0*1024.0*1024.0) as OUTGOING_GB
, ((b.TOTALBYTES))/(1024.0*1024.0*1024.0) as TOTAL_GB

, ((b.INCOMINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as INCOMING_TB
, ((b.OUTGOINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as OUTGOING_TB
, ((b.TOTALBYTES))/(1024.0*1024.0*1024.0*1024.0) as TOTAL_TB

from 
rcbill_my.IV_IP_POOL a 
left join
rcbill_my.dailyallusage_l7 b 
on a.IPADDRESS=b.IP

where a.IPADDRESS=@ip
;


select PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, USAGE_MTH, count(distinct PROCESSEDCLIENTIP) as INSTANCES
from rcbill.clientcontractipmonth
where USAGE_YR=2020 and PROCESSEDCLIENTIP<>'0.0.0.0'
and PROCESSEDCLIENTIP=@ip
group by PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, USAGE_MTH
;

select PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, FROM_DATE, TO_DATE, (datediff(TO_DATE,FROM_DATE)+1) as days, count(distinct PROCESSEDCLIENTIP) as INSTANCES
from rcbill.clientcontractipmonth
where USAGE_YR=2020 and PROCESSEDCLIENTIP<>'0.0.0.0'
and PROCESSEDCLIENTIP=@ip
group by PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, FROM_DATE, TO_DATE
;


select a.*,b.*
-- , rcbill_my.GetNetworkForClientContractDate(b.CLIENTCODE, b.CONTRACTCODE, b.FROM_DATE) as NETWORK_FROM
-- , rcbill_my.GetNetworkForClientContractDate(b.CLIENTCODE, b.CONTRACTCODE, b.TO_DATE) as NETWORK_TO
-- , rcbill_my.GetNetworkForClientContract(b.CLIENTCODE, b.CONTRACTCODE) as NETWORK
from 
(
	select a.*, b.*
	, ((b.INCOMINGBYTES))/(1024.0*1024.0) as INCOMING_MB
	, ((b.OUTGOINGBYTES))/(1024.0*1024.0) as OUTGOING_MB
	, ((b.TOTALBYTES))/(1024.0*1024.0) as TOTAL_MB

	, ((b.INCOMINGBYTES))/(1024.0*1024.0*1024.0) as INCOMING_GB
	, ((b.OUTGOINGBYTES))/(1024.0*1024.0*1024.0) as OUTGOING_GB
	, ((b.TOTALBYTES))/(1024.0*1024.0*1024.0) as TOTAL_GB

	, ((b.INCOMINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as INCOMING_TB
	, ((b.OUTGOINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as OUTGOING_TB
	, ((b.TOTALBYTES))/(1024.0*1024.0*1024.0*1024.0) as TOTAL_TB

	from 
	rcbill_my.IV_IP_POOL a 
	left join
	rcbill_my.dailyallusage_l7 b 
	on a.IPADDRESS=b.IP

	-- where a.IPADDRESS=@ip
) a 
inner join 
(

	/*
	select PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, CONTRACTCODE
    , rcbill_my.GetNetworkForClientContract(CLIENTCODE, CONTRACTCODE) as NETWORK
    , rcbill_my.GetNetworkForClient(CLIENTCODE) as NETWORK2
    , FROM_DATE, TO_DATE, (datediff(TO_DATE,FROM_DATE)+1) as days, count(distinct PROCESSEDCLIENTIP) as INSTANCES
	from rcbill.clientcontractipmonth
	where USAGE_YR=2020 and PROCESSEDCLIENTIP<>'0.0.0.0'
    and TO_DATE<='2020-07-31'
	-- and PROCESSEDCLIENTIP=@ip
	group by PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, CONTRACTCODE, NETWORK
		, NETWORK2 
        , FROM_DATE, TO_DATE
	*/
		select a.PROCESSEDCLIENTIP, a.NETWORK, a.NETWORK2, count(distinct a.PROCESSEDCLIENTIP)
		from
		(
			select PROCESSEDCLIENTIP, rcbill_my.GetNetworkForClientContract(CLIENTCODE, CONTRACTCODE) as NETWORK
			, rcbill_my.GetNetworkForClient(CLIENTCODE) as NETWORK2
			-- CLIENTCODE, CLIENTNAME, CONTRACTCODE, FROM_DATE, TO_DATE, (datediff(TO_DATE,FROM_DATE)+1) as days, count(distinct PROCESSEDCLIENTIP) as INSTANCES
			from rcbill.clientcontractipmonth
			where USAGE_YR=2020 and PROCESSEDCLIENTIP<>'0.0.0.0'
			and TO_DATE<='2020-07-31'
			-- and PROCESSEDCLIENTIP=@ip
			group by PROCESSEDCLIENTIP, 2, 3
		) a 
		group by 1,2,3    
        
) b
on binary a.IPADDRESS= binary b.PROCESSEDCLIENTIP

/*
and 
(
	( a.DATESTART<=b.FROM_DATE) and (a.DATEEND>=TO_DATE)
)
*/
;


select a.PROCESSEDCLIENTIP, a.NETWORK, a.NETWORK2, count(distinct a.PROCESSEDCLIENTIP)
from
(
	select PROCESSEDCLIENTIP, rcbill_my.GetNetworkForClientContract(CLIENTCODE, CONTRACTCODE) as NETWORK
    , rcbill_my.GetNetworkForClient(CLIENTCODE) as NETWORK2
    -- CLIENTCODE, CLIENTNAME, CONTRACTCODE, FROM_DATE, TO_DATE, (datediff(TO_DATE,FROM_DATE)+1) as days, count(distinct PROCESSEDCLIENTIP) as INSTANCES
	from rcbill.clientcontractipmonth
	where USAGE_YR=2020 and PROCESSEDCLIENTIP<>'0.0.0.0'
    and TO_DATE<='2020-07-31'
	-- and PROCESSEDCLIENTIP=@ip
	group by PROCESSEDCLIENTIP, 2, 3
) a 
group by 1,2,3
    ;


###########################################################################################
###########################################################################################
###########################################################################################
###########################################################################################




select a.*
, (TOTAL_MB/TOTAL_IP) as MB_PER_IP
, (TOTAL_GB/TOTAL_IP) as GB_PER_IP
, (TOTAL_TB/TOTAL_IP) as TB_PER_IP
from 
(
		select ﻿POOL, count(IPADDRESS) as TOTAL_IP
        -- , count(distinct IPADDRESS) as d_ips
        , sum(TOTALBYTES) as TOTALBYTES
        , sum(TOTAL_MB) as TOTAL_MB
        , sum(TOTAL_GB) as TOTAL_GB
        , sum(TOTAL_TB) as TOTAL_TB
		from 
		(
		select a.*, b.*
		from 
		rcbill_my.IV_IP_POOL a 
		left join
		(
			select *
			, ((INCOMINGBYTES))/(1024.0*1024.0) as INCOMING_MB
			, ((OUTGOINGBYTES))/(1024.0*1024.0) as OUTGOING_MB
			, ((TOTALBYTES))/(1024.0*1024.0) as TOTAL_MB

			, ((INCOMINGBYTES))/(1024.0*1024.0*1024.0) as INCOMING_GB
			, ((OUTGOINGBYTES))/(1024.0*1024.0*1024.0) as OUTGOING_GB
			, ((TOTALBYTES))/(1024.0*1024.0*1024.0) as TOTAL_GB

			, ((INCOMINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as INCOMING_TB
			, ((OUTGOINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as OUTGOING_TB
			, ((TOTALBYTES))/(1024.0*1024.0*1024.0*1024.0) as TOTAL_TB
			from rcbill_my.dailyallusage_l7

		) b
		-- rcbill_my.dailyallusage_l7 b 
		on a.IPADDRESS=b.IP
		) a
		group by ﻿POOL
) a 

;


select a.*
, (TOTAL_MB/TOTAL_D_IP) as MB_PER_IP
, (TOTAL_GB/TOTAL_D_IP) as GB_PER_IP
, (TOTAL_TB/TOTAL_D_IP) as TB_PER_IP
from 
(
		select ﻿POOL, a.NETWORK, upper(a.PACKAGE) as PACKAGE
        -- , a.NETWORK2
        , count(IPADDRESS) as TOTAL_IP
        , count(distinct IPADDRESS) as TOTAL_D_IP
        , sum(TOTALBYTES) as TOTALBYTES
        , sum(TOTAL_MB) as TOTAL_MB
        , sum(TOTAL_GB) as TOTAL_GB
        , sum(TOTAL_TB) as TOTAL_TB
        
        from 
        (
        
				select a.*,b.*
				-- , rcbill_my.GetNetworkForClientContractDate(b.CLIENTCODE, b.CONTRACTCODE, b.FROM_DATE) as NETWORK_FROM
				-- , rcbill_my.GetNetworkForClientContractDate(b.CLIENTCODE, b.CONTRACTCODE, b.TO_DATE) as NETWORK_TO
				-- , rcbill_my.GetNetworkForClientContract(b.CLIENTCODE, b.CONTRACTCODE) as NETWORK
				from 
				(
					select a.*, b.*
					, ((b.INCOMINGBYTES))/(1024.0*1024.0) as INCOMING_MB
					, ((b.OUTGOINGBYTES))/(1024.0*1024.0) as OUTGOING_MB
					, ((b.TOTALBYTES))/(1024.0*1024.0) as TOTAL_MB

					, ((b.INCOMINGBYTES))/(1024.0*1024.0*1024.0) as INCOMING_GB
					, ((b.OUTGOINGBYTES))/(1024.0*1024.0*1024.0) as OUTGOING_GB
					, ((b.TOTALBYTES))/(1024.0*1024.0*1024.0) as TOTAL_GB

					, ((b.INCOMINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as INCOMING_TB
					, ((b.OUTGOINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as OUTGOING_TB
					, ((b.TOTALBYTES))/(1024.0*1024.0*1024.0*1024.0) as TOTAL_TB

					from 
					rcbill_my.IV_IP_POOL a 
					left join
					rcbill_my.dailyallusage_l7 b 
					on a.IPADDRESS=b.IP

					-- where a.IPADDRESS=@ip
				) a 
				inner join 
				(

					/*
					select PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, CONTRACTCODE
					, rcbill_my.GetNetworkForClientContract(CLIENTCODE, CONTRACTCODE) as NETWORK
					, rcbill_my.GetNetworkForClient(CLIENTCODE) as NETWORK2
					, FROM_DATE, TO_DATE, (datediff(TO_DATE,FROM_DATE)+1) as days, count(distinct PROCESSEDCLIENTIP) as INSTANCES
					from rcbill.clientcontractipmonth
					where USAGE_YR=2020 and PROCESSEDCLIENTIP<>'0.0.0.0'
					and TO_DATE<='2020-07-31'
					-- and PROCESSEDCLIENTIP=@ip
					group by PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, CONTRACTCODE, NETWORK
						, NETWORK2 
						, FROM_DATE, TO_DATE
					*/
						select a.PROCESSEDCLIENTIP, a.NETWORK, a.PACKAGE
                        -- , a.NETWORK2, count(distinct a.PROCESSEDCLIENTIP)
						from
						(
							select PROCESSEDCLIENTIP
                            , rcbill_my.GetPackageFromSnapshot(CLIENTCODE,CONTRACTCODE) as PACKAGE
                            , rcbill_my.GetNetworkForClientContract(CLIENTCODE, CONTRACTCODE) as NETWORK
							-- , rcbill_my.GetNetworkForClient(CLIENTCODE) as NETWORK2
							-- CLIENTCODE, CLIENTNAME, CONTRACTCODE, FROM_DATE, TO_DATE, (datediff(TO_DATE,FROM_DATE)+1) as days, count(distinct PROCESSEDCLIENTIP) as INSTANCES
							from rcbill.clientcontractipmonth
							where USAGE_YR=2020 and PROCESSEDCLIENTIP<>'0.0.0.0'
							and TO_DATE<='2020-07-31'
							
                            -- and PROCESSEDCLIENTIP=@ip
                            
							group by PROCESSEDCLIENTIP, 2, 3
						) a 
						group by 1,2,3    
						
				) b
				on binary a.IPADDRESS= binary b.PROCESSEDCLIENTIP

				/*
				and 
				(
					( a.DATESTART<=b.FROM_DATE) and (a.DATEEND>=TO_DATE)
				)
				*/
		) a 
        group by 1, 2 , 3
) a
;

				select a.*,b.*
				-- , rcbill_my.GetNetworkForClientContractDate(b.CLIENTCODE, b.CONTRACTCODE, b.FROM_DATE) as NETWORK_FROM
				-- , rcbill_my.GetNetworkForClientContractDate(b.CLIENTCODE, b.CONTRACTCODE, b.TO_DATE) as NETWORK_TO
				-- , rcbill_my.GetNetworkForClientContract(b.CLIENTCODE, b.CONTRACTCODE) as NETWORK
				from 
				(
					select a.*, b.*
					, ((b.INCOMINGBYTES))/(1024.0*1024.0) as INCOMING_MB
					, ((b.OUTGOINGBYTES))/(1024.0*1024.0) as OUTGOING_MB
					, ((b.TOTALBYTES))/(1024.0*1024.0) as TOTAL_MB

					, ((b.INCOMINGBYTES))/(1024.0*1024.0*1024.0) as INCOMING_GB
					, ((b.OUTGOINGBYTES))/(1024.0*1024.0*1024.0) as OUTGOING_GB
					, ((b.TOTALBYTES))/(1024.0*1024.0*1024.0) as TOTAL_GB

					, ((b.INCOMINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as INCOMING_TB
					, ((b.OUTGOINGBYTES))/(1024.0*1024.0*1024.0*1024.0) as OUTGOING_TB
					, ((b.TOTALBYTES))/(1024.0*1024.0*1024.0*1024.0) as TOTAL_TB

					from 
					rcbill_my.IV_IP_POOL a 
					left join
					rcbill_my.dailyallusage_l7 b 
					on a.IPADDRESS=b.IP

					-- where a.IPADDRESS=@ip
				) a 
				inner join 
				(

					/*
					select PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, CONTRACTCODE
					, rcbill_my.GetNetworkForClientContract(CLIENTCODE, CONTRACTCODE) as NETWORK
					, rcbill_my.GetNetworkForClient(CLIENTCODE) as NETWORK2
					, FROM_DATE, TO_DATE, (datediff(TO_DATE,FROM_DATE)+1) as days, count(distinct PROCESSEDCLIENTIP) as INSTANCES
					from rcbill.clientcontractipmonth
					where USAGE_YR=2020 and PROCESSEDCLIENTIP<>'0.0.0.0'
					and TO_DATE<='2020-07-31'
					-- and PROCESSEDCLIENTIP=@ip
					group by PROCESSEDCLIENTIP, CLIENTCODE, CLIENTNAME, CONTRACTCODE, NETWORK
						, NETWORK2 
						, FROM_DATE, TO_DATE
					*/
						select a.PROCESSEDCLIENTIP, a.NETWORK, upper(a.PACKAGE) as PACKAGE
                        -- , a.NETWORK2, count(distinct a.PROCESSEDCLIENTIP)
						from
						(
							select PROCESSEDCLIENTIP
                            , rcbill_my.GetPackageFromSnapshot(CLIENTCODE,CONTRACTCODE) as PACKAGE
                            , rcbill_my.GetNetworkForClientContract(CLIENTCODE, CONTRACTCODE) as NETWORK
							-- , rcbill_my.GetNetworkForClient(CLIENTCODE) as NETWORK2
							-- CLIENTCODE, CLIENTNAME, CONTRACTCODE, FROM_DATE, TO_DATE, (datediff(TO_DATE,FROM_DATE)+1) as days, count(distinct PROCESSEDCLIENTIP) as INSTANCES
							from rcbill.clientcontractipmonth
							where USAGE_YR=2020 and PROCESSEDCLIENTIP<>'0.0.0.0'
							and TO_DATE<='2020-07-31'
							
                            -- and PROCESSEDCLIENTIP=@ip
                            
							group by PROCESSEDCLIENTIP, 2, 3
						) a 
						group by 1,2,3    
						
				) b
				on binary a.IPADDRESS= binary b.PROCESSEDCLIENTIP

				/*
				and 
				(
					( a.DATESTART<=b.FROM_DATE) and (a.DATEEND>=TO_DATE)
				)
				*/





/*
select a.*,b.*
from 
(
select a.*, b.*
from 
rcbill_my.IV_IP_POOL a 
left join
rcbill_my.dailyallusage_l7 b 
on a.IPADDRESS=b.IP
) a 
left join 
rcbill.clientcontractipmonth b 
on 
binary a.IPADDRESS= binary b.PROCESSEDCLIENTIP
and 
( a.DATESTART<=b.FROM_DATE and a.DATEEND>=b.TO_DATE)
;
*/