

-- 12575.188 sec / 0.000 sec
-- select distinct clientcode from rcbill_my.customercontractactivity where upper(package) like '%AMBER%';
-- select * from rcbill_my.rep_custconsolidated;

select 
a.*, 

CASE 
	when datediff(a.AMBER_LASTTIME , a.AMBER_FIRSTTIME) < 32 then '< 1 Month' 
	when datediff(a.AMBER_LASTTIME , a.AMBER_FIRSTTIME) >= 32 and datediff(a.AMBER_LASTTIME , a.AMBER_FIRSTTIME) < 91 then '1 - 3 Months' 
	when datediff(a.AMBER_LASTTIME , a.AMBER_FIRSTTIME) >= 91 and datediff(a.AMBER_LASTTIME , a.AMBER_FIRSTTIME) < 181 then '3 - 6 Months' 
	when datediff(a.AMBER_LASTTIME , a.AMBER_FIRSTTIME) >= 181 and datediff(a.AMBER_LASTTIME , a.AMBER_FIRSTTIME) < 366 then '6 - 12 Months' 
	when datediff(a.AMBER_LASTTIME , a.AMBER_FIRSTTIME) >= 366 then 'Over a year' 
end as AMBER_DURATION
from 
(
	select 

	-- a.*


	a.reportdate
	, a.clientcode
	, a.currentdebt
	, a.isaccountactive
	, a.accountactivitystage
	, a.clientname
	, a.clientclass
	, a.activenetwork
	, a.activeservices
	, a.activecontracts
	, a.activesubscriptions
	, a.clientlocation
	, a.clientphone
	, a.clientaddress
    , a.firstactivedate
    , a.firstcontractdate
    , a.contractinfo
    , a.packageinfo
	, b.contractpackage
	, (select min(period) from rcbill_my.customercontractactivity where 0=0 and upper(package) in ('AMBER','AMBER CORPORATE') and clientcode=a.clientcode) as AMBER_FIRSTTIME
	, (select max(period) from rcbill_my.customercontractactivity where 0=0 and upper(package) in ('AMBER','AMBER CORPORATE') and clientcode=a.clientcode) as AMBER_LASTTIME
	from 
	rcbill_my.rep_custconsolidated a 
	left join
	-- rcbill_my.customercontractsnapshot b
	(
		select clientcode, group_concat( distinct package order by contractcode asc separator '|') as contractpackage
		from rcbill_my.customercontractsnapshot
		where servicecategory='Internet'
		and CurrentStatus='Active'
		group by clientcode
	) b
	on
	a.clientcode=b.clientcode


	where a.clientcode in 
	(
	  -- select distinct clientcode from rcbill_my.customercontractactivity where upper(package) in ('AMBER','AMBER CORPORATE')
      'I.000019509',
'I.000019522',
'I.000019530',
'I.000019532',
'I.000019535',
'I.000019537',
'I.000019539',
'I.000019546',
'I.000019555',
'I.000019563',
'I.000019559',
'I.000019556',
'I.000019565',
'I.000019569',
'I.000019564',
'I.000019572',
'I.000019574',
'I.000004482',
'I3710',
'I3169',
'I.000019582',
'I.000019579',
'I10251',
'I.000019586',
'I.000004072',
'I5808',
'I.000019591',
'I.000019589',
'I.000019590',
'I9454',
'I.000013087',
'I.000019594',
'I.000019596',
'I.000019597',
'I.000019600',
'I.000019602',
'I.000019615',
'I.000019610',
'I.000019611',
'I.000019613',
'I.000019599',
'I.000012995',
'I11344',
'I.000019623',
'I.000019625',
'I.000019619',
'I.000017968',
'I.000019631',
'I.000019632',
'I.000019639',
'I16857',
'I.000019657',
'I.000019656',
'I.000019659',
'I.000019665',
'I3036',
'I.000019671',
'I.000019669',
'I.000019675',
'I.000019681',
'I.000019676',
'I16889',
'I.000019686',
'I.000009836',
'I.000019692',
'I.000019689',
'I.000010635',
'I.000019698',
'I.000019700',
'I.000019702',
'I.000019704',
'I.000019706',
'I.000019714',
'I.000019721',
'I.000019717',
'I.000019722',
'I.000012899',
'I.000019727',
'I.000019730',
'I.000019733'
	) 
) a 
;

/*
FROM SALES FEB MARCH 2019

'I.000019509',
'I.000019522',
'I.000019530',
'I.000019532',
'I.000019535',
'I.000019537',
'I.000019539',
'I.000019546',
'I.000019555',
'I.000019563',
'I.000019559',
'I.000019556',
'I.000019565',
'I.000019569',
'I.000019564',
'I.000019572',
'I.000019574',
'I.000004482',
'I3710',
'I3169',
'I.000019582',
'I.000019579',
'I10251',
'I.000019586',
'I.000004072',
'I5808',
'I.000019591',
'I.000019589',
'I.000019590',
'I9454',
'I.000013087',
'I.000019594',
'I.000019596',
'I.000019597',
'I.000019600',
'I.000019602',
'I.000019615',
'I.000019610',
'I.000019611',
'I.000019613',
'I.000019599',
'I.000012995',
'I11344',
'I.000019623',
'I.000019625',
'I.000019619',
'I.000017968',
'I.000019631',
'I.000019632',
'I.000019639',
'I16857',
'I.000019657',
'I.000019656',
'I.000019659',
'I.000019665',
'I3036',
'I.000019671',
'I.000019669',
'I.000019675',
'I.000019681',
'I.000019676',
'I16889',
'I.000019686',
'I.000009836',
'I.000019692',
'I.000019689',
'I.000010635',
'I.000019698',
'I.000019700',
'I.000019702',
'I.000019704',
'I.000019706',
'I.000019714',
'I.000019721',
'I.000019717',
'I.000019722',
'I.000012899',
'I.000019727',
'I.000019730',
'I.000019733',


*/




/*
(
'0008'	,
'I.000000263'	,
'I.000000380'	,
'I.000000412'	,
'I.000000475'	,
'I.000000601'	,
'I.000000774'	,
'I.000000842'	,
'I.000000932'	,
'I.000000951'	,
'I.000001157'	,
'I.000001197'	,
'I.000001226'	,
'I.000001523'	,
'I.000001680'	,
'I.000001870'	,
'I.000001925'	,
'I.000001935'	,
'I.000001973'	,
'I.000002003'	,
'I.000002164'	,
'I.000002189'	,
'I.000002199'	,
'I.000002208'	,
'I.000002268'	,
'I.000002333'	,
'I.000002337'	,
'I.000002342'	,
'I.000002456'	,
'I.000002687'	,
'I.000002726'	,
'I.000002842'	,
'I.000002951'	,
'I.000003369'	,
'I.000003443'	,
'I.000003488'	,
'I.000003600'	,
'I.000003643'	,
'I.000003734'	,
'I.000003762'	,
'I.000003967'	,
'I.000003978'	,
'I.000004032'	,
'I.000004064'	,
'I.000004197'	,
'I.000004216'	,
'I.000004341'	,
'I.000004346'	,
'I.000004637'	,
'I.000004696'	,
'I.000004700'	,
'I.000004707'	,
'I.000004762'	,
'I.000004778'	,
'I.000004854'	,
'I.000004861'	,
'I.000004911'	,
'I.000005131'	,
'I.000005142'	,
'I.000005163'	,
'I.000005249'	,
'I.000005263'	,
'I.000005376'	,
'I.000005380'	,
'I.000005381'	,
'I.000005406'	,
'I.000005469'	,
'I.000005558'	,
'I.000005569'	,
'I.000005645'	,
'I.000005828'	,
'I.000005839'	,
'I.000005964'	,
'I.000005971'	,
'I.000006013'	,
'I.000006023'	,
'I.000006046'	,
'I.000006063'	,
'I.000006101'	,
'I.000006115'	,
'I.000006168'	,
'I.000006177'	,
'I.000006305'	,
'I.000006314'	,
'I.000006350'	,
'I.000006375'	,
'I.000006540'	,
'I.000006543'	,
'I.000006558'	,
'I.000006575'	,
'I.000006579'	,
'I.000006581'	,
'I.000006611'	,
'I.000006645'	,
'I.000006695'	,
'I.000006710'	,
'I.000006720'	,
'I.000006729'	,
'I.000006790'	,
'I.000006811'	,
'I.000006831'	,
'I.000006933'	,
'I.000006941'	,
'I.000006948'	,
'I.000007000'	,
'I.000007029'	,
'I.000007066'	,
'I.000007067'	,
'I.000007129'	,
'I.000007134'	,
'I.000007234'	,
'I.000007245'	,
'I.000007311'	,
'I.000007340'	,
'I.000007347'	,
'I.000007359'	,
'I.000007438'	,
'I.000007509'	,
'I.000007595'	,
'I.000007679'	,
'I.000007700'	,
'I.000007720'	,
'I.000007731'	,
'I.000007736'	,
'I.000007740'	,
'I.000007741'	,
'I.000007752'	,
'I.000007765'	,
'I.000007871'	,
'I.000007903'	,
'I.000007966'	,
'I.000008086'	,
'I.000008099'	,
'I.000008188'	,
'I.000008215'	,
'I.000008228'	,
'I.000008229'	,
'I.000008256'	,
'I.000008319'	,
'I.000008352'	,
'I.000008658'	,
'I.000008704'	,
'I.000008772'	,
'I.000008795'	,
'I.000008977'	,
'I.000008997'	,
'I.000009057'	,
'I.000009069'	,
'I.000009116'	,
'I.000009206'	,
'I.000009209'	,
'I.000009263'	,
'I.000009269'	,
'I.000009272'	,
'I.000009324'	,
'I.000009399'	,
'I.000009482'	,
'I.000009534'	,
'I.000009554'	,
'I.000009563'	,
'I.000009565'	,
'I.000009570'	,
'I.000009587'	,
'I.000009622'	,
'I.000009648'	,
'I.000009677'	,
'I.000009712'	,
'I.000009714'	,
'I.000009718'	,
'I.000009775'	,
'I.000009841'	,
'I.000009844'	,
'I.000009859'	,
'I.000009890'	,
'I.000009910'	,
'I.000009918'	,
'I.000009951'	,
'I.000009984'	,
'I.000010125'	,
'I.000010286'	,
'I.000010334'	,
'I.000010346'	,
'I.000010615'	,
'I.000010673'	,
'I.000010700'	,
'I.000010701'	,
'I.000010739'	,
'I.000010763'	,
'I.000010831'	,
'I.000010864'	,
'I.000010938'	,
'I.000011026'	,
'I.000011050'	,
'I.000011079'	,
'I.000011118'	,
'I.000011124'	,
'I.000011150'	,
'I.000011200'	,
'I.000011235'	,
'I.000011303'	,
'I.000011404'	,
'I.000011452'	,
'I.000011460'	,
'I.000011509'	,
'I.000011518'	,
'I.000011521'	,
'I.000011522'	,
'I.000011596'	,
'I.000011735'	,
'I.000011878'	,
'I.000011897'	,
'I.000011898'	,
'I.000011915'	,
'I.000011998'	,
'I.000012117'	,
'I.000012174'	,
'I.000012178'	,
'I.000012187'	,
'I.000012204'	,
'I.000012269'	,
'I.000012318'	,
'I.000012428'	,
'I.000012532'	,
'I.000012575'	,
'I.000012625'	,
'I.000012627'	,
'I.000012684'	,
'I.000012771'	,
'I.000012833'	,
'I.000012883'	,
'I.000012895'	,
'I.000012922'	,
'I.000012998'	,
'I.000013052'	,
'I.000013059'	,
'I.000013143'	,
'I.000013164'	,
'I.000013284'	,
'I.000013290'	,
'I.000013325'	,
'I.000013351'	,
'I.000013356'	,
'I.000013364'	,
'I.000013365'	,
'I.000013366'	,
'I.000013448'	,
'I.000013460'	,
'I.000013501'	,
'I.000013537'	,
'I.000013549'	,
'I.000013611'	,
'I.000013659'	,
'I.000013728'	,
'I.000013756'	,
'I.000013820'	,
'I.000013852'	,
'I.000013934'	,
'I.000014016'	,
'I.000014020'	,
'I.000014069'	,
'I.000014077'	,
'I.000014096'	,
'I.000014129'	,
'I.000014148'	,
'I.000014251'	,
'I.000014252'	,
'I.000014315'	,
'I.000014351'	,
'I.000014400'	,
'I.000014444'	,
'I.000014451'	,
'I.000014457'	,
'I.000014460'	,
'I.000014461'	,
'I.000014465'	,
'I.000014480'	,
'I.000014491'	,
'I.000014499'	,
'I.000014526'	,
'I.000014536'	,
'I.000014538'	,
'I.000014540'	,
'I.000014541'	,
'I.000014590'	,
'I.000014591'	,
'I.000014596'	,
'I.000014597'	,
'I.000014617'	,
'I.000014632'	,
'I.000014642'	,
'I.000014670'	,
'I.000014675'	,
'I.000014715'	,
'I.000014726'	,
'I.000014760'	,
'I.000014770'	,
'I.000014785'	,
'I.000014802'	,
'I.000014806'	,
'I.000014823'	,
'I.000014869'	,
'I.000014875'	,
'I.000014918'	,
'I.000014936'	,
'I.000014951'	,
'I.000015030'	,
'I.000015048'	,
'I.000015060'	,
'I.000015068'	,
'I.000015075'	,
'I.000015133'	,
'I.000015163'	,
'I.000015235'	,
'I.000015236'	,
'I.000015274'	,
'I.000015293'	,
'I.000015316'	,
'I.000015319'	,
'I.000015331'	,
'I.000015403'	,
'I.000015405'	,
'I.000015420'	,
'I.000015422'	,
'I.000015440'	,
'I.000015446'	,
'I.000015462'	,
'I.000015467'	,
'I.000015512'	,
'I.000015553'	,
'I.000015599'	,
'I.000015616'	,
'I.000015625'	,
'I.000015629'	,
'I.000015654'	,
'I.000015683'	,
'I.000015742'	,
'I.000015755'	,
'I.000015767'	,
'I.000015861'	,
'I.000015910'	,
'I.000015960'	,
'I.000015965'	,
'I.000016060'	,
'I.000016116'	,
'I.000016119'	,
'I.000016160'	,
'I.000016167'	,
'I.000016225'	,
'I.000016264'	,
'I.000016286'	,
'I.000016354'	,
'I.000016481'	,
'I.000016482'	,
'I.000016518'	,
'I.000016548'	,
'I.000016558'	,
'I.000016575'	,
'I.000016580'	,
'I.000016637'	,
'I.000016661'	,
'I.000016668'	,
'I.000016685'	,
'I.000016691'	,
'I.000016694'	,
'I.000016731'	,
'I.000016742'	,
'I.000016789'	,
'I.000016810'	,
'I.000016836'	,
'I.000016837'	,
'I.000016887'	,
'I.000016892'	,
'I.000016903'	,
'I.000016909'	,
'I.000016952'	,
'I.000016960'	,
'I.000016971'	,
'I.000016982'	,
'I.000016996'	,
'I.000017005'	,
'I.000017008'	,
'I.000017013'	,
'I.000017026'	,
'I.000017030'	,
'I.000017032'	,
'I.000017048'	,
'I.000017081'	,
'I.000017086'	,
'I.000017091'	,
'I.000017098'	,
'I.000017156'	,
'I.000017171'	,
'I.000017174'	,
'I.000017209'	,
'I.000017212'	,
'I.000017221'	,
'I.000017240'	,
'I.000017242'	,
'I.000017243'	,
'I.000017256'	,
'I.000017281'	,
'I.000017283'	,
'I.000017316'	,
'I.000017389'	,
'I.000017390'	,
'I.000017407'	,
'I.000017418'	,
'I.000017428'	,
'I.000017435'	,
'I.000017437'	,
'I.000017439'	,
'I.000017461'	,
'I.000017464'	,
'I.000017477'	,
'I.000017487'	,
'I.000017517'	,
'I.000017529'	,
'I.000017533'	,
'I.000017563'	,
'I.000017566'	,
'I.000017570'	,
'I.000017588'	,
'I.000017622'	,
'I.000017628'	,
'I.000017629'	,
'I.000017669'	,
'I.000017673'	,
'I.000017682'	,
'I.000017691'	,
'I.000017695'	,
'I.000017713'	,
'I.000017725'	,
'I.000017774'	,
'I.000017785'	,
'I.000017791'	,
'I.000017817'	,
'I.000017875'	,
'I.000017891'	,
'I.000017906'	,
'I.000017941'	,
'I.000017951'	,
'I.000017953'	,
'I.000017963'	,
'I.000017991'	,
'I.000017995'	,
'I.000018014'	,
'I.000018029'	,
'I.000018030'	,
'I.000018036'	,
'I.000018038'	,
'I.000018040'	,
'I.000018052'	,
'I.000018070'	,
'I.000018078'	,
'I.000018087'	,
'I.000018088'	,
'I.000018090'	,
'I.000018091'	,
'I.000018112'	,
'I.000018136'	,
'I.000018144'	,
'I.000018149'	,
'I.000018159'	,
'I.000018166'	,
'I.000018175'	,
'I.000018179'	,
'I.000018187'	,
'I.000018190'	,
'I.000018200'	,
'I.000018207'	,
'I.000018208'	,
'I.000018227'	,
'I.000018244'	,
'I.000018251'	,
'I.000018269'	,
'I.000018272'	,
'I.000018293'	,
'I.000018297'	,
'I.000018299'	,
'I.000018304'	,
'I.000018320'	,
'I.000018347'	,
'I.000018355'	,
'I.000018371'	,
'I.000018377'	,
'I.000018388'	,
'I.000018409'	,
'I.000018410'	,
'I.000018422'	,
'I.000018424'	,
'I.000018431'	,
'I.000018432'	,
'I.000018436'	,
'I.000018453'	,
'I.000018454'	,
'I.000018468'	,
'I.000018472'	,
'I.000018473'	,
'I.000018478'	,
'I.000018503'	,
'I.000018515'	,
'I.000018534'	,
'I.000018540'	,
'I.000018542'	,
'I.000018576'	,
'I.000018593'	,
'I.000018609'	,
'I.000018624'	,
'I.000018626'	,
'I.000018640'	,
'I.000018645'	,
'I.000018649'	,
'I.000018665'	,
'I.000018689'	,
'I.000018698'	,
'I.000018712'	,
'I.000018715'	,
'I.000018745'	,
'I.000018747'	,
'I.000018770'	,
'I.000018791'	,
'I.000018837'	,
'I.000018868'	,
'I.000018880'	,
'I.000018916'	,
'I.000018968'	,
'I.000018977'	,
'I.000018980'	,
'I.000018987'	,
'I.000018993'	,
'I.000019001'	,
'I.000019017'	,
'I1001'	,
'I1026'	,
'I10318'	,
'I10362'	,
'I10454'	,
'I10769'	,
'I10775'	,
'I110'	,
'I11144'	,
'I11584'	,
'I11727'	,
'I12784'	,
'I13108'	,
'I13267'	,
'I13400'	,
'I1344'	,
'I13510'	,
'I136'	,
'I1364'	,
'I13647'	,
'I14056'	,
'I14672'	,
'I14692'	,
'I1476'	,
'I14920'	,
'I15197'	,
'I15274'	,
'I16017'	,
'I16180'	,
'I16250'	,
'I16339'	,
'I16368'	,
'I16712'	,
'I16771'	,
'I16979'	,
'I17477'	,
'I17522'	,
'I17550'	,
'I17661'	,
'I18029'	,
'I18030'	,
'I18121'	,
'I18559'	,
'I18734'	,
'I18803'	,
'I1883'	,
'I18830'	,
'I1892'	,
'I18922'	,
'I18964'	,
'I19185'	,
'I19529'	,
'I1955'	,
'I19819'	,
'I200'	,
'I20137'	,
'I20169'	,
'I20355'	,
'I20749'	,
'I21115'	,
'I21441'	,
'I21461'	,
'I216'	,
'I21772'	,
'I21871'	,
'I22243'	,
'I22387'	,
'I22559'	,
'I226'	,
'I22713'	,
'I22982'	,
'I23013'	,
'I23191'	,
'I23258'	,
'I23277'	,
'I23344'	,
'I272'	,
'I2837'	,
'I29998'	,
'I305'	,
'I3198'	,
'I3231'	,
'I3565'	,
'I3607'	,
'I378'	,
'I3850'	,
'I397'	,
'I4111'	,
'I4400'	,
'I445'	,
'I476'	,
'I5215'	,
'I5314'	,
'I5402'	,
'I5601'	,
'I5618'	,
'I5668'	,
'I58'	,
'I5844'	,
'I590'	,
'I604'	,
'I6076'	,
'I6305'	,
'I642'	,
'I6545'	,
'I6602'	,
'I6706'	,
'I6714'	,
'I6752'	,
'I6778'	,
'I6830'	,
'I7133'	,
'I732'	,
'I7535'	,
'I7536'	,
'I7882'	,
'I8181'	,
'I8252'	,
'I8341'	,
'I8365'	,
'I8470'	,
'I8580'	,
'I8631'	,
'I8642'	,
'I8828'	,
'I8883'	,
'I8906'	,
'I8995'	,
'I9455'	,
'I9548'	,
'I976'	

)

;

*/