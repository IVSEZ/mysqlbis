use rcbill_my;
#SET DATE
-- SET @REPORTDATE=str_to_date('2018-01-10','%Y-%m-%d');
-- SET @rundate='2018-01-10';

-- RENAME TABLE rcbill_my.dailysales TO rcbill_my.dailysalesold;



## change all csv dates 6 files

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\SalesReport-25082019-02092019-1.csv' 
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\SalesReport2-01012018-31012018-1.csv' 
 
REPLACE INTO TABLE `rcbill_my`.`dailysales` CHARACTER SET LATIN1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@SalesChannel ,
@SalesCenter ,
@CreatedBy ,
@Region ,
@OrderService ,
@ModelType ,
@OrderType ,
@State ,
@OrderID ,
@OrderDate ,
@ClientCode ,
@ClientClass ,
@Contract ,
@ContractType ,
@Service ,
@ServiceType ,
@Cost ,
@Price ,
@Num ,
@OriginalContract ,
@OriginalService ,
@OriginalServiceType ,
@OriginalPrice
) 
set 
SALESCHANNEL=@SalesChannel ,
SALESCENTER=@SalesCenter ,
CREATEDBY=@CreatedBy ,
REGION=@Region ,
ORDERSERVICE=@OrderService ,
MODELTYPE=@ModelType ,
ORDERTYPE=@OrderType ,
STATE=@State ,
ORDERID=@OrderID ,
ORDERDATE=str_to_date(@OrderDate,'%m/%d/%Y %H:%i'),	
CLIENTCODE=@ClientCode ,
CLIENTCLASS=@ClientClass ,
CONTRACT=@Contract ,
CONTRACTTYPE=@ContractType ,
SERVICE=@Service ,
SERVICETYPE=@ServiceType ,
COST=@Cost ,
PRICE=@Price ,

NUM=@Num ,
ORIGINALCONTRACT=@OriginalContract ,
ORIGINALSERVICE=@OriginalService ,
ORIGINALSERVICETYPE=@OriginalServiceType ,

ORIGINALPRICE=@OriginalPrice ,
CLEANORIGPRICE=GetCleanOrigPrice(@ContractType,@OriginalPrice),
CLEANORIGCOST=GetOrigCost(@OriginalService,@OriginalPrice),

INSERTEDON=now()

;

select count(1) as dailysales from rcbill_my.dailysales;
select date(orderdate), count(*) from rcbill_my.dailysales group by 1 order by 1 desc limit 15;


select state, count(*) from rcbill_my.dailysales group by 1 order by 1 desc;
select ORDERTYPE, count(*) from rcbill_my.dailysales group by 1 order by 1 desc;

-- set SQL_SAFE_UPDATES=0;
-- delete from rcbill_my.dailysales where insertedon='2020-10-01 09:07:22';

-- select * from rcbill_my.dailysales;