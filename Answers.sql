
-- queston1
select
 crime_type,
week_number,
crime_code,
no_of_crimes
from
(select
crime_type,
week_number,
crime_code,
count(*) as no_of_crimes,
rank()over(partition by week_number order by count(*) desc)as rnk
from rep_loc_ofc_v
group by
crime_type,
week_number,
crime_code) as frequent_crimes
where rnk=1
order by week_number;



-- question2
select area_name,
population_density,
count(distinct officer_code) as no_of_officer,
count(distinct crime_code)as no_of_crimes,
rank()over(order by population_density desc)as pd_rnk,
rank()over(order by count(distinct officer_code)desc) as officer_rank,
rank()over(order by count(distinct crime_code)desc) as crime_rnk
from rep_loc_ofc_v
group by area_name,population_density
order by crime_rnk;

-- question3
select week_number,crime_type,day_time,no_of_crimes
from(
select week_number,crime_type,time_f(incident_time) as day_time,
count(*) as no_of_crimes,
rank() over (partition by week_number order by count(*)desc)as rnk
from rep_loc_ofc_v
group by 1,2,3) as crime_rate
where rnk=1;


-- question 4
select area_name,day_time,no_of_crimes
from
(select area_name,time_f(incident_time) as day_time,
count(*) as no_of_crimes,
rank() over( partition by area_name order by count(*) desc)as rnk
from rep_loc_ofc_v
group by 1,2) as ranked_crimes
where rnk=1;



-- question5
select age_group,day_time,
no_of_victims
from
(select age_f(victim_age) age_group,
time_f(incident_time)day_time,
count(*) as no_of_victims,
rank () over (partition by age_f(victim_age) order by count(*) desc) rank_position
from rep_vic_v
group by 1,2)  ddd
where rank_position = 1;



-- quetion6
select case_status_desc,
count(*) as reported_crime_status
from rep_loc_ofc_v
group by case_status_desc
order by reported_crime_status desc;




-- question7
select distinct area_name,cctv_count,
count(*) as no_of_crimes,
count(cctv_count) over (partition by area_name) as no_of_cctv
from rep_loc_ofc_v
group by 1,2;


-- question8
SELECT
sum(recovered_footage) as footage_recovered,
sum(unrecovered_footage) as footage_unrecovered
from
(select area_name,
sum(case when cctv_flag= 'true' then 1 
else 0
end) as recovered_footage,
sum(case when cctv_flag ='false'then 1 else 0
end) as unrecovered_footage
from rep_loc_ofc_v
group by area_name
order by recovered_footage,unrecovered_footage) as cc;



-- question9
select distinct crime_type,
sum(offender_relation ='yes') as crimes_by_relation,
sum(offender_relation ='no') as crimes_by_strangers,
if(sum(offender_relation ='yes') >sum(offender_relation ='no'),
'likely_by_relation','likely_by_strangers') as crime_probability
from rep_vic_v
group by crime_type;

-- question10
select complaint_type,
crime_type,
count(*)as no_of_crimes_reported
from rep_loc_ofc_v
group by 1,2;