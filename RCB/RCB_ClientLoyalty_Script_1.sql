#CLIENT SCRIPT
use rcbill;

#SET DATE
SET @REPORTDATE=str_to_date('2017-04-09','%Y-%m-%d');
SET @COLNAME1='CLIENTDEBT_REPORTDATE';

SET @WEIGHTDURATION=0.3;
SET @WEIGHTAMOUNT=0.5;
SET @WEIGHTVOLUME=0.2;

#GET RESIDENTIAL CUSTOMERS FROM THE CLIENTEXTENDED REPORT
SELECT * FROM clientextendedreport where CLASSNAME='RESIDENTIAL';

#SET WEIGHTED SCORES FOR 
#TOTALCONTRACTS
#TOTALPAYMENTAMOUNT
#COMBINEDSUBSCRIPTIONCONTRACTPERIOD

DROP TABLE IF EXISTS temp1;
create temporary table temp1 as
(
SELECT *
,(TOTALCONTRACTS * @WEIGHTVOLUME) AS V
,(TOTALPAYMENTAMOUNT * @WEIGHTAMOUNT) AS A
,(COMBINEDSUBSCRIPTIONCONTRACTPERIOD * @WEIGHTDURATION) AS D
,((TOTALCONTRACTS * @WEIGHTVOLUME)+(TOTALPAYMENTAMOUNT * @WEIGHTAMOUNT)+(COMBINEDSUBSCRIPTIONCONTRACTPERIOD * @WEIGHTDURATION)) AS VAD
,
case when activecontracts=0 then 0.1
else activecontracts*0.2 
end as ACTIVEMULTIPLIER
,
case when activecontracts=0 then ((TOTALCONTRACTS * @WEIGHTVOLUME)+(TOTALPAYMENTAMOUNT * @WEIGHTAMOUNT)+(COMBINEDSUBSCRIPTIONCONTRACTPERIOD * @WEIGHTDURATION))*0.1
else ((TOTALCONTRACTS * @WEIGHTVOLUME)+(TOTALPAYMENTAMOUNT * @WEIGHTAMOUNT)+(COMBINEDSUBSCRIPTIONCONTRACTPERIOD * @WEIGHTDURATION))*activecontracts*0.2 
end as ICENTS

FROM
clientextendedreport
WHERE
CLASSNAME='RESIDENTIAL'
order by
VAD DESC
)
;

SELECT * 
,
CASE 
WHEN ICENTS<=0 THEN 'NP2'
WHEN ICENTS>0 AND ICENTS<=50 THEN 'NP1'
WHEN ICENTS>50 AND ICENTS<=100 THEN 'TIER1'
WHEN ICENTS>100 AND ICENTS<=500 THEN 'TIER2'
WHEN ICENTS>500 AND ICENTS<=1000 THEN 'TIER3'
WHEN ICENTS>1000 AND ICENTS<=5000 THEN 'TIER4'
WHEN ICENTS>5000 AND ICENTS<=10000 THEN 'TIER5'
WHEN ICENTS>10000 AND ICENTS<=20000 THEN 'TIER6'
WHEN ICENTS>20000 AND ICENTS<=50000 THEN 'TIER7'
WHEN ICENTS>50000 AND ICENTS<=100000 THEN 'TIER8'
WHEN ICENTS>100000 AND ICENTS<=200000 THEN 'TIER9'
WHEN ICENTS>200000 AND ICENTS<=500000 THEN 'TIER10'
WHEN ICENTS>500000 AND ICENTS<=1000000 THEN 'TIER11'
ELSE 'TIER12' 
END AS INTELTIER


FROM temp1
;
