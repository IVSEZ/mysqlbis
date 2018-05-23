select * from rcbill_my.clientstats where
(`Business Unlimited-1`>0 or `Business Unlimited-2`>0)
;

select * from rcbill_my.clientstats where `Turquoise High Tide`>0 or `Turquoise Low Tide`>0;
-- and clientname like '%Beau Vallon Villa%';

select * from rcbill_my.clientstats where
clientname like '%Beau Vallon Villa%'
or clientname like '%Beau Vallon Villa%'
or clientname like '%Frangipane Apartments%'
or clientname like '%Georgina\'s Cottage%'
or clientname like '%GT Properties Ltd%'
or clientname like '%L\'Echo Des Vagues%'
or clientname like '%Lemongrass Lodge%'
or clientname like '%Palmont Apartments Self Catering%'
or clientname like '%Palmont Commercial Centre%'
or clientname like '%Palmont Complex Self Catering%'
or clientname like '%The Beach House%'
or clientname like '%Villa de Roses%'
or clientname like '%Beach Cottages/Beach Cove%'
or clientname like '%Ocean View Guesthouse%'
or clientname like '%Surman Self Catering Apartment%'
or clientname like '%Bel Horizon%'
or clientname like '%Hillcrest Villas%'
or clientname like '%Villa Aldame%'
or clientname like '%Yarrabee Self Catering%'

;