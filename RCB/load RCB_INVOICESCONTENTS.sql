-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllInvoicesContents-12122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllInvoicesContents-13122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesContents-23122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesContents-04012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesContents-10012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesContents-19012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesContents-22012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesContents-29012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesContents-05022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesContents-21022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesContents-28022017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllInvoicesContents-26122017.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_invoicescontents` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_invoicescontents` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@INVOICENO ,
@CLID ,
@CID ,
@CSID ,
@RID ,
@RSID ,
@ServiceID ,
@DID ,
@RPDiscountID ,
@Discount ,
@NUMBER ,
@SCOST ,
@COST ,
@sumCost ,
@FROMDATE ,
@TODATE ,
@ValidTill ,
@ROW ,
@TEXT ,
@ParentID ,
@InvNo ,
@CDRCOUNT ,
@ID_OLD ,
@UPDDATE ,
@USERID ,
@InvoiceID ,
@VAT ,
@CostVAT ,
@CostTotal ,
@DiscardPeriod ,
@ChildCID ,
@DiscountCost 
) 
set 
ID=@ID ,
INVOICENO=@INVOICENO ,
CLID=@CLID ,
CID=@CID ,
CSID=@CSID ,
RID=@RID ,
RSID=@RSID ,
ServiceID=@ServiceID ,
DID=@DID ,
RPDiscountID=@RPDiscountID ,
Discount=@Discount ,
NUMBER=@NUMBER ,
SCOST=@SCOST ,
COST=@COST ,
sumCost=@sumCost ,
FROMDATE=@FROMDATE ,
TODATE=@TODATE ,
ValidTill=@ValidTill ,
ROW=upper(trim(@ROW)) ,
TEXT=upper(trim(@TEXT)) ,
ParentID=@ParentID ,
InvNo=@InvNo ,
CDRCOUNT=@CDRCOUNT ,
ID_OLD=@ID_OLD ,
UPDDATE=@UPDDATE ,
USERID=@USERID ,
InvoiceID=@InvoiceID ,
VAT=@VAT ,
CostVAT=@CostVAT ,
CostTotal=@CostTotal ,
DiscardPeriod=@DiscardPeriod ,
ChildCID=@ChildCID ,
DiscountCost=@DiscountCost ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;



-- drop index IDXinvoicescontents on rcb_invoicescontents;
CREATE INDEX IDXinvoicescontents1
ON rcb_invoicescontents (ID);

CREATE INDEX IDXinvoicescontents2
ON rcb_invoicescontents (INVOICENO);


CREATE INDEX IDXinvoicescontents3
ON rcb_invoicescontents (CLID);


CREATE INDEX IDXinvoicescontents4
ON rcb_invoicescontents (CID);

-- select * from rcb_invoicescontents where clid in (725113);
 select count(*) from rcb_invoicescontents;


