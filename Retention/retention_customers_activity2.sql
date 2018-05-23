use rcbill_my;
set @reportdate='2017-11-28';
SET @rundate='2017-11-28';



select * from rcbill_my.retentioncustomeractivity;

select * from rcbill_my.clientstats
where
clientcode in 
(
'I17513',
'I22254',
'23223',
'9013',
'12896',
'I20990',
'I2863',
'12381',
'13928',
'I22512',
'5971',
'842',
'I5971',
'I20663',
'155',
'I11539',
'I14709',
'8050',
'I14266',
'I9644',
'I22497',
'7714',
'286',
'1203',
'I22613',
'I19488',
'I8015',
'562',
'20119',
'I11970',
'8227',
'9461',
'9301',
'10635',
'662',
'I2821',
'434',
'2038',
'I1454',
'4162',
'138',
'I1454',
'I7967',
'15532',
'12435',
'I1045',
'644',
'I16596',
'19919',
'11764',
'7940',
'5279',
'1388',
'5131',
'I3505',
'I23272',
'14325',
'10531',
'10290',
'3399',
'10531',
'11970',
'2056',
'11519',
'14399',
'662',
'11539',
'14467',
'14466',
'9965',
'17383',
'644',
'8653',
'I14710',
'I10177',
'I9965',
'I9272',
'4976',
'14654',
'4119',
'21657',
'2942',
'15525',
'5039',
'22389',
'9975',
'14770',
'I22811',
'9579',
'3341',
'14832',
'14833',
'7367',
'6966',
'8328',
'2323',
'9577',
'1260',
'4054',
'16489',
'I4062',
'23277',
'I621',
'4497',
'I22117',
'I7636',
'3399',
'7567',
'4571',
'1086',
'8617',
'I1035',
'11254',
'I14461',
'10908',
'I15203',
'8603',
'5447',
'9223',
'10763',
'9711',
'22135',
'539',
'5247',
'I20218',
'I6881',
'I3129',
'4994',
'1743',
'11690',
'6094',
'4465',
'12123',
'1145',
'1673',
'539',
'59',
'I20453',
'I21343',
'10369',
'I.000000722',
'I.000009458',
'I10514',
'I18672',
'I389',
'I18870',
'I4568',
'I1673',
'I.000002343',
'I7112',
'I3693',
'I.000008179',
'6687',
'I19230',
'I8020',
'I.000013811',
'I7967',
'I21343',
'I1673',
'I.000005120',
'I13397',
'I.000008847',
'I21983',
'I.000009517',
'I.000002018',
'I.000014009',
'I20646',
'I7155',
'I998',
'I.000006525',
'I20046',
'I.000015232',
'I.000010336',
'I22515',
'I.000007686',
'I.000011915',
'I2821',
'I18453',
'I.000002276',
':I.000009386',
'I19822',
'I1534',
'I.000003307',
'I12938',
'I18564',
'I.000013817',
'I.000004024',
'I.000010864',
'I.000011320',
'I8603',
'I14331',
'I20129',
'I.000010234',
'I13142',
'I1730',
'I2788',
'I.000002936',
'I4768',
'I1721',
'I.000005968',
'I6553',
'I524',
'I.000011178',
'I.000014752',
'I.000005921',
'I.000011320',
'I.000004346',
'I14604',
'I.000005921',
'I6097',
'I2788',
'I.000007501',
'I.000004473',
'I12429',
'I.000010383',
'I19928',
'I1401',
'I.000010856',
'I13267',
'I.000011388',
'I7945',
'I17183',
'I.000008537',
'I6940',
'I.000002941',
'I458',
'I1465',
'I.000002101',
'I16201',
'I.000011292',
'I.000008537',
'I7945',
'I.000011388',
'I6940'
)
;

select * from rcbill_my.retentioncustomeractivity
where clientcode in 
(
'I17513',	'I22254',	'23223',	'9013',	'12896',	'I20990',	'I2863',	'12381',	'13928',	'I22512',	'5971',	'842',	'I5971',	'I20663',	'155',	'I11539',	'I14709',	'8050',	'I14266',	'I9644',	'I22497',	'7714',	'286',	'1203',	'I22613',	'I19488',	'I8015',	'562',	'20119',	'I11970',	'8227',	'9461',	'9301',	'10635',	'662',	'I2821',	'434',	'2038',	'I1454',	'4162',	'138',	'I1454',	'I7967',	'15532',	'12435',	'I1045',	'644',	'I16596',	'19919',	'11764',	'7940',	'5279',	'1388',	'5131',	'I3505',	'I23272',	'14325',	'10531',	'10290',	'3399',	'10531',	'11970',	'2056',	'11519',	'14399',	'662',	'11539',	'14467',	'14466',	'9965',	'17383',	'644',	'8653',	'I14710',	'I10177',	'I9965',	'I9272',	'4976',	'14654',	'4119',	'21657',	'2942',	'15525',	'5039',	'22389',	'9975',	'14770',	'I22811',	'9579',	'3341',	'14832',	'14833',	'7367',	'6966',	'8328',	'2323',	'9577',	'1260',	'4054',	'16489',	'I4062',	'23277',	'I621',	'4497',	'I22117',	'I7636',	'3399',	'7567',	'4571',	'1086',	'8617',	'I1035',	'11254',	'I14461',	'10908',	'I15203',	'8603',	'5447',	'9223',	'10763',	'9711',	'22135',	'539',	'5247',	'I20218',	'I6881',	'I3129',	'4994',	'1743',	'11690',	'6094',	'4465',	'12123',	'1145',	'1673',	'539',	'59',	'I20453',	'I21343',	'10369',	'I.000000722',	'I.000009458',	'I10514',	'I18672',	'I389',	'I18870',	'I4568',	'I1673',	'I.000002343',	'I7112',	'I3693',	'I.000008179',	'6687',	'I19230',	'I8020',	'I.000013811',	'I7967',	'I21343',	'I1673',	'I.000005120',	'I13397',	'I.000008847',	'I21983',	'I.000009517',	'I.000002018',	'I.000014009',	'I20646',	'I7155',	'I998',	'I.000006525',	'I20046',	'I.000015232',	'I.000010336',	'I22515',	'I.000007686',	'I.000011915',	'I2821',	'I18453',	'I.000002276',	':I.000009386',	'I19822',	'I1534',	'I.000003307',	'I12938',	'I18564',	'I.000013817',	'I.000004024',	'I.000010864',	'I.000011320',	'I8603',	'I14331',	'I20129',	'I.000010234',	'I13142',	'I1730',	'I2788',	'I.000002936',	'I4768',	'I1721',	'I.000005968',	'I6553',	'I524',	'I.000011178',	'I.000014752',	'I.000005921',	'I.000011320',	'I.000004346',	'I14604',	'I.000005921',	'I6097',	'I2788',	'I.000007501',	'I.000004473',	'I12429',	'I.000010383',	'I19928',	'I1401',	'I.000010856',	'I13267',	'I.000011388',	'I7945',	'I17183',	'I.000008537',	'I6940',	'I.000002941',	'I458',	'I1465',	'I.000002101',	'I16201',	'I.000011292',	'I.000008537',	'I7945',	'I.000011388',	'I6940'
)
;

drop table if exists rcbill_my.retentioncustomeractivity2;


create table  rcbill_my.retentioncustomeractivity2
as
(
			select a.* 
				-- , rcbill_my.GetActiveDaysForContract(clientcode,contractcode,package) as ActiveDaysForContract
				-- , rcbill_my.GetActiveDaysForClient(clientcode) as ActiveDaysForClient            
            from 
            (
				select distinct clientcode, clientname, clientclass, contractcode, package
                , min(period) as firstcontractdate
				, max(period) as lastcontractdate
				, (sum(ACTIVECOUNT)/count(period)) as activecount
				, (datediff(max(period),min(period))+1) as DurationForContract
				, rcbill_my.GetActiveDaysForContract(clientcode,contractcode,package) as ActiveDaysForContract
				, rcbill_my.GetActiveDaysForClient(clientcode) as ActiveDaysForClient
				-- , count(period) as activedays 
				,
					case when max(period) = @reportdate then 'Active' 
					else 'Not Active'
					end as `CurrentStatus`
				from rcbill_my.customercontractactivity 
				where 
                -- package in ('Crimson','Crimson Corporate') and period>='2017-03-25'
                clientcode in 
				(
				-- 'I17513',	'I22254',	'23223',	'9013',	'12896',	'I20990',	'I2863',	'12381',	'13928',	'I22512',	'5971',	'842',	'I5971',	'I20663',	'155',	'I11539',	'I14709',	'8050',	'I14266',	'I9644',	'I22497',	'7714',	'286',	'1203',	'I22613',	'I19488',	'I8015',	'562',	'20119',	'I11970',	'8227',	'9461',	'9301',	'10635',	'662',	'I2821',	'434',	'2038',	'I1454',	'4162',	'138',	'I1454',	'I7967',	'15532',	'12435',	'I1045',	'644',	'I16596',	'19919',	'11764',	'7940',	'5279',	'1388',	'5131',	'I3505',	'I23272',	'14325',	'10531',	'10290',	'3399',	'10531',	'11970',	'2056',	'11519',	'14399',	'662',	'11539',	'14467',	'14466',	'9965',	'17383',	'644',	'8653',	'I14710',	'I10177',	'I9965',	'I9272',	'4976',	'14654',	'4119',	'21657',	'2942',	'15525',	'5039',	'22389',	'9975',	'14770',	'I22811',	'9579',	'3341',	'14832',	'14833',	'7367',	'6966',	'8328',	'2323',	'9577',	'1260',	'4054',	'16489',	'I4062',	'23277',	'I621',	'4497',	'I22117',	'I7636',	'3399',	'7567',	'4571',	'1086',	'8617',	'I1035',	'11254',	'I14461',	'10908',	'I15203',	'8603',	'5447',	'9223',	'10763',	'9711',	'22135',	'539',	'5247',	'I20218',	'I6881',	'I3129',	'4994',	'1743',	'11690',	'6094',	'4465',	'12123',	'1145',	'1673',	'539',	'59',	'I20453',	'I21343',	'10369',	'I.000000722',	'I.000009458',	'I10514',	'I18672',	'I389',	'I18870',	'I4568',	'I1673',	'I.000002343',	'I7112',	'I3693',	'I.000008179',	'6687',	'I19230',	'I8020',	'I.000013811',	'I7967',	'I21343',	'I1673',	'I.000005120',	'I13397',	'I.000008847',	'I21983',	'I.000009517',	'I.000002018',	'I.000014009',	'I20646',	'I7155',	'I998',	'I.000006525',	'I20046',	'I.000015232',	'I.000010336',	'I22515',	'I.000007686',	'I.000011915',	'I2821',	'I18453',	'I.000002276',	':I.000009386',	'I19822',	'I1534',	'I.000003307',	'I12938',	'I18564',	'I.000013817',	'I.000004024',	'I.000010864',	'I.000011320',	'I8603',	'I14331',	'I20129',	'I.000010234',	'I13142',	'I1730',	'I2788',	'I.000002936',	'I4768',	'I1721',	'I.000005968',	'I6553',	'I524',	'I.000011178',	'I.000014752',	'I.000005921',	'I.000011320',	'I.000004346',	'I14604',	'I.000005921',	'I6097',	'I2788',	'I.000007501',	'I.000004473',	'I12429',	'I.000010383',	'I19928',	'I1401',	'I.000010856',	'I13267',	'I.000011388',	'I7945',	'I17183',	'I.000008537',	'I6940',	'I.000002941',	'I458',	'I1465',	'I.000002101',	'I16201',	'I.000011292',	'I.000008537',	'I7945',	'I.000011388',	'I6940'
				'I10369',	'I.000000722',	'I.000009458',	'I10514',	'I18672',	'I389',	'I18870',	'I4568',	'I1673',	'I.000002343',	'I7112',	'I3693',	'I.000008179',	'I.000006687',	'I19230',	'I8020',	'I.000013811',	'I7967',	'I21343',	'I1673',	'I.000005120',	'I13397',	'I.000008847',	'I21983',	'I.000009517',	'I.000002018',	'I.000014009',	'I20646',	'I7155',	'I998',	'I.000006525',	'I20046',	'I.000015232',	'I.000010336',	'I22515',	'I.000007686',	'I.000011915',	'I2821',	'I18453',	'I.000002276',	'I.000009386',	'I19822',	'I1534',	'I.000003307',	'I12938',	'I18564',	'I.000013817',	'I.000004024',	'I.000010864',	'I.000011320',	'I8603',	'I14331',	'I20129',	'I.000010234',	'I13142',	'I1730',	'I2788',	'I.000002936',	'I4768',	'I1721',	'I.000005968',	'I6553',	'I524',	'I.000011178',	'I.000014752',	'I.000005921',	'I.000011320',	'I.000004346',	'I14604',	'I.000005921',	'I6097',	'I2788',	'I.000007501',	'I.000004473',	'I12429',	'I.000010383',	'I19928',	'I1401',	'I.000010856',	'I13267',	'I.000011388',	'I7945',	'I17183',	'I.000008537',	'I6940',	'I.000002941',	'I458',	'I1465',	'I.000002101',	'I16201',	'I.000011292',	'I.000008537',	'I7945',	'I.000011388',	'I6940'

                )
				-- clientname like '%retention%'
                group by clientcode, contractcode, package
				ORDER BY clientcode, 4
			-- ) a
			-- inner join
			-- (
			-- 	select distinct clientcode, clientname, clientclass from rcbill_my.clientstats 
			-- ) b
			-- on a.clientcode=b.clientcode
			-- order by a.clientcode, a.firstcontractdate
			) a 
            -- where currentstatus='Active'
            order by clientcode, lastcontractdate
);
            
            
select * from rcbill_my.retentioncustomeractivity2;
            
select a.*,
case 
when a.dayssincelastactive=0 then '1. Alive' 
when a.dayssincelastactive>0 and a.dayssincelastactive<=7 then '2. Snoozing'
when a.dayssincelastactive>7 and a.dayssincelastactive<=30 then '3. Asleep'
when a.dayssincelastactive>30 and a.dayssincelastactive<=90 then '4. Comatose'
when a.dayssincelastactive>90 then '5. Dead'
end as `ActivityStatus` 
 from 
(
SELECT t1.*, datediff(@rundate,t1.lastcontractdate) as dayssincelastactive FROM rcbill_my.retentioncustomeractivity2 t1
  JOIN (SELECT clientcode, MAX(lastcontractdate) as lastcontractdate FROM rcbill_my.retentioncustomeractivity2 GROUP BY clientcode) t2
    ON t1.clientcode = t2.clientcode AND t1.lastcontractdate = t2.lastcontractdate
) a
;

select * from rcbill.clientcontractinvpmt
where (CL_CLIENTCODE, CON_CONTRACTCODE) in 
(

/*
	select a.clientcode, a.contractcode
	 from 
	(
	SELECT t1.*, datediff(@rundate,t1.lastcontractdate) as dayssincelastactive FROM rcbill_my.retentioncustomeractivity2 t1
	  JOIN (SELECT clientcode, MAX(lastcontractdate) as lastcontractdate FROM rcbill_my.retentioncustomeractivity2 GROUP BY clientcode) t2
		ON t1.clientcode = t2.clientcode AND t1.lastcontractdate = t2.lastcontractdate
	) a
*/

select clientcode, contractcode from rcbill_my.retentioncustomeractivity2 where firstcontractdate>='2017-08-01'
)

;

select cl_clientname,CL_CLIENTCODE,CON_CONTRACTCODE, count(CON_CONTRACTCODE), sum(TotalPaymentAmount), max(LastPaidAmount) from rcbill.clientcontractinvpmt
where (CL_CLIENTCODE, CON_CONTRACTCODE) in 
(

/*
	select a.clientcode, a.contractcode
	 from 
	(
	SELECT t1.*, datediff(@rundate,t1.lastcontractdate) as dayssincelastactive FROM rcbill_my.retentioncustomeractivity2 t1
	  JOIN (SELECT clientcode, MAX(lastcontractdate) as lastcontractdate FROM rcbill_my.retentioncustomeractivity2 GROUP BY clientcode) t2
		ON t1.clientcode = t2.clientcode AND t1.lastcontractdate = t2.lastcontractdate
	) a
*/

select clientcode, contractcode from rcbill_my.retentioncustomeractivity2 where currentstatus = 'Active'
)
group by cl_clientname, CL_CLIENTCODE, CON_CONTRACTCODE
-- with rollup
;