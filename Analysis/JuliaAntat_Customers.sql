select * from rcbill_my.rep_custconsolidated where 
clientcode in 
(
'I.000018413',
'I.000015431',
-- 'I.000015432',
'I.000007185',
'I.000009372',
'I.000006546',
'I.000018166',
'I.000020642'
)
;

select * from rcbill.rcb_clientparcels
where clientcode in 
(
'I.000018413',
'I.000015431',
-- 'I.000015432',
'I.000007185',
'I.000009372',
'I.000006546',
'I.000018166',
'I.000020642'

)

;