insert into campaigns(id,name,owner,objective,closes_on,currency,budget) values
('10000000-0000-4000-8000-000000000001','Less rework','Mere','Reduce repeat picking and packing work',current_date+30,'NZD',18000),
('10000000-0000-4000-8000-000000000002','Customer handovers','James','Reduce handover delays',current_date+45,'AUD',12000) on conflict do nothing;
insert into ideas(id,campaign_id,name,description,submitter,owner,department,stage,review_due,last_activity,purpose,retention_review) values
('20000000-0000-4000-8000-000000000001','10000000-0000-4000-8000-000000000001','Reusable tote trial','Trial reusable totes for repeat buyers','Aroha','Mere','Warehouse','review',current_date-3,current_date-20,'Evaluate operational improvement',current_date+180),
('20000000-0000-4000-8000-000000000002','10000000-0000-4000-8000-000000000001','Pick location labels','Test clearer shelf labels','Wiremu','James','Warehouse','pilot',current_date-5,current_date-4,'Evaluate operational improvement',current_date+180),
('20000000-0000-4000-8000-000000000003','10000000-0000-4000-8000-000000000002','Handover checklist','Record owner and acceptance at handover','Emma','','Service','submitted',current_date-2,current_date-18,'',current_date-1),
('20000000-0000-4000-8000-000000000004','10000000-0000-4000-8000-000000000002','Dispatch notes','Standard delivery notes','Noah','James','Service','implemented',current_date-30,current_date-3,'Review measured improvement',current_date+180) on conflict do nothing;
insert into criteria(id,campaign_id,name,weight) values
('30000000-0000-4000-8000-000000000001','10000000-0000-4000-8000-000000000001','Impact',3),
('30000000-0000-4000-8000-000000000002','10000000-0000-4000-8000-000000000001','Feasibility',2),
('30000000-0000-4000-8000-000000000003','10000000-0000-4000-8000-000000000002','Customer value',1) on conflict do nothing;
insert into reviews(idea_id,criterion_id,reviewer,score,rationale)
select '20000000-0000-4000-8000-000000000001'::uuid,c.id,r.reviewer,r.score,'Demo assessment based on the proposal' from criteria c cross join (values('Mere',4),('James',3)) r(reviewer,score) where c.campaign_id='10000000-0000-4000-8000-000000000001' on conflict do nothing;
insert into pilots(id,idea_id,name,owner,hypothesis,metric,baseline,target,cost,due_date,direction,approved_by) values
('40000000-0000-4000-8000-000000000001','20000000-0000-4000-8000-000000000002','Label trial','James','Clear labels reduce mispicks','Mispicks per week',12,5,1500,current_date-2,'decrease','Mere') on conflict do nothing;
insert into outcomes(id,idea_id,name,amount,period_start,period_end,evidence,recorded_by) values
('50000000-0000-4000-8000-000000000001','20000000-0000-4000-8000-000000000004','September rework reduction',2100,current_date-40,current_date-10,'Demo: measured labour comparison','James') on conflict do nothing;
