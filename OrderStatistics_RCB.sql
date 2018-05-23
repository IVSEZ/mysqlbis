-- CasesStatistics_SalesDepts_report 
select replace(area.data, '::', ':') as region, 
ms.name + '::' + cast (ms.id as varchar) as service, 
mt.name + '::' + cast (mt.id as varchar) as model_type, 
ml.name + '::' + cast (ml.id as varchar) as model, 
slng.label + '::' + cast (slng.id as varchar) as state, 
tl.name + '::' + cast (tl.id as varchar) as task, 
opensd.name + '::' + cast (opensd.id as varchar) as created_in, 
signedsd.name + '::' + cast (signedsd.id as varchar) as signed_in, 
closesd.name + '::' + cast (closesd.id as varchar) as closed_in, 
promotion.name + '::' + cast (promotion.id as varchar) as promotion, 
cancelreason.name + '::' + cast (cancelreason.id as varchar) as cancelreason, 
count(*) cnt, avg( datediff(s, CREATED_TS, MODIFIED_TS) ) as avgduration, 
sum( datediff(s, CREATED_TS, MODIFIED_TS) ) as duration 
from dbo.WFLOW_CASE c 
join dbo.WFLOW_MODEL m on m.id = c.model 
left join dbo.wflow_model_types mt on mt.id = m.wflow_model_type_id 
join dbo.WFLOW_MODEL_LNG ml on ml.id = m.id and ml.lng = ? 
join wflow_case_state s on s.id = c.closed+ 10*c.completed +100*isnull(c.num3,0) 
join wflow_case_state_lng slng on s.id = slng.id and slng.lng = ? 
join WFLOW_CASE_MILESTONE mi on mi.acase = c.id 
join ( select cm1.acase, max(cm1.id) max_id from WFLOW_CASE_MILESTONE cm1 group by acase ) as cmmax on cmmax.acase = c.id and cmmax.max_id = mi.id and mi.task in (select id from wflow_task where tkey in (select tkey from wflow_task where 1=1 ) ) 
join WFLOW_TASK t on mi.TASK = t.id 
join WFLOW_TASK_LNG tl on tl.id = t.id and tl.lng = ? 
left join dbo.WFLOW_SERVICES ms on ms.CODE = c.text3 
left join wflow_case_data area on area.acase = c.id and area.name like 'area' 
left join WFLOW_OPERATOR openu on openu.id=c.created_by 
left join SalesCenterUsers openscu on openscu.UserID = openu.id 
left join SalesCenter opensc on opensc.id = openscu.SalesCenterID 
left join SalesDept opensd on opensd.id = opensc.SalesDeptID 
left join WFLOW_OPERATOR closeu on closeu.id=c.modified_by and (c.closed=1 or c.completed=1) 
left join SalesCenterUsers closescu on closescu.UserID = closeu.id 
left join SalesCenter closesc on closesc.id = closescu.SalesCenterID 
left join SalesDept closesd on closesd.id = closesc.SalesDeptID 
left join WFLOW_TASK ts on m.id = ts.model and ts.tkey='contract sign' 
left join WFLOW_CASE_MILESTONE mis on mis.acase = c.id and mis.task = ts.id 
left join WFLOW_OPERATOR signedu on signedu.id = case when mis.COMPLETED_BY is not null then mis.COMPLETED_BY when c.completed =1 then c.modified_by else null end 
left join SalesCenterUsers signedscu on signedscu.UserID = signedu.id 
left join SalesCenter signedsc on signedsc.id = signedscu.SalesCenterID 
left join SalesDept signedsd on signedsd.id = signedsc.SalesDeptID 
left join wflow_case_data crd on crd.acase = c.id and crd.name like 'param_cancel_reason' 
left join WFLOW_CASE_CLOSE_REASON cancelreason on cancelreason.id = crd.data 
left join wflow_case_data crp on crp.acase = c.id and crp.name like 'param_promotion' 
left join APPL_PROMOTION promotion on promotion.id = crp.data 
left join RCBill..tClients cl on cl.id = c.num1 
where 1=1 
and (c.created_ts between ? and ?) 
and (c.created_by in (select id from WFLOW_OPERATOR where WFLOW_OPERATOR.OperatorID = ?) 
and c.created_by in (select id from WFLOW_OPERATOR where WFLOW_OPERATOR.OperatorID = ?)) 
group by 
area.data, ms.name, ms.id, ml.name,mt.name, ml.id, mt.id, slng.label, slng.id, tl.name, tl.id, 
opensd.name, opensd.id, closesd.name, closesd.id, signedsd.name, signedsd.id, cancelreason.name, 
cancelreason.id, promotion.name, promotion.id order by area.data, ms.name, ml.name, slng.label, tl.name , 
where 1 = "en", 2 = "en", 3 = "en", 4 = '2016-01-01+00:00:00', 5 = '2016-11-09+23:59:59', 6 = 1001, 7 = 1001: " 

-- CasesStatistics_SalesDepts_report select replace(area.data, '::', ':') as region, ms.name + '::' + cast (ms.id as varchar) as service, mt.name + '::' + cast (mt.id as varchar) as model_type, ml.name + '::' + cast (ml.id as varchar) as model, slng.label + '::' + cast (slng.id as varchar) as state, tl.name + '::' + cast (tl.id as varchar) as task, opensd.name + '::' + cast (opensd.id as varchar) as created_in, signedsd.name + '::' + cast (signedsd.id as varchar) as signed_in, closesd.name + '::' + cast (closesd.id as varchar) as closed_in, promotion.name + '::' + cast (promotion.id as varchar) as promotion, cancelreason.name + '::' + cast (cancelreason.id as varchar) as cancelreason, count(*) cnt, avg( datediff(s, CREATED_TS, MODIFIED_TS) ) as avgduration, sum( datediff(s, CREATED_TS, MODIFIED_TS) ) as duration from dbo.WFLOW_CASE c join dbo.WFLOW_MODEL m on m.id = c.model left join dbo.wflow_model_types mt on mt.id = m.wflow_model_type_id join dbo.WFLOW_MODEL_LNG ml on ml.id = m.id and ml.lng = ? join wflow_case_state s on s.id = c.closed+ 10*c.completed +100*isnull(c.num3,0) join wflow_case_state_lng slng on s.id = slng.id and slng.lng = ? join WFLOW_CASE_MILESTONE mi on mi.acase = c.id join ( select cm1.acase, max(cm1.id) max_id from WFLOW_CASE_MILESTONE cm1 group by acase ) as cmmax on cmmax.acase = c.id and cmmax.max_id = mi.id and mi.task in (select id from wflow_task where tkey in (select tkey from wflow_task where 1=1 ) ) join WFLOW_TASK t on mi.TASK = t.id join WFLOW_TASK_LNG tl on tl.id = t.id and tl.lng = ? left join dbo.WFLOW_SERVICES ms on ms.CODE = c.text3 left join wflow_case_data area on area.acase = c.id and area.name like 'area' left join WFLOW_OPERATOR openu on openu.id=c.created_by left join SalesCenterUsers openscu on openscu.UserID = openu.id left join SalesCenter opensc on opensc.id = openscu.SalesCenterID left join SalesDept opensd on opensd.id = opensc.SalesDeptID left join WFLOW_OPERATOR closeu on closeu.id=c.modified_by and (c.closed=1 or c.completed=1) left join SalesCenterUsers closescu on closescu.UserID = closeu.id left join SalesCenter closesc on closesc.id = closescu.SalesCenterID left join SalesDept closesd on closesd.id = closesc.SalesDeptID left join WFLOW_TASK ts on m.id = ts.model and ts.tkey='contract sign' left join WFLOW_CASE_MILESTONE mis on mis.acase = c.id and mis.task = ts.id left join WFLOW_OPERATOR signedu on signedu.id = case when mis.COMPLETED_BY is not null then mis.COMPLETED_BY when c.completed =1 then c.modified_by else null end left join SalesCenterUsers signedscu on signedscu.UserID = signedu.id left join SalesCenter signedsc on signedsc.id = signedscu.SalesCenterID left join SalesDept signedsd on signedsd.id = signedsc.SalesDeptID left join wflow_case_data crd on crd.acase = c.id and crd.name like 'param_cancel_reason' left join WFLOW_CASE_CLOSE_REASON cancelreason on cancelreason.id = crd.data left join wflow_case_data crp on crp.acase = c.id and crp.name like 'param_promotion' left join APPL_PROMOTION promotion on promotion.id = crp.data left join RCBill..tClients cl on cl.id = c.num1 where 1=1 and (c.created_ts between ? and ?) and (c.created_by in (select id from WFLOW_OPERATOR where WFLOW_OPERATOR.OperatorID = ?) and c.created_by in (select id from WFLOW_OPERATOR where WFLOW_OPERATOR.OperatorID = ?)) group by area.data, ms.name, ms.id, ml.name,mt.name, ml.id, mt.id, slng.label, slng.id, tl.name, tl.id, opensd.name, opensd.id, closesd.name, closesd.id, signedsd.name, signedsd.id, cancelreason.name, cancelreason.id, promotion.name, promotion.id order by area.data, ms.name, ml.name, slng.label, tl.name ", where [1] = "en"{2} (string), [2] = "en"{2} (string), [3] = "en"{2} (string), [4] = 2016-01-01 00:00:00 (date), [5] = 2016-11-09 23:59:59 (date), [6] = 1001 (int), [7] = 1001 (int), 