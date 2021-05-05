#CLIENT SCRIPT
use rcbill;

#SET DATE
-- SET @REPORTDATE=str_to_date('2018-01-10','%Y-%m-%d');
-- SET @rundate='2018-01-10';
SET @COLNAME1='CLIENTDEBT_REPORTDATE';
#THIS NEEDS TO BE REPLACED BELOW
-- select @REPORTDATE;
-- select @COLNAME1;

#1. CREATE And LOAD data in 7 tables
# TClients, Contracts, CASA, ContractServices, InvoicesHeader, InvoicesContents, Devices


#2. Create ClientContract summary table

		drop table if exists rcbill.clientcontracts;


		CREATE TABLE rcbill.clientcontracts AS (
						SELECT
						CL.ID as CL_CLIENTID
						,CL.FIRM as CL_CLIENTNAME
						,CL.KOD as CL_CLIENTCODE
						,CL.CLTYPE as CL_CLTYPE
						,CL.CLClass as CL_CLCLASS
						,CLC.NAME as CL_CLCLASSNAME

						,CON.ID AS CON_CONTRACTID
						,CON.KOD AS CON_CONTRACTCODE
						,CON.DATA AS CON_CONTRACTDATE
						,CON.CLID AS CON_CLIENTID
						,CON.STARTDATE AS CON_STARTDATE
						,CON.ENDDATE AS CON_ENDDATE
						
						-- added creditpolicyid and ratingplanid on 28/05/2018
						,CON.CREDITPOLICYID as CON_CREDITPOLICYID
						,CON.RATINGPLANID as CON_RATINGPLANID
						-- ,DATEDIFF(CON.ENDDATE,CON.STARTDATE) as CONPERIOD


						,CON.ACTIVE AS CON_ACTIVE
						,CON.CONTRACTTYPE AS CON_CONTRACTTYPE
						,CON.LASTACTIONID as CON_LASTACTIONID
						,CON.PPCard as CON_PPCARD
						,CON.Template as CON_TEMPLATE
						,CON.TempActivateStartDate as CON_TEMPACTIVATESTARTDATE
						,CON.TempActivateEndDate as CON_TEMPACTIVATEENDDATE
						,RD.ContractId as RD_CONTRACTID
						,RDT.name as RDT_DEVICENAME
						,NOW() as INSERTEDON
						-- ,str_to_date('2017-01-19','%Y-%m-%d') as REPORTDATE
						,@REPORTDATE as REPORTDATE

						,CS.serviceid as CS_SERVICEID
						,S.NAME as S_SERVICENAME
						,CS.ServiceRateID as CS_SERVICERATEID
						,CS.Number as CS_SUBSCRIPTIONCOUNT
						,VPNR.Name as VPNR_SERVICETYPE
						,VPNR.Price as VPNR_SERVICEPRICE

						,CASE  
							WHEN CON.LASTACTIONID IN (1,10,11,15,19,2,3,9) THEN 'ACTIVE'
							WHEN CON.LASTACTIONID IN (21,22) and ((@REPORTDATE BETWEEN CON.STARTDATE AND CON.ENDDATE)) THEN 'VALID BUT DEACTIVATED'
							WHEN CON.LASTACTIONID IN (21,22) and ((@REPORTDATE  BETWEEN CON.TempActivateStartDate AND CON.TempActivateEndDate)) THEN 'TEMP ACTIVATED'    
							WHEN CON.LASTACTIONID IN (0,12,13,14,20,30,31,33,34,35,39,5,6,7,8,9,22) and ((@REPORTDATE BETWEEN CON.STARTDATE AND CON.ENDDATE)) THEN 'VALID BUT DEACTIVATED'
						-- 	WHEN CON.LASTACTIONID IN (0,12,13,14,20,30,31,33,34,35,39,5,6,7,8,9,22) THEN 'INACTIVE'
							ELSE 'INACTIVE' END as CONTRACTCURRENTSTATUS

						,CASE 
							WHEN (S.NAME like '%subscription%' and VPNR.NAME not like '%only%') or (S.NAME is null)
							THEN 
								CASE
									WHEN CON.EndDate is not null then DATEDIFF(CON.ENDDATE,CON.STARTDATE)
									WHEN CON.EndDate is null and CS.UpdDate<@REPORTDATE then DATEDIFF(CS.UpdDate,CON.STARTDATE)
									ELSE DATEDIFF(@REPORTDATE,CON.STARTDATE)
								END
							ELSE 0 
							END as CONPERIOD2
						 ,0 as CONPERIOD   
						 from 
						 rcb_tclients CL
						 LEFT JOIN
						rcb_contracts CON 

						ON
						CL.ID=CON.CLID


						LEFT JOIN 
						rcb_contractservices CS
						on
						CON.ID=CS.CID
						
						LEFT JOIN
						rcb_devices RD
						on
						CON.ID=RD.ContractID

						LEFT JOIN
						rcb_devicetypes RDT
						on
						RD.DevTypeID=RDT.ID
						
						LEFT JOIN 
						rcb_clientclasses CLC
						on
						CL.CLClass=CLC.ID

						
						LEFT JOIN
						rcb_services S
						on CS.ServiceID=S.ID

						LEFT JOIN
						rcb_vpnrates VPNR
						on CS.ServiceRateID=VPNR.ID

						WHERE CON.PPCard=0 and CON.Template=0

						order by
						CL_CLIENTNAME,
						CON_CONTRACTCODE,
						CON_STARTDATE
		);

		-- drop index IDXClientContracts on clientcontracts;

		CREATE INDEX IDXClientContracts1
		ON clientcontracts (CL_CLIENTID);
		CREATE INDEX IDXClientContracts2
		ON clientcontracts (CON_CONTRACTID);
		CREATE INDEX IDXClientContracts3
		ON clientcontracts (CL_CLIENTNAME);
		CREATE INDEX IDXClientContracts4
		ON clientcontracts (CL_CLIENTCODE);
		CREATE INDEX IDXClientContracts5
		ON clientcontracts (CON_CONTRACTCODE);
		CREATE INDEX IDXClientContracts6
		ON clientcontracts (S_SERVICENAME);

-- UPDATE THE CONPERIOD2
		SET SQL_SAFE_UPDATES = 0;
		update clientcontracts
		set CONPERIOD=
		case 
			when S_SERVICENAME like '%subscription%' and CONTRACTCURRENTSTATUS='ACTIVE' AND CON_ENDDATE IS NULL THEN datediff(@REPORTDATE,CON_STARTDATE)
			else CONPERIOD2
		end
		;



		-- active subscriptions table
		drop table if exists clientcontractssubs;
		CREATE TABLE clientcontractssubs AS (
			/*
            select distinct cl_clientid, cl_clientname, cl_clientcode, cl_clclassname, CON_CONTRACTCODE, S_SERVICENAME, VPNR_SERVICETYPE, CS_SUBSCRIPTIONCOUNT
			from clientcontracts 
			where 
            -- CL_CLCLASSNAME='CORPORATE LARGE'
			-- and 
            CONTRACTCURRENTSTATUS not in ('INACTIVE')
			and S_SERVICENAME like '%subscription%'
			group by cl_clientid, cl_clientname, cl_clientcode, cl_clclassname, CON_CONTRACTCODE ,S_SERVICENAME, VPNR_SERVICETYPE
			order by cl_clientname, CON_CONTRACTCODE
            */
            
            select distinct cl_clientid, cl_clientname, cl_clientcode, cl_clclassname
            , CON_CONTRACTCODE, S_SERVICENAME, VPNR_SERVICETYPE, CS_SUBSCRIPTIONCOUNT
            , CONTRACTCURRENTSTATUS
			from clientcontracts 
			where 
            -- CL_CLCLASSNAME='CORPORATE LARGE'
			-- and 
            CONTRACTCURRENTSTATUS not in ('INACTIVE')
			and S_SERVICENAME like '%subscription%'
			group by cl_clientid, cl_clientname, cl_clientcode, cl_clclassname, CON_CONTRACTCODE 
            ,S_SERVICENAME, VPNR_SERVICETYPE, CONTRACTCURRENTSTATUS
			order by cl_clientname, CON_CONTRACTCODE
            
        )
        ;

		select count(*) as clientcontractssubs from rcbill.clientcontractssubs;

		drop table if exists clientcontracthistory;


		CREATE TABLE clientcontracthistory AS (
		select distinct(a.cl_clientname) as cl_clientname, 
		a.CL_CLIENTCODE,
		a.CL_CLIENTID, count(*) as TotalServices 
		,count(distinct(a.con_contractid)) as TotalContracts
		, (select count(distinct(b.CON_CONTRACTID)) from clientcontracts b where b.CONTRACTCURRENTSTATUS in ('INACTIVE') and b.CL_CLIENTID in (a.CL_CLIENTID)) as InActiveContracts
        , (select count(distinct(b.CON_CONTRACTID)) from clientcontracts b where b.CONTRACTCURRENTSTATUS not in ('INACTIVE') and b.CL_CLIENTID in (a.CL_CLIENTID)) as ActiveContracts
        , (select COALESCE(sum(CS_SUBSCRIPTIONCOUNT),0) from clientcontractssubs b where b.CL_CLIENTID in (a.CL_CLIENTID)) as ActiveSubscriptions
		, (select count(*) from clientcontracts b where b.CONTRACTCURRENTSTATUS not in ('INACTIVE') and b.CL_CLIENTID in (a.CL_CLIENTID) and b.S_SERVICENAME like '%subscription%') as DevicesCount
		, count(distinct(a.RD_CONTRACTID)) as TotalContractsWithDevices
		, min(a.CON_STARTDATE) as firstcontractdate
		, sum(a.CONPERIOD) as CombinedSubscriptionContractPeriod



		from 
		clientcontracts a

		group by a.CL_CLIENTNAME, a.CL_CLIENTCODE
		order by 9 desc , 1 asc
		)
		;
		CREATE INDEX IDXcch1
		ON clientcontracthistory (cl_clientname);

		CREATE INDEX IDXcch2
		ON clientcontracthistory (CL_CLIENTCODE);

		CREATE INDEX IDXcch3
		ON clientcontracthistory (CL_CLIENTID);

		-- select * from clientcontracthistory order by cl_clientname;
        
        select count(*) as clientcontracthistory from rcbill.clientcontracthistory;
        
        drop table if exists rcbill.casa_stg;
        create table rcbill.casa_stg(index idxcasastg1(clid,cid,enterdate))  -- (index idxcasastg1(clid),index idxcasastg2(cid),index idxcasastg3(enterdate)) 
        (
				select clid, cid, date(enterdate) as enterdate, sum(money) as money
                from rcbill.rcb_casa
                group by 1,2,3
                        
        )
        ;
        
        
        -- select * from rcbill.rcb_casa;
        ### CLIENT CONTRACT PAYMENT INVOICE STAGING TABLE
 		drop table if exists rcbill.clientcontractinvpmt_stg;
        
        create table rcbill.clientcontractinvpmt_stg
        (
			/*
			select a.*
            ,(select sum(ac.money) from rcbill.casa_stg ac where ac.clid=a.clid 
				and ac.cid=a.cid 
				and ac.enterdate=date(a.LastPaymentDate)) as LastPaidAmount
            from
            (
			*/
			   select  
                
				rcbill.GetClientCode( COALESCE(clid, c_clid) ) as CLIENTCODE,
				rcbill.GetContractCode( COALESCE(cid, c_cid)) as CONTRACTCODE,
            
                COALESCE(clid, c_clid) AS clid
				, COALESCE(cid, c_cid) AS cid
				, TotalInvoiceAmount, LastInvoiceAmount, TotalInvoices, FirstInvoiceDate, LastInvoiceDate, c_clid, c_cid, TotalPaymentAmount, TotalPayments, FirstPaymentDate, LastPaymentDate
				from 
				(
					(
						select b.*, c.*
						from 
						(

							select clid, cid, COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
									from rcb_invoicesheader
									where
									-- (hard not in (100, 101, 102) or hard is null)
									(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
									-- and clid=@clientid1
									group by clid, cid
						) b 
						
						left join 
						(
								select clid as c_clid
								 , cid as c_cid
								, COALESCE(sum(money),0) as TotalPaymentAmount  
								-- , sum(money) as LastPaidAmount
								-- , (select sum(ac.money) from rcbill.rcb_casa ac where ac.clid=clid and date(ac.enterdate)=date(max(EnterDate))) as LastPaidAmount  
								, COALESCE(count(*),0) as TotalPayments, date(min(ENTERDATE)) as FirstPaymentDate, date(max(ENTERDATE)) as LastPaymentDate
								from rcb_casa
								where
								-- (hard not in (100, 101, 102) or hard is null)
								(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
								 
								-- and clid=@clientid1
								group by clid, cid
						) c
						on b.clid=c.c_clid and b.cid=c.c_cid
					)
					union 
					(
						select b.*, c.*
						from 
						(

							select clid, cid, COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
									from rcb_invoicesheader
									where
									-- (hard not in (100, 101, 102) or hard is null)
									(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
									-- and clid=@clientid1
									group by clid, cid
						) b 
						
						right join 
						(
								select clid as c_clid
								 , cid as c_cid
								, COALESCE(sum(money),0) as TotalPaymentAmount  
								-- , sum(money) as LastPaidAmount
								-- , (select sum(ac.money) from rcbill.rcb_casa ac where ac.clid=clid and date(ac.enterdate)=date(max(EnterDate))) as LastPaidAmount  
								, COALESCE(count(*),0) as TotalPayments, date(min(ENTERDATE)) as FirstPaymentDate, date(max(ENTERDATE)) as LastPaymentDate
								from rcb_casa
								where
								-- (hard not in (100, 101, 102) or hard is null)
								(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
								 
								-- and clid=@clientid1
								group by clid, cid
						) c
						on b.clid=c.c_clid and b.cid=c.c_cid
					
					
					) 
				) a

			-- ) a 
            
		)
		;
        
		CREATE INDEX IDXccipstg2
		ON rcbill.clientcontractinvpmt_stg (CLIENTCODE);
		CREATE INDEX IDXccipstg3
		ON rcbill.clientcontractinvpmt_stg (clid);
		CREATE INDEX IDXccipstg4
		ON rcbill.clientcontractinvpmt_stg (CONTRACTCODE);
		CREATE INDEX IDXccipstg5
		ON rcbill.clientcontractinvpmt_stg (cid);        
        
        
        
        -- select * from rcbill.clientcontractinvpmt_stg limit 100;
        
        select count(*) as clientcontractinvpmt_stg from rcbill.clientcontractinvpmt_stg;
        
        
		drop table if exists rcbill.clientcontractinvpmt;
		#QUERY Takes 53 minutes
		#now it takes 139 seconds
        #415 seconds
-- 		 SET global innodb_buffer_pool_size=12582912;

		CREATE TABLE rcbill.clientcontractinvpmt AS (
  
  
			SELECT 
				   -- rcbill.GetClientName(a.CLIENTCODE) as cl_clientname,
					a.CLIENTCODE as CL_CLIENTCODE,
					a.clid as CL_CLIENTID, 
					a.CONTRACTCODE as CON_CONTRACTCODE,
					a.cid as CON_CONTRACTID,
					TotalInvoiceAmount, LastInvoiceAmount, TotalInvoices, FirstInvoiceDate, LastInvoiceDate, c_clid, c_cid, TotalPaymentAmount, TotalPayments, FirstPaymentDate, LastPaymentDate
						,(select ac.money from rcbill.casa_stg ac where ac.clid=a.clid 
						and ac.cid=a.cid 
						and ac.enterdate=a.LastPaymentDate) as LastPaidAmount
                
                    /*
                    ,(select sum(ac.money) from rcbill.rcb_casa ac where ac.clid=a.clid 
						and ac.cid=a.cid 
						and date(ac.enterdate)=date(a.LastPaymentDate)) as LastPaidAmount
                        */
     
            FROM 
            rcbill.clientcontractinvpmt_stg a 
            order by 1, 2, 4
			-- order by a.cl_clientname, a.CL_CLIENTCODE, a.CON_CONTRACTCODE
  
        
        /*
		select 
		distinct(a.cl_clientname) as cl_clientname, 
		a.CL_CLIENTCODE,
		a.CL_CLIENTID, 
		a.CON_CONTRACTCODE,
		a.CON_CONTRACTID,
        --  a.CS_SERVICEID,
        
		b.TotalInvoiceAmount,
		b.LastInvoiceAmount,
		b.TotalInvoices,
		b.FirstInvoiceDate,
		b.LastInvoiceDate,
		c.TotalPaymentAmount,
		c.LastPaidAmount,
		c.TotalPayments,
		c.FirstPaymentDate,
		c.LastPaymentDate

		from 
		clientcontracts a
		left join
        -- right join
		(
			select clid, cid, COALESCE(sum(total),0) as TotalInvoiceAmount , COALESCE(max(total),0) as LastInvoiceAmount, COALESCE(count(*),0) as TotalInvoices, min(DATA) as FirstInvoiceDate, max(DATA) as LastInvoiceDate
			from rcb_invoicesheader
			where
			-- (hard not in (100, 101, 102) or hard is null)
			(hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
			group by clid, cid
        ) as b

		on a.CL_CLIENTID=b.clid
		and a.CON_CONTRACTID=b.cid


        
        

       left join 
       -- right join
       (
			select a.*, (select sum(ac.money) from rcbill.rcb_casa ac where ac.clid=a.clid 
            and ac.cid=a.cid 
            and date(ac.enterdate)=date(LastPaymentDate)) as LastPaidAmount
            from 
            (
			select clid
			 , cid
			, COALESCE(sum(money),0) as TotalPaymentAmount  
			-- , sum(money) as LastPaidAmount
			-- , (select sum(ac.money) from rcbill.rcb_casa ac where ac.clid=clid and date(ac.enterdate)=date(max(EnterDate))) as LastPaidAmount  
			, COALESCE(count(*),0) as TotalPayments, date(min(ENTERDATE)) as FirstPaymentDate, date(max(ENTERDATE)) as LastPaymentDate
			from rcb_casa
			where
			-- (hard not in (100, 101, 102) or hard is null)
            (hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
             
			-- and 
			-- clid=@custid
			group by clid, cid
            ) a
        ) as c 
        
		on a.CL_CLIENTID=c.clid
		and a.CON_CONTRACTID=c.cid

		*/

		)
		;
        
        

-- 		 SET global innodb_buffer_pool_size=8388608;

		-- CREATE INDEX IDXccip1
		-- ON rcbill.clientcontractinvpmt (cl_clientname);
		CREATE INDEX IDXccip2
		ON rcbill.clientcontractinvpmt (CL_CLIENTCODE);
		CREATE INDEX IDXccip3
		ON rcbill.clientcontractinvpmt (CL_CLIENTID);
		CREATE INDEX IDXccip4
		ON rcbill.clientcontractinvpmt (CON_CONTRACTCODE);
		CREATE INDEX IDXccip5
		ON rcbill.clientcontractinvpmt (CON_CONTRACTID);


		select count(*) as clientcontractinvpmt from rcbill.clientcontractinvpmt;


#3. Create ClientReport table
		-- select * from clientcontracts where cl_clientcode='I.000011750';
        -- select * from clientcontracthistory where cl_clientcode='I.000011750';
        -- select * from clientcontractinvpmt where cl_clientcode='I.000011750';

		#for file clientreport-ddmmyyyy-n.csv
		DROP TABLE IF EXISTS clientreport;
		create table clientreport as (
        select a.*
  				,(select sum(cciv.LastPaidAmount) from clientcontractinvpmt cciv where cciv.CL_CLIENTID=a.CL_CLIENTID and date(cciv.LastPaymentDate)=date(a.LastPaymentDate)) as LastPaidAmount
			from
            (

				select a.*, (select distinct(b.CL_CLCLASSNAME) from clientcontracts b where b.CL_CLIENTID=a.CL_CLIENTID and b.cl_clientname=a.cl_clientname ) as ClassName,
				-- a.cl_clientname,a.CL_CLIENTCODE, a.CL_CLIENTID,
				COALESCE(sum(b.TotalInvoices),0) as TotalInvoices, COALESCE(sum(b.TotalInvoiceAmount),0) as TotalInvoiceAmount, 
				-- max(b.LastInvoiceAmount) as LastInvoiceAmount, 
				min(b.FirstInvoiceDate) as FirstInvoiceDate, max(b.LastInvoiceDate) as LastInvoiceDate,
				COALESCE(sum(b.TotalPayments),0) as TotalPayments, COALESCE(sum(b.TotalPaymentAmount),0) as TotalPaymentAmount 
				-- max(b.LastPaidAmount) as LastPaidAmount, 
				, min(b.FirstPaymentDate) as FirstPaymentDate, max(b.LastPaymentDate) as LastPaymentDate,
				-- str_to_date('2017-01-19','%Y-%m-%d') as REPORTDATE,
				@REPORTDATE as REPORTDATE,
				COALESCE((sum(b.TotalInvoiceAmount)-sum(b.TotalPaymentAmount)),0) as CLIENTDEBT_REPORTDATE

				from
				clientcontracthistory a
				left join 
				clientcontractinvpmt b
				on
				a.CL_CLIENTID=b.CL_CLIENTID

				group by a.cl_clientname,a.CL_CLIENTCODE, a.CL_CLIENTID
				-- , c.CL_CLCLASSNAME

				order by 
				a.cl_clientname
			) a
		)
		;

		#Final Report Table
		-- select * from clientreport;
        select count(*) as clientreport from clientreport;
        
        
        #Extended Report Table
		DROP TABLE IF EXISTS clientextendedreport;
		create table clientextendedreport (INDEX idxcer1 (CL_CLIENTCODE), INDEX idxcer2 (CL_CLIENTNAME), INDEX idxcer3 (CL_NIN)) as (
        select a.*, 
        b.KOD as CL_KOD,
        b.FIRM as CL_FIRM,
		b.danno as CL_NIN,
		b.PASSNo as CL_PassNo,
		b.MPHONE as CL_MPhone,
		b.MEMAIL as CL_MEMAIL,
		b.MOLADDRESS as CL_MOLADDRESS
        , c.clientaddress, c.cl_location, c.cl_area, c.cl_subdistrict
		-- , d.areaname as cl_areaname, d.latitude as cl_latitude, d.longitude as cl_longitude
        , d.clientparcel, d.coord_x, d.coord_y, d.latitude, d.longitude
        from
        clientreport a 
        inner join
        -- right join
        rcb_tclients b
        on
        a.CL_CLIENTCODE=b.KOD
        
        left join 
		(
					SELECT clientcode, clientaddress, min(clientlocation) as cl_location, min(ClientArea) as cl_area, min(clientsubdistrict) as cl_subdistrict
					FROM    rcbill.rcb_clientaddress
					GROUP BY clientcode
					order by clientcode
		) c
		on
		a.CL_CLIENTCODE=c.clientcode
        
        left join
		
        /*

		(
				select distinct x.settlementname, x.areaname, y.latitude, y.longitude,
				y.geoname, y.featureclass,y.featurecode
				from 
				rcbill.rcb_address x 
				left join
				rcbill.geoname_sc y
				on
				x.settlementname=y.geoname
				and 
				(y.featureclass in ('A') or y.featurecode in ('ISL','PPL','PPLC'))
				where
				x.AREANAME not in ('SEYCHELLES','SANS SOUCI ROAD','M')
				group by x.settlementname, x.areaname
				order by x.SETTLEMENTNAME
		) d
		on (c.cl_location=d.settlementname and c.cl_area=d.areaname)
        */
        
        (
			select * from rcbill.rcb_clientparcelcoords where latitude<>0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))
        ) d
        on a.CL_CLIENTCODE=d.clientcode
        
        )
        ;

		-- select * from rcbill.clientextendedreport;
        select count(*) as clientextendedreport from rcbill.clientextendedreport;
        
        drop table if exists rcbill_my.rep_allcust;
        create table rcbill_my.rep_allcust (index `idxrac1`(clientcode) ) as 
        (
			/*
			select 
			REPORTDATE as reportdate, CLIENTDEBT_REPORTDATE as currentdebt, CL_CLIENTCODE as clientcode, cl_clientname as clientname
			, ActiveContracts as activecontracts, ActiveSubscriptions as activesubscriptions, firstcontractdate, FirstInvoiceDate as firstinvoicedate, LastInvoiceDate as lastinvoicedate
			, FirstPaymentDate as firstpaymentdate, LastPaymentDate as lastpaymentdate, TotalPayments as totalpayments, TotalPaymentAmount as totalpaymentamount
			, ClassName as clientclass, CL_NIN as clientnin, CL_PassNo as clientpassport, CL_MPhone as clientphone, CL_MEMAIL as clientemail
			, clientaddress as clientaddress, cl_location as clientlocation, cl_area as clientarea 
			from rcbill.clientextendedreport
			*/
			select a.*
			, 
			case 
			when @REPORTDATE=a.lastactivedate then 'Active' 
			else 'InActive'
			end as `IsAccountActive` 
			,
			case 
			when a.dayssincelastactive=0 then '1. Alive' 
			when a.dayssincelastactive>0 and a.dayssincelastactive<=7 then '2. Snoozing (1 to 7 days)'
			when a.dayssincelastactive>7 and a.dayssincelastactive<=30 then '3. Asleep (8 to 30 days)'
			when a.dayssincelastactive>30 and a.dayssincelastactive<=90 then '4. Hibernating (31 to 90 days)'
			when a.dayssincelastactive>90 then '5. Dormant (more than 90 days)'
            when a.dayssincelastactive is null then '5. Dormant (more than 90 days)'
        
			end as `AccountActivityStage` 
			from 
			(            
					select a.*, b.firstactivedate, b.lastactivedate, datediff(@REPORTDATE,b.lastactivedate) as dayssincelastactive
					from 
					(
						select 
							REPORTDATE as reportdate, CLIENTDEBT_REPORTDATE as currentdebt, CL_CLIENTCODE as clientcode, cl_clientname as clientname
							, ActiveContracts as activecontracts, ActiveSubscriptions as activesubscriptions, firstcontractdate, FirstInvoiceDate as firstinvoicedate, LastInvoiceDate as lastinvoicedate
							, FirstPaymentDate as firstpaymentdate, LastPaymentDate as lastpaymentdate, LastPaidAmount as lastpaidamount, TotalPayments as totalpayments, TotalPaymentAmount as totalpaymentamount
							, ClassName as clientclass, CL_NIN as clientnin, CL_PassNo as clientpassport, CL_MPhone as clientphone, CL_MEMAIL as clientemail
							, clientaddress as clientaddress, cl_location as clientlocation, cl_area as clientarea
                            , cl_subdistrict as subdistrict 
                            , clientparcel, coord_x, coord_y, latitude, longitude
							
						from rcbill.clientextendedreport
					) a
					left join
					(
							select clientcode, min(period) as firstactivedate, max(period) as lastactivedate
							from 
							rcbill_my.customercontractactivity 
							group by clientcode
					) b
					on a.clientcode=b.clientcode
			) a 
        );
        
        select count(*) as allcust from rcbill_my.rep_allcust;
        -- select * from rcbill_my.rep_allcust;
		#Extended ClientContracts table
        /*
		select a.*, 
		b.danno as CL_NIN,
		b.PASSNo as CL_PassNo,
		b.MPHONE as CL_MPhone,
		b.MEMAIL as CL_MEMAIL,
		b.MOLADDRESS as CL_MOLADDRESS
        from
        clientcontracts a 
        inner join
        rcb_tclients b
        on
        a.CL_CLIENTCODE=b.KOD
        ;        
        */

#4. CREATE TOP 1000 RESIDENTIAL ACTIVE and INACTIVE CUSTOMERS

		#Temp table for top active clients 

		DROP TABLE IF EXISTS temptopactiveclients;
		create temporary table temptopactiveclients as
		(
		select * from clientreport 
		where 
		ClassName in ('RESIDENTIAL')
		and 
		ActiveContracts > 0
		order by 
		TotalPaymentAmount desc
		limit 5000
		)
		;

		DROP TABLE IF EXISTS loyaltylist5000;
        
        create table loyaltylist5000 as
        (
		select a.*,b.KOD,b.BULSTAT,b.DANNO,b.PASSNo,b.MPHONE,b.MEMAIL,b.MOLADDRESS,b.MOL 
		,c.firm as Dup_ClientName,
		c.kod as Dup_ClientCode,
		c.danno as Dup_NIN,
		c.PASSNo as Dup_PassNo,
		c.MPHONE as Dup_MPhone,
		c.MEMAIL as DUP_MEMAIL,
		c.MOLADDRESS as DUP_MOLADDRESS
		/*
		,
		c.KOD as ContractCode,
		c.StartDate,
		c.EndDate
		*/
		from 
		temptopactiveclients a 
		inner join
		rcb_tclients b
		on
		a.cl_clientid=b.id

		left join
		rcb_tclients c
		on
		a.cl_clientname=c.firm
        )
		;

		-- select * from loyaltylist5000;
		
        /*
		select cl_clientname, cl_clientcode from 
		clientreport
		where
		cl_clientname in (select cl_clientname from temptopactiveclients)
		;
		*/

		#Temp table for top inactive clients 

		DROP TABLE IF EXISTS temptopinactiveclients;
		create temporary table temptopinactiveclients as
		(
		select a.* from 
		(
		select * from clientreport 
		where 
		ClassName in ('RESIDENTIAL')
		and 
		ActiveContracts = 0
		order by 
		TotalPaymentAmount desc
		limit 5000
		) a

		order by a.lastpaymentdate desc
		)
		;

/*
#inactive clients matched on NIN
		select a.*,b.KOD,b.BULSTAT,b.DANNO,b.PASSNo,b.MPHONE,b.MEMAIL,b.MOLADDRESS,b.MOL
		,c.firm as Dup_ClientName,
		c.kod as Dup_ClientCode,
		c.danno as Dup_NIN,
		c.PASSNo as Dup_PassNo,
		c.MPHONE as Dup_MPhone,
		c.MEMAIL as DUP_MEMAIL,
		c.MOLADDRESS as DUP_MOLADDRESS

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


*/




		DROP TABLE IF EXISTS retentionlist5000;
        
        create table retentionlist5000 as
        (
		select a.*,b.KOD,b.BULSTAT,b.DANNO,b.PASSNo,b.MPHONE,b.MEMAIL,b.MOLADDRESS,b.MOL
		,c.firm as Dup_ClientName,
		c.kod as Dup_ClientCode,
		c.danno as Dup_NIN,
		c.PASSNo as Dup_PassNo,
		c.MPHONE as Dup_MPhone,
		c.MEMAIL as DUP_MEMAIL,
		c.MOLADDRESS as DUP_MOLADDRESS


		from 
		temptopinactiveclients a 
		inner join
		rcb_tclients b
		on
		a.cl_clientid=b.id

		left join
		rcb_tclients c
		on
		a.cl_clientname=c.firm

		order by
		a.lastpaymentdate
        )
		;

		-- select * from retentionlist5000;
        
        /*
        select * from clientextendedreport;
        select * from clientcontractssubs;
        
        select * from temptopinactiveclients;
        
		select cl_clientname, cl_clientcode from 
		clientreport
		where
		cl_clientname in (select cl_clientname from temptopinactiveclients)
		;
        
        select * from clientcontractinvpmt where cl_clientcode='I.000009178';
        select * from clientcontracts where cl_clientcode='I.000003606' and vpnr_serviceprice>0;
        
        select * from clientextendedreport limit 5000;
        */
        
        
        -- select classname, count(*) as activeclients, sum(activecontracts) as activecontracts , sum(ActiveSubscriptions) as ActiveSubscriptions from clientextendedreport where activecontracts>0 group by classname;
        
        /*
        select * from clientextendedreport where classname is null and activecontracts>0;
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
*/
		#################################################################################################