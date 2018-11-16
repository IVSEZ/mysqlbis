## LOOK FOR TICKETS WHERE COMMENT IS ABOUT VOD
Select * from rcbill_my.clientticket_cmmtjourney 
where 
(comment like '%VOD%')
-- and 
-- (comment not like '%install%')
and 
(comment like '%not work%')
;

## LOOK FOR TICKETS WHERE COMMENT IS ABOUT DUALVIEW
select * from rcbill_my.clientticket_cmmtjourney 
where 
(comment like '%dual%')
-- and 
-- (comment not like '%install%')
and 
(comment like '%not work%')

;


## GPON CONVERSION APPROVAL TICKETS
select * from rcbill_my.clientticket_cmmtjourney 
where 
(comment like '%GPON conversion%')
and 
(comment like '%Approved as per%')

;