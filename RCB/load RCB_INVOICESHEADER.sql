-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllInvoicesHeader-12122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllInvoicesHeader-13122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesHeader-23122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesHeader-04012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesHeader-10012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesHeader-19012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesHeader-22012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesHeader-29012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesHeader-05022017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesHeader-21022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesHeader-28022017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesHeader-26122017.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_invoicesheader` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_invoicesheader` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@TYPE ,
@HARD ,
@CLID ,
@CID ,
@INVOICENO ,
@ProformaNO ,
@SRCNO ,
@DKINO ,
@DATA ,
@TFIRM ,
@TADDRESS ,
@TMOL ,
@TMOLADDRESS ,
@TDANNO ,
@TBULSTAT ,
@TCITY ,
@TZIP ,
@TRECIPIENT ,
@FCLID ,
@FFIRM ,
@FADDRESS ,
@FMOL ,
@FDANNO ,
@FBULSTAT ,
@FCITY ,
@FBANK ,
@FBANKNO ,
@FACCOUNT ,
@FDDSACCOUNT ,
@PLACE ,
@REASON ,
@SUMA ,
@DDS ,
@TOTAL ,
@DEBT ,
@Avance ,
@AvanceUse ,
@VATPercent ,
@CREATOR ,
@PRNCOUNT ,
@BEGDATE ,
@ENDDATE ,
@SAPExported ,
@PaymentID ,
@Currency ,
@OriginalCurrency ,
@Rate ,
@ID_OLD ,
@UPDDATE ,
@USERID ,
@DueDate ,
@InvNo 
) 
set 
ID=@ID ,
TYPE=@TYPE ,
HARD=@HARD ,
CLID=@CLID ,
CID=@CID ,
INVOICENO=@INVOICENO ,
ProformaNO=@ProformaNO ,
SRCNO=@SRCNO ,
DKINO=@DKINO ,
DATA=@DATA ,
TFIRM=upper(trim(@TFIRM)) ,
TADDRESS=upper(trim(@TADDRESS)) ,
TMOL=upper(trim(@TMOL)) ,
TMOLADDRESS=upper(trim(@TMOLADDRESS)) ,
TDANNO=upper(trim(@TDANNO)) ,
TBULSTAT=@TBULSTAT ,
TCITY=upper(trim(@TCITY)) ,
TZIP=@TZIP ,
TRECIPIENT=upper(trim(@TRECIPIENT)) ,
FCLID=@FCLID ,
FFIRM=upper(trim(@FFIRM)) ,
FADDRESS=upper(trim(@FADDRESS)) ,
FMOL=upper(trim(@FMOL)) ,
FDANNO=upper(trim(@FDANNO)) ,
FBULSTAT=@FBULSTAT ,
FCITY=upper(trim(@FCITY)) ,
FBANK=@FBANK ,
FBANKNO=@FBANKNO ,
FACCOUNT=@FACCOUNT ,
FDDSACCOUNT=@FDDSACCOUNT ,
PLACE=upper(trim(@PLACE)) ,
REASON=upper(trim(@REASON)) ,
SUMA=@SUMA ,
DDS=@DDS ,
TOTAL=@TOTAL ,
DEBT=@DEBT ,
Avance=@Avance ,
AvanceUse=@AvanceUse ,
VATPercent=@VATPercent ,
CREATOR=@CREATOR ,
PRNCOUNT=@PRNCOUNT ,
BEGDATE=@BEGDATE ,
ENDDATE=@ENDDATE ,
SAPExported=@SAPExported ,
PaymentID=@PaymentID ,
Currency=@Currency ,
OriginalCurrency=@OriginalCurrency ,
Rate=@Rate ,
ID_OLD=@ID_OLD ,
UPDDATE=@UPDDATE ,
USERID=@USERID ,
DueDate=@DueDate ,
InvNo=@InvNo ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;



CREATE INDEX IDXinvoiceheader1
ON rcb_invoicesheader (ID,INVOICENO);

CREATE INDEX IDXinvoiceheader2
ON rcb_invoicesheader (INVOICENO);

CREATE INDEX IDXinvoiceheader3
ON rcb_invoicesheader (ProformaNO);

CREATE INDEX IDXinvoiceheader4
ON rcb_invoicesheader (CLID);

CREATE INDEX IDXinvoiceheader5
ON rcb_invoicesheader (CID);

-- select * from rcb_invoicesheader where clid in (717788) limit 10000;
select count(*) from rcb_invoicesheader;
