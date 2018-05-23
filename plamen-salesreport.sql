select sd.name +'::' + cast(sd.id as varchar) as created_by_dept, 
sc.name +'::' + cast(sc.id as varchar) as created_by_center, 
su.name +'::' + cast(su.id as varchar) as created_by, 
area.data as region, 
ms.name + '::' + cast (ms.id as varchar) as orderservice, 
mt.name + '::' + cast (mt.id as varchar) as model_type, 
ml.name + '::' + cast (ml.id as varchar) as model, 
slng.label + '::' + cast (slng.id as varchar) as state, 
c.id, c.created_ts, bcl.kod, isnull(cc.name,'') as clientclass, nc.ccode, nc.contracttype, nc.service, nc.servicerate, nc.price, 
(100+nc.vatpercentT)*nc.price/100 pricevat, 1 cnt, oc.ccode originalccode, oc.service originalservice, oc.servicerate originalservicerate, 
(100+oc.vatpercentT)*oc.price/100 originalpricevat 
from dbo.WFLOW_CASE c join dbo.WFLOW_MODEL m 
on m.id = c.model 
join dbo.WFLOW_MODEL_LNG ml 
on ml.id = c.model 
left join dbo.WFLOW_MODEL_TYPES mt on mt.id = m.wflow_model_type_id 
join wflow_case_state_lng slng on slng.id = c.closed+ 10*c.completed +100*isnull(c.num3,0) 
left join Users su on su.ID = c.created_by 
left join SalesCenterUsers scu on scu.UserID = c.created_by 
left join SalesCenter sc on sc.id = scu.SalesCenterID 
left join SalesDept sd on sd.id = sc.SalesDeptID 
left join dbo.WFLOW_SERVICES ms on ms.CODE = c.text3 
left join wflow_case_data area on area.acase = c.id and area.name like 'area' 
left join wflow_case_data attribute_cid on attribute_cid.acase = c.id and attribute_cid.name like 'attribute_cid' 
left join rcbill..tclients bcl on bcl.id = c.num1 
left join rcbill..ClientClasses cc on cc.ID = bcl.CLClass 
left join ( select c.clid, c.kod cCode, c.id_old as cSourceID, cs.cid, 
c.contracttype, cs.id_old as csSourceID, s.id ServiceID, s.name Service, s.vatpercentT, 
v.id ServiceRateID, v.name ServiceRate, v.price 
from rcbill..contracts c join rcbill..contractservices cs 
on cs.cid = c.id and cs.serviceid = cs.serviceid 
join rcbill..services s on s.id = cs.serviceid and s.instatistics=1 
join rcbill..vpnrates v on v.id = cs.servicerateid where 1=1 ) 
as nc on nc.clid = c.num1 
and nc.cSourceID like 'wfl.' + cast(c.id as varchar) +'%' 
and nc.csSourceID like 'wfl.' + cast(c.id as varchar) +'.%' 
left join ( select c.clid, c.kod cCode, c.id_old as cSourceID, cs.cid, c.contracttype, 
cs.id_old as csSourceID, s.id ServiceID, s.name Service, s.vatpercentT, v.id ServiceRateID, 
v.name ServiceRate, v.price 
from rcbill..contracts c join rcbill..contractservices cs 
on cs.cid = c.id and cs.serviceid = cs.serviceid 
join rcbill..services s on s.id = cs.serviceid 
and s.instatistics=1 
join rcbill..ServiceClass_LNG scl on scl.id = s.ServiceClassID and scl.lng = 'en' and scl.Label='Base service' 
join rcbill..vpnrates v on v.id = cs.servicerateid where 1=1 ) as oc on oc.clid = c.num1 
and oc.cid like attribute_cid.data where 1=1 and ml.lng = ? and slng.lng = ? 
and (c.created_ts between ? and ?) 
and (c.created_by in (select id from WFLOW_OPERATOR where WFLOW_OPERATOR.OperatorID = ?) 
and c.created_by in (select id from WFLOW_OPERATOR where WFLOW_OPERATOR.OperatorID = ?)) 
order by area.data, sd.name, sc.name, ms.name, ml.name, slng.label 

