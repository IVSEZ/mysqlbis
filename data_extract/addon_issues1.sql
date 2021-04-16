select * from rcbill_extract.IV_SERVICEACCOUNT where ACTIVESERVICE is null;


select * from rcbill.rcb_users;

select * from rcbill_extract.IV_SERVICEACCOUNT;

select * from rcbill_extract.IV_ADDON where SUBFROM > SUBTO;

select * from rcbill_extract.IV_SERVICEINSTANCE where SUBFROM > SUBTO;

select * from rcbill.rcb_casa where BegDate>enddate;

select *, datediff(SUBTO,SUBFROM) from rcbill_extract.IV_SERVICEINSTANCE where SUBFROM > SUBTO;



select * from rcbill.rcb_casa where year(begdate)=3001;


select * from rcbill.rcb_invoicesheader  where year(begdate)=3001 limit 1000;


set @clcode='I20535';
set @clid = rcbill.GetClientID(@clcode);

select * from rcbill_extract.IV_SERVICEINSTANCE where clientcode=@clcode;
select * from rcbill_extract.IV_SERVICEINSTANCE where clientcode=@clcode and SUBFROM > SUBTO;


select * from rcbill.rcb_casa where CLID in (@clid) order by clid, cid, rsid;


							SELECT  CLID, CID, RSID, max(ID) as MAX_ID 
							FROM    rcbill.rcb_casa
                            where clid in (@clid)
							-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
							-- where CLID in (718650) 
							
								-- and b.client_id=718650
								-- and b.CLIENT_ID=715432
								-- and b.CLIENT_ID=723711
							GROUP BY CLID, CID, RSID
                            ;


				SELECT  a.CLID, a.CID, a.RSID, a.BEGDATE as LASTSUBSTARTDATE, a.ENDDATE as LASTSUBENDDATE, a.PAYDATE as LASTSUBPAYDATE
				-- , (select begdate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) limit 1) as CURSUBSTARTDATE
				-- , (select enddate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) limit 1) as CURSUBENDDATE
				-- , (select paydate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) limit 1) as CURSUBPAYDATE
				FROM    rcbill.rcb_casa a
						INNER JOIN
						(
							SELECT  CLID, CID, RSID, max(ID) as MAX_ID 
							FROM    rcbill.rcb_casa
                            where clid in (@clid)
							-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
							-- where CLID in (718650) 
							
								-- and b.client_id=718650
								-- and b.CLIENT_ID=715432
								-- and b.CLIENT_ID=723711
							GROUP BY CLID, CID, RSID
							-- limit 10000
						) b ON -- a.ID = b.ID AND 
						a.ID = b.max_ID  
                        ;


		select a.*, b.begdate as CURSUBSTARTDATE, b.enddate as CURSUBENDDATE, b.paydate as CURSUBPAYDATE 
		from 
		(

				SELECT  a.CLID, a.CID, a.RSID, a.BEGDATE as LASTSUBSTARTDATE, a.ENDDATE as LASTSUBENDDATE, a.PAYDATE as LASTSUBPAYDATE
				-- , (select begdate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) limit 1) as CURSUBSTARTDATE
				-- , (select enddate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) limit 1) as CURSUBENDDATE
				-- , (select paydate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) limit 1) as CURSUBPAYDATE
				FROM    rcbill.rcb_casa a
						INNER JOIN
						(
							SELECT  CLID, CID, RSID, max(ID) as MAX_ID 
							FROM    rcbill.rcb_casa
                            where clid in (@clid)
							-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
							-- where CLID in (718650) 
							
								-- and b.client_id=718650
								-- and b.CLIENT_ID=715432
								-- and b.CLIENT_ID=723711
							GROUP BY CLID, CID, RSID
							-- limit 10000
						) b ON -- a.ID = b.ID AND 
						a.ID = b.max_ID  


		) a 
		left join 
		(
		-- rcbill.rcb_casa 
							SELECT  CLID, CID, RSID, count(*) as cnt, BEGDATE, ENDDATE, PAYDATE 
							FROM    rcbill.rcb_casa
                            

							-- where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
							-- where CLID in (718650) 
							
								-- and b.client_id=718650
								-- and b.CLIENT_ID=715432
								-- and b.CLIENT_ID=723711
							where 0=0
                            
                            and clid in (@clid)
                            
                            and BegDate<=date(now()) and EndDate>=date(now())
							GROUP BY CLID, CID, RSID

		) b
		on a.clid=b.clid and a.cid=b.cid and a.rsid=b.rsid -- and b.begdate<=date(now()) and b.enddate>=date(now())

		-- where a.clid=rcbill.GetClientID(@clcode)
        ;


select * from rcbill_extract.CLIENTCONTRACTLASTSUBDATE where clid in (@clid);

select * from rcbill_extract.CLIENTCONTRACTLASTINVDATE where clid in (@clid);


					select 
					-- a.*
					-- , b.*



					a.CustomerAccountNumber as CUSTOMERACCOUNTNUMBER
					, a.BillingAccountNumber as BILLINGACCOUNTNUMBER
					, a.ServiceAccountNumber as SERVICEACCOUNTNUMBER
					, a.SERVICEINSTANCEIDENTIFIER as SERVICEINSTANCEIDENTIFIER
					, a.SERVICEINSTANCENUMBER2 as SERVICEINSTANCENUMBER
					, a.PackageName as PACKAGENAME
					, a.ServiceStatus as SERVICESTATUS
					, a.username as USERNAME
					, a.CREATEDDATE
					, a.ACTIVATIONDATE
					, a.STATUSCHANGEDDATE
					, a.LASTACTION
					, a.PACKAGEAMOUNT
					, a.CPE_TYPE
					, a.CPE_ID
					, a.CONTRACTSTARTDATE
					, a.CONTRACTENDDATE
					, a.SERVICEREMARKS
					, a.EXPIRYDATE
					, a.OVERRIDDEN
					, a.FSAN
					, a.ServiceID
					, a.ServiceRateID
					-- , a.CONTRACTVALIDITYPERIOD
					, a.SERVICESTARTDATE
					, a.SERVICEENDDATE
					, a.clientcode
					, a.contractcode
					, a.serviceinstancestatus	

					, a.CLIENT_ID
					, a.CONTRACT_ID
					
					, a.DEVICE_ID, a.DEVICE_TYPE_ID, a.DEVICE_NAME, a.GATEKEEPER_ID, a.GATEKEEPER_NAME
					-- , (select ips.CUSTOMERACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as CUSTOMERACCOUNTNUMBER
					-- , (select ips.BILLINGACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as BILLINGACCOUNTNUMBER
					-- , (select ips.SERVICEACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as SERVICEACCOUNTNUMBER
					-- , (select ips.currentstatus from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as SERVICESTATUS

					, b.LASTSUBSTARTDATE
					, b.LASTSUBENDDATE
					, b.LASTSUBPAYDATE
					, c.LASTINVFROMDATE
					, c.LASTINVTODATE

					, b.CURSUBSTARTDATE
					, b.CURSUBENDDATE
					, b.CURSUBPAYDATE    
					, c.CURINVFROMDATE
					, c.CURINVTODATE
					
					, if(ifnull(date(b.LASTSUBSTARTDATE),date(c.LASTINVFROMDATE))>b.CURSUBSTARTDATE,b.CURSUBSTARTDATE,ifnull(date(b.LASTSUBSTARTDATE),date(c.LASTINVFROMDATE))) as SUBFROMSTAGING
					, if(ifnull(date(b.LASTSUBENDDATE),date(c.LASTINVTODATE))>b.CURSUBENDDATE,b.CURSUBENDDATE,ifnull(date(b.LASTSUBENDDATE),date(c.LASTINVTODATE))) as SUBTOSTAGING
					
					from 
					(

							SELECT
							 (@cnt := @cnt + 1) AS rowNumber,
							
							  ips1.CustomerAccountNumber as CUSTOMERACCOUNTNUMBER
							, ips1.BillingAccountNumber as BILLINGACCOUNTNUMBER
							, ips1.ServiceAccountNumber as SERVICEACCOUNTNUMBER
							, ips1.clientcode
							, ips1.contractcode 
							, ips1.package as PACKAGENAME
							, ips1.serviceinstancenumber as SERVICEINSTANCENUMBER
							, cast(concat('SIN_',ips1.serviceinstancenumber,'_',@cnt) as char(255)) as SERVICEINSTANCENUMBER2
							, cast(concat('SII_',ips1.contractcode) as char(255)) as SERVICEINSTANCEIDENTIFIER
							, ips1.CurrentStatus as SERVICESTATUS
							, case when ips1.servicestatus = 0 then 'Not Active'
								else 'Active' end as SERVICEINSTANCESTATUS

							/*
							, case when ips1.username is null then ips1.UID
								when length(ips1.username)=0 then ips1.UID
								when service_type in ('VOICE','GVOICE') then ips1.UID
								else ips1.username end as USERNAME
							*/
							, case when ips1.UID is null then ips1.USERNAME
								when service_type in ('VOICE','GVOICE') then ips1.UID
								when length(ips1.UID)=0 then ips1.USERNAME
								else ips1.UID end as USERNAME
                            
							-- , ifnull(c.username,c.phoneno) as USERNAME
							, ips1.contractstartdate AS CREATEDDATE
							, ips1.servicestartdate as ACTIVATIONDATE
							, ips1.StatusChangedDate as STATUSCHANGEDDATE
							-- , a.LastActionID as LastActionID
							, ips1.LASTACTION as LASTACTION
							, ips1.price as PACKAGEAMOUNT
							-- , '' as CPE_TYPE
							, ips1.service as CPE_TYPE
							, case when service_type in ('VOICE','GVOICE') then ips1.username
								else ips1.MAC end as CPE_ID
							, ips1.contractstartdate as CONTRACTSTARTDATE
							, ips1.contractenddate as CONTRACTENDDATE
							, '' as SERVICEREMARKS
							, '' as EXPIRYDATE
							, 'Y' as OVERRIDDEN
							-- , c.phoneno as PHONENO
							, ips1.FSAN as FSAN

							, ips1.serviceid as ServiceID
							, ips1.servicerateid as ServiceRateID
							, ips1.CLIENT_ID as CLIENT_ID
							, ips1.CONTRACT_ID as CONTRACT_ID
							
							, ips1.DEVICE_ID, ips1.DEVICE_TYPE_ID, ips1.DEVICE_NAME, ips1.GATEKEEPER_ID, ips1.GATEKEEPER_NAME

							/*
							, (select UserName from rcbill.rcb_devices where CSID=b.ID order by UserName asc limit 1) as USERNAME
							, (select PhoneNo from rcbill.rcb_devices where CSID=b.ID order by PhoneNo asc limit 1) as CPEID_PHONE
							, (select NATIP from rcbill.rcb_devices where CSID=b.ID  order by NATIP asc limit 1) as CPEID_NATIP
							, (select MAC from rcbill.rcb_devices where CSID=b.ID  order by MAC asc limit 1) as CPEID_MAC
							, (select SerNo from rcbill.rcb_devices where CSID=b.ID  order by SerNo asc limit 1) as CPEID_SERNO
							*/


							-- , a.DATA as CONTRACTDATE

							-- , a.ValidityPeriod AS CONTRACTVALIDITYPERIOD
							, ips1.servicestartdate as SERVICESTARTDATE
							, ips1.serviceenddate as SERVICEENDDATE
							from 
							rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips1

							CROSS JOIN (SELECT @cnt := 0, @curType := '') AS dummy


							-- where ips1.clientcode in  ('I.000015739')
                            where ips1.CLIENT_ID in  (@clid)
							-- (select id from rcbill.rcb_tclients where kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR'))
							-- ('I.000011750') -- ,'I.000011750')) -- ('I.000009787','I.000011750','I.000018187'))
							-- ('I.000021409')

							ORDER BY ips1.clientcode desc
					) a 
					
					left join 
					rcbill_extract.CLIENTCONTRACTLASTSUBDATE b 
					on a.CLIENT_ID=b.CLID and a.CONTRACT_ID=b.CID and a.ServiceRateID=b.RSID
					
					left join 
					rcbill_extract.CLIENTCONTRACTLASTINVDATE c 
					on a.CLIENT_ID=c.CLID and a.CONTRACT_ID=c.CID and a.ServiceRateID=c.RSID
                    
                    
                    
                    ;
                    
                    
                    
		select a.*

		, case when a.SUBFROMSTAGING is null then ifnull(date(a.SERVICESTARTDATE),date(a.CONTRACTSTARTDATE)) else a.SUBFROMSTAGING end as SUBFROM
		, case when a.SUBTOSTAGING is null then ifnull(date(a.SERVICEENDDATE),date(a.CONTRACTENDDATE)) else a.SUBTOSTAGING end as SUBTO

		from 
		(



					select 
					-- a.*
					-- , b.*



					a.CustomerAccountNumber as CUSTOMERACCOUNTNUMBER
					, a.BillingAccountNumber as BILLINGACCOUNTNUMBER
					, a.ServiceAccountNumber as SERVICEACCOUNTNUMBER
					, a.SERVICEINSTANCEIDENTIFIER as SERVICEINSTANCEIDENTIFIER
					, a.SERVICEINSTANCENUMBER2 as SERVICEINSTANCENUMBER
					, a.PackageName as PACKAGENAME
					, a.ServiceStatus as SERVICESTATUS
					, a.username as USERNAME
					, a.CREATEDDATE
					, a.ACTIVATIONDATE
					, a.STATUSCHANGEDDATE
					, a.LASTACTION
					, a.PACKAGEAMOUNT
					, a.CPE_TYPE
					, a.CPE_ID
					, a.CONTRACTSTARTDATE
					, a.CONTRACTENDDATE
					, a.SERVICEREMARKS
					, a.EXPIRYDATE
					, a.OVERRIDDEN
					, a.FSAN
					, a.ServiceID
					, a.ServiceRateID
					-- , a.CONTRACTVALIDITYPERIOD
					, a.SERVICESTARTDATE
					, a.SERVICEENDDATE
					, a.clientcode
					, a.contractcode
					, a.serviceinstancestatus	

					, a.CLIENT_ID
					, a.CONTRACT_ID
					
					, a.DEVICE_ID, a.DEVICE_TYPE_ID, a.DEVICE_NAME, a.GATEKEEPER_ID, a.GATEKEEPER_NAME
					-- , (select ips.CUSTOMERACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as CUSTOMERACCOUNTNUMBER
					-- , (select ips.BILLINGACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as BILLINGACCOUNTNUMBER
					-- , (select ips.SERVICEACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as SERVICEACCOUNTNUMBER
					-- , (select ips.currentstatus from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as SERVICESTATUS

					, b.LASTSUBSTARTDATE
					, b.LASTSUBENDDATE
					, b.LASTSUBPAYDATE
					, c.LASTINVFROMDATE
					, c.LASTINVTODATE

					, b.CURSUBSTARTDATE
					, b.CURSUBENDDATE
					, b.CURSUBPAYDATE    
					, c.CURINVFROMDATE
					, c.CURINVTODATE
					
					, if(ifnull(date(b.LASTSUBSTARTDATE),date(c.LASTINVFROMDATE))>b.CURSUBSTARTDATE,b.CURSUBSTARTDATE,ifnull(date(b.LASTSUBSTARTDATE),date(c.LASTINVFROMDATE))) as SUBFROMSTAGING
					, if(ifnull(date(b.LASTSUBENDDATE),date(c.LASTINVTODATE))>b.CURSUBENDDATE,b.CURSUBENDDATE,ifnull(date(b.LASTSUBENDDATE),date(c.LASTINVTODATE))) as SUBTOSTAGING
					
					from 
					(

							SELECT
							 (@cnt := @cnt + 1) AS rowNumber,
							
							  ips1.CustomerAccountNumber as CUSTOMERACCOUNTNUMBER
							, ips1.BillingAccountNumber as BILLINGACCOUNTNUMBER
							, ips1.ServiceAccountNumber as SERVICEACCOUNTNUMBER
							, ips1.clientcode
							, ips1.contractcode 
							, ips1.package as PACKAGENAME
							, ips1.serviceinstancenumber as SERVICEINSTANCENUMBER
							, cast(concat('SIN_',ips1.serviceinstancenumber,'_',@cnt) as char(255)) as SERVICEINSTANCENUMBER2
							, cast(concat('SII_',ips1.contractcode) as char(255)) as SERVICEINSTANCEIDENTIFIER
							, ips1.CurrentStatus as SERVICESTATUS
							, case when ips1.servicestatus = 0 then 'Not Active'
								else 'Active' end as SERVICEINSTANCESTATUS

							/*
							, case when ips1.username is null then ips1.UID
								when length(ips1.username)=0 then ips1.UID
								when service_type in ('VOICE','GVOICE') then ips1.UID
								else ips1.username end as USERNAME
							*/
							, case when ips1.UID is null then ips1.USERNAME
								when service_type in ('VOICE','GVOICE') then ips1.UID
								when length(ips1.UID)=0 then ips1.USERNAME
								else ips1.UID end as USERNAME
                            
							-- , ifnull(c.username,c.phoneno) as USERNAME
							, ips1.contractstartdate AS CREATEDDATE
							, ips1.servicestartdate as ACTIVATIONDATE
							, ips1.StatusChangedDate as STATUSCHANGEDDATE
							-- , a.LastActionID as LastActionID
							, ips1.LASTACTION as LASTACTION
							, ips1.price as PACKAGEAMOUNT
							-- , '' as CPE_TYPE
							, ips1.service as CPE_TYPE
							, case when service_type in ('VOICE','GVOICE') then ips1.username
								else ips1.MAC end as CPE_ID
							, ips1.contractstartdate as CONTRACTSTARTDATE
							, ips1.contractenddate as CONTRACTENDDATE
							, '' as SERVICEREMARKS
							, '' as EXPIRYDATE
							, 'Y' as OVERRIDDEN
							-- , c.phoneno as PHONENO
							, ips1.FSAN as FSAN

							, ips1.serviceid as ServiceID
							, ips1.servicerateid as ServiceRateID
							, ips1.CLIENT_ID as CLIENT_ID
							, ips1.CONTRACT_ID as CONTRACT_ID
							
							, ips1.DEVICE_ID, ips1.DEVICE_TYPE_ID, ips1.DEVICE_NAME, ips1.GATEKEEPER_ID, ips1.GATEKEEPER_NAME

							/*
							, (select UserName from rcbill.rcb_devices where CSID=b.ID order by UserName asc limit 1) as USERNAME
							, (select PhoneNo from rcbill.rcb_devices where CSID=b.ID order by PhoneNo asc limit 1) as CPEID_PHONE
							, (select NATIP from rcbill.rcb_devices where CSID=b.ID  order by NATIP asc limit 1) as CPEID_NATIP
							, (select MAC from rcbill.rcb_devices where CSID=b.ID  order by MAC asc limit 1) as CPEID_MAC
							, (select SerNo from rcbill.rcb_devices where CSID=b.ID  order by SerNo asc limit 1) as CPEID_SERNO
							*/


							-- , a.DATA as CONTRACTDATE

							-- , a.ValidityPeriod AS CONTRACTVALIDITYPERIOD
							, ips1.servicestartdate as SERVICESTARTDATE
							, ips1.serviceenddate as SERVICEENDDATE
							from 
							rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips1

							CROSS JOIN (SELECT @cnt := 0, @curType := '') AS dummy


							-- where ips1.clientcode in  ('I.000015739')
                            where ips1.CLIENT_ID in  (@clid)
							-- (select id from rcbill.rcb_tclients where kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR'))
							-- ('I.000011750') -- ,'I.000011750')) -- ('I.000009787','I.000011750','I.000018187'))
							-- ('I.000021409')

							ORDER BY ips1.clientcode desc
					) a 
					
					left join 
					rcbill_extract.CLIENTCONTRACTLASTSUBDATE b 
					on a.CLIENT_ID=b.CLID and a.CONTRACT_ID=b.CID and a.ServiceRateID=b.RSID
					
					left join 
					rcbill_extract.CLIENTCONTRACTLASTINVDATE c 
					on a.CLIENT_ID=c.CLID and a.CONTRACT_ID=c.CID and a.ServiceRateID=c.RSID
		) a                    
                    
           ;         
-- 					, if(ifnull(date(b.LASTSUBSTARTDATE),date(c.LASTINVFROMDATE))>b.CURSUBSTARTDATE,b.CURSUBSTARTDATE,ifnull(date(b.LASTSUBSTARTDATE),date(c.LASTINVFROMDATE))) as SUBFROMSTAGING
-- 					, if(ifnull(date(b.LASTSUBENDDATE),date(c.LASTINVTODATE))>b.CURSUBENDDATE,b.CURSUBENDDATE,ifnull(date(b.LASTSUBENDDATE),date(c.LASTINVTODATE))) as SUBTOSTAGING


	select a.*

			, round(( TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO) +
			  DATEDIFF(
				a.SUBTO,
				a.SUBFROM + INTERVAL
				  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO)
				MONTH
			  ) /
			  DATEDIFF(
				a.SUBFROM + INTERVAL
				  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO) + 1
				MONTH,
				a.SUBFROM + INTERVAL
				  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO)
				MONTH
			  ) ) ,0) as SUBPERIOD  
			
         , (select BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (select parentaccountnumber from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (a.CUSTOMERACCOUNTNUMBER))) as PARENTBILLINGACCOUNTNUMBER



	from 
	(

		select a.*

		, case when a.SUBFROMSTAGING is null then ifnull(date(a.SERVICESTARTDATE),date(a.CONTRACTSTARTDATE)) else a.SUBFROMSTAGING end as SUBFROM
		, case when a.SUBTOSTAGING is null then ifnull(date(a.SERVICEENDDATE),date(a.CONTRACTENDDATE)) else a.SUBTOSTAGING end as SUBTO

		from 
		(



					select 
					-- a.*
					-- , b.*



					a.CustomerAccountNumber as CUSTOMERACCOUNTNUMBER
					, a.BillingAccountNumber as BILLINGACCOUNTNUMBER
					, a.ServiceAccountNumber as SERVICEACCOUNTNUMBER
					, a.SERVICEINSTANCEIDENTIFIER as SERVICEINSTANCEIDENTIFIER
					, a.SERVICEINSTANCENUMBER2 as SERVICEINSTANCENUMBER
					, a.PackageName as PACKAGENAME
					, a.ServiceStatus as SERVICESTATUS
					, a.username as USERNAME
					, a.CREATEDDATE
					, a.ACTIVATIONDATE
					, a.STATUSCHANGEDDATE
					, a.LASTACTION
					, a.PACKAGEAMOUNT
					, a.CPE_TYPE
					, a.CPE_ID
					, a.CONTRACTSTARTDATE
					, a.CONTRACTENDDATE
					, a.SERVICEREMARKS
					, a.EXPIRYDATE
					, a.OVERRIDDEN
					, a.FSAN
					, a.ServiceID
					, a.ServiceRateID
					-- , a.CONTRACTVALIDITYPERIOD
					, a.SERVICESTARTDATE
					, a.SERVICEENDDATE
					, a.clientcode
					, a.contractcode
					, a.serviceinstancestatus	

					, a.CLIENT_ID
					, a.CONTRACT_ID
					
					, a.DEVICE_ID, a.DEVICE_TYPE_ID, a.DEVICE_NAME, a.GATEKEEPER_ID, a.GATEKEEPER_NAME
					-- , (select ips.CUSTOMERACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as CUSTOMERACCOUNTNUMBER
					-- , (select ips.BILLINGACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as BILLINGACCOUNTNUMBER
					-- , (select ips.SERVICEACCOUNTNUMBER from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as SERVICEACCOUNTNUMBER
					-- , (select ips.currentstatus from rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips where ips.clientcode=a.clientcode and ips.contractcode=a.contractcode) as SERVICESTATUS

					, b.LASTSUBSTARTDATE
					, b.LASTSUBENDDATE
					, b.LASTSUBPAYDATE
					, c.LASTINVFROMDATE
					, c.LASTINVTODATE

					, b.CURSUBSTARTDATE
					, b.CURSUBENDDATE
					, b.CURSUBPAYDATE    
					, c.CURINVFROMDATE
					, c.CURINVTODATE
					
					, if(ifnull(date(b.LASTSUBSTARTDATE),date(c.LASTINVFROMDATE))>b.CURSUBSTARTDATE,b.CURSUBSTARTDATE,ifnull(date(b.LASTSUBSTARTDATE),date(c.LASTINVFROMDATE))) as SUBFROMSTAGING
					, if(ifnull(date(b.LASTSUBENDDATE),date(c.LASTINVTODATE))>b.CURSUBENDDATE,b.CURSUBENDDATE,ifnull(date(b.LASTSUBENDDATE),date(c.LASTINVTODATE))) as SUBTOSTAGING
					
					from 
					(

							SELECT
							 (@cnt := @cnt + 1) AS rowNumber,
							
							  ips1.CustomerAccountNumber as CUSTOMERACCOUNTNUMBER
							, ips1.BillingAccountNumber as BILLINGACCOUNTNUMBER
							, ips1.ServiceAccountNumber as SERVICEACCOUNTNUMBER
							, ips1.clientcode
							, ips1.contractcode 
							, ips1.package as PACKAGENAME
							, ips1.serviceinstancenumber as SERVICEINSTANCENUMBER
							, cast(concat('SIN_',ips1.serviceinstancenumber,'_',@cnt) as char(255)) as SERVICEINSTANCENUMBER2
							, cast(concat('SII_',ips1.contractcode) as char(255)) as SERVICEINSTANCEIDENTIFIER
							, ips1.CurrentStatus as SERVICESTATUS
							, case when ips1.servicestatus = 0 then 'Not Active'
								else 'Active' end as SERVICEINSTANCESTATUS

							/*
							, case when ips1.username is null then ips1.UID
								when length(ips1.username)=0 then ips1.UID
								when service_type in ('VOICE','GVOICE') then ips1.UID
								else ips1.username end as USERNAME
							*/
							, case when ips1.UID is null then ips1.USERNAME
								when service_type in ('VOICE','GVOICE') then ips1.UID
								when length(ips1.UID)=0 then ips1.USERNAME
								else ips1.UID end as USERNAME
                            
							-- , ifnull(c.username,c.phoneno) as USERNAME
							, ips1.contractstartdate AS CREATEDDATE
							, ips1.servicestartdate as ACTIVATIONDATE
							, ips1.StatusChangedDate as STATUSCHANGEDDATE
							-- , a.LastActionID as LastActionID
							, ips1.LASTACTION as LASTACTION
							, ips1.price as PACKAGEAMOUNT
							-- , '' as CPE_TYPE
							, ips1.service as CPE_TYPE
							, case when service_type in ('VOICE','GVOICE') then ips1.username
								else ips1.MAC end as CPE_ID
							, ips1.contractstartdate as CONTRACTSTARTDATE
							, ips1.contractenddate as CONTRACTENDDATE
							, '' as SERVICEREMARKS
							, '' as EXPIRYDATE
							, 'Y' as OVERRIDDEN
							-- , c.phoneno as PHONENO
							, ips1.FSAN as FSAN

							, ips1.serviceid as ServiceID
							, ips1.servicerateid as ServiceRateID
							, ips1.CLIENT_ID as CLIENT_ID
							, ips1.CONTRACT_ID as CONTRACT_ID
							
							, ips1.DEVICE_ID, ips1.DEVICE_TYPE_ID, ips1.DEVICE_NAME, ips1.GATEKEEPER_ID, ips1.GATEKEEPER_NAME

							/*
							, (select UserName from rcbill.rcb_devices where CSID=b.ID order by UserName asc limit 1) as USERNAME
							, (select PhoneNo from rcbill.rcb_devices where CSID=b.ID order by PhoneNo asc limit 1) as CPEID_PHONE
							, (select NATIP from rcbill.rcb_devices where CSID=b.ID  order by NATIP asc limit 1) as CPEID_NATIP
							, (select MAC from rcbill.rcb_devices where CSID=b.ID  order by MAC asc limit 1) as CPEID_MAC
							, (select SerNo from rcbill.rcb_devices where CSID=b.ID  order by SerNo asc limit 1) as CPEID_SERNO
							*/


							-- , a.DATA as CONTRACTDATE

							-- , a.ValidityPeriod AS CONTRACTVALIDITYPERIOD
							, ips1.servicestartdate as SERVICESTARTDATE
							, ips1.serviceenddate as SERVICEENDDATE
							from 
							rcbill_extract.IV_PREP_SERVICEINSTANCE1 ips1

							CROSS JOIN (SELECT @cnt := 0, @curType := '') AS dummy


							-- where ips1.clientcode in  ('I.000015739')
                             where ips1.CLIENT_ID in  (@clid)
							-- (select id from rcbill.rcb_tclients where kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR'))
							-- ('I.000011750') -- ,'I.000011750')) -- ('I.000009787','I.000011750','I.000018187'))
							-- ('I.000021409')

							ORDER BY ips1.clientcode desc
					) a 
					
					left join 
					rcbill_extract.CLIENTCONTRACTLASTSUBDATE b 
					on a.CLIENT_ID=b.CLID and a.CONTRACT_ID=b.CID and a.ServiceRateID=b.RSID
					
					left join 
					rcbill_extract.CLIENTCONTRACTLASTINVDATE c 
					on a.CLIENT_ID=c.CLID and a.CONTRACT_ID=c.CID and a.ServiceRateID=c.RSID
		) a
	) a 

;