select * from rcbill_my.clientstats where (`Amber`>0 or `Amber Corporate`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0);


select * from rcbill_my.clientstats where (`Amber`>0 or `Amber Corporate`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0) and `VOD`>0; 


select * from rcbill_my.clientstats where (`Amber`>0 or `Amber Corporate`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0) and clienttype='Residential';


select * from rcbill_my.clientstats where (`Amber`>0 or `Amber Corporate`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0) and `VOD`>0  and clienttype='Residential'; 

select * from rcbill_my.clientstats where (`Amber`>0 or `Amber Corporate`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0) and clienttype like '%Corporate%';


select * from rcbill_my.clientstats where (`Amber`>0 or `Amber Corporate`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0) and `VOD`>0  and clienttype like '%Corporate%'; 



-- ===============================================================


select * from rcbill_my.clientstats where (`Crimson`>0 or `Crimson Corporate`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0);


select * from rcbill_my.clientstats where (`Amber`>0 or `Crimson Corporate`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0) and `VOD`>0; 


select * from rcbill_my.clientstats where (`Crimson`>0 or `Crimson Corporate`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0) and clienttype='Residential';


select * from rcbill_my.clientstats where (`Crimson`>0 or `Crimson Corporate`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0) and `VOD`>0  and clienttype='Residential'; 

select * from rcbill_my.clientstats where (`Crimson`>0 or `Crimson Corporate`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0) and clienttype like '%Corporate%';


select * from rcbill_my.clientstats where (`Crimson`>0 or `Crimson Corporate`>0) and (`Extravagance`>0 or `Extravagance Corporate`>0) and `VOD`>0  and clienttype like '%Corporate%'; 