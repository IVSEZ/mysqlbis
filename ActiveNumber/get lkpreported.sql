SELECT * FROM rcbill_my.lkpreported
where reported='Y'
;

/*
SET SQL_SAFE_UPDATES = 0;
insert into rcbill_my.lkpreported
values
('DualView','Y');


insert into rcbill_my.lkpreported
values
('MultiView','N');

insert into rcbill_my.lkpreported
values
('VOD','N');


insert into rcbill_my.lkpreported
values
('Amber','Y');

insert into rcbill_my.lkpreported
values
('Amber Corporate','Y');

insert into rcbill_my.lkpreported
values
('TurquoiseTV','Y');

insert into rcbill_my.lkpreported
values
('Turquoise Low Tide','Y');

insert into rcbill_my.lkpreported
values
('Turquoise High Tide','Y');


insert into rcbill_my.lkpreported
values
('Crimson','Y');

insert into rcbill_my.lkpreported
values
('Crimson Corporate','Y');


insert into rcbill_my.lkpreported
values
('Test4','N');

insert into rcbill_my.lkpreported
values
('Variety','Y');


insert into rcbill_my.lkpreported
values
('Indian Corporate','Y');




-- Prepaid, Prepaid Data, Prepaid28, Variety, Broad Band 100, Broad Band 200, Broad Band Lite, Business Unlimited-4, Business Unlimited-4-daytime
-- Intel Data 20, Premium

update rcbill_my.lkpreported
set Reported='N'
where ServiceNewType in ('Prepaid', 'Prepaid Data', 'Prepaid28', 'Variety', 'Broad Band 100', 'Broad Band 200', 'Broad Band Lite', 'Business Unlimited-4'
, 'Business Unlimited-4-daytime', 'Intel Data 20', 'Premium');


update rcbill_my.lkpreported
set Reported='N'
where ServiceNewType='Test4';

update rcbill_my.lkpreported
set Reported='Y'
where ServiceNewType='Crimson Corporate';

update rcbill_my.lkpreported
set Reported='Y'
where ServiceNewType='Turquoise Low Tide';

update rcbill_my.lkpreported
set Reported='Y'
where ServiceNewType='Turquoise High Tide';

update rcbill_my.lkpreported
set Reported='Y'
where ServiceNewType='MultiView';


update rcbill_my.lkpreported
set Reported='Y'
where ServiceNewType='VOD';
*/