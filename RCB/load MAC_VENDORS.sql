
/*

download csv file from https://maclookup.app/downloads/csv-database
save it to C:\ProgramData\MySQL\MySQL Server 5.7\Uploads\mac_vendors e.g. mac-vendors-export_20210507.csv
open the file in notepad++, copy contents to a new notepad file
save notepad file as UTF-8 encoded new csv file e.g. mac-vendors-export_20210507-2.csv
use new file below

*/




LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\mac_vendors\\mac-vendors-export_20210507-2.csv' 
REPLACE INTO TABLE `rcbill_my`.`mac_vendors` FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@MacPrefix ,
@VendorName ,
@Private ,
@BlockType ,
@LastUpdate 
) 
set
MACPREFIX=@MacPrefix ,
VENDORNAME=@VendorName ,
PRIVATE=@Private ,
BLOCKTYPE=@BlockType ,
LASTUPDATE=@LastUpdate ,
INSERTEDON=now()

;

CREATE INDEX IDXMV1
ON rcbill_my.mac_vendors(MACPREFIX);


-- select * from rcbill_my.mac_vendors;



