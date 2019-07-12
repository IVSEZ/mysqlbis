select * from rcbill_my.clientstats limit 10;


select * from rcbill_my.clientstats where (`Extravagance`>0 or `Extravagance Corporate`>0)
and
upper(services) REGEXP 'INTERNET|ALL'
and clientclass in ('Residential','Corporate Bundle')
and `VOD`>0
;


select * from rcbill_my.clientstats where (`Executive`>0)
and
upper(services) REGEXP 'INTERNET|ALL'
and clientclass in ('Residential','Corporate Bundle')
-- and `VOD`>0
;