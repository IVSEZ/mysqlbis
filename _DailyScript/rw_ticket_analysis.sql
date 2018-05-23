select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%approved%' or comment like 'approved%' or comment like '%approved') order by commentdate desc;

select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%reject%' or comment like 'reject%' or comment like '%reject') order by commentdate desc;

select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%unable%' or comment like 'unable%' or comment like '%unable') order by commentdate desc;

select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%quantify%' or comment like 'quantify%' or comment like '%quantify') order by commentdate desc;