Create table hospital_dataset(
						Name text,
						Age Int,
						Gender varchar(50),
						Blood_Type varchar(50),
						Medical_Conditions text,
						Date_of_Admission Date,
						Doctor text,
						Hospital text,
						Insurance_Provider text,
						Billing_Amount decimal(10,5),
						Room_Number int,
						Admission_Type text,
						Discharge_Date Date,
						Medication text,
						Test_Results text
)
select *from hospital_dataset;

					--Sql Queries

--1.	Display the patient name, age, gender, medical condition, and hospital. 
select name,age,gender,medical_conditions,hospital
from hospital_dataset;

--2.	Find the total number of patients. 
select count(*) from hospital_dataset;

--3.	Find the average, minimum, and maximum billing amount. 
select avg(billing_amount) as avg_amount,
min(billing_amount) as min_amount,
max(billing_amount) as max_amount
from hospital_dataset
where billing_amount>=0;

--4.	Find patients whose age is between 25 and 50. 
select name,age
from hospital_dataset
where age between 25 and 50;

--5.	Find patients whose billing amount is greater than ₹30,000. 
select *from hospital_dataset
where billing_amount>30000;

--6.	Display all unique medical conditions. 
select distinct(medical_conditions) 
from hospital_dataset;

--7.	Find the number of patients for each medical condition. 
Select medical_conditions,count(*) as number_of_patients
from hospital_dataset
group by medical_conditions;

--8.	Find the total billing amount for each hospital. 
select hospital,sum(billing_amount) as total_billing_amount
from hospital_dataset
group by hospital;

--9.	Find the average billing amount for each hospital. 
Select hospital,avg(billing_amount) as avg_amount 
from hospital_dataset
group by hospital;

--10.	Find hospitals having more than 50 patients.
select hospital,count(*) as total_patients
from hospital_dataset
group by hospital
having count(*)>=30;

--11.	Find patients admitted through Emergency or Urgent admission. 
Select admission_type,count(*) from hospital_dataset
group by admission_type;

--12.	Find patients whose test result is Abnormal.
Select *from hospital_dataset
where test_results='Abnormal';

--13.	Find patients whose name starts with A. 
select *from hospital_dataset
where name like 'a%';

--14.	Find patients whose name contains son. 
select *from hospital_dataset
where name like'%son%';

--15.	Find the top 10 patients according to billing amount.
Select *from hospital_dataset
order by billing_amount desc 
limit 10;

--16.	Find the second-highest billing amount. 
Select *from hospital_dataset
order by billing_amount desc 
limit 2;

--17.	Find the number of patients for each insurance provider. 
select insurance_provider,count(*) as no_of_patients
from hospital_dataset
group by insurance_provider;

--18.	Find the insurance provider with the highest number of patients. 
select insurance_provider,count(*) as no_of_patients
from hospital_dataset
group by insurance_provider
order by no_of_patients desc limit 1;

--19.	Find the total billing amount for each insurance provider. 
Select insurance_provider,sum(billing_amount) as total_billing_amount
from hospital_dataset
group by insurance_provider;

--20.	Find the medical condition having the highest number of patients. 
select medical_conditions,count(*) as highest_no_of_patients
from hospital_dataset
group by medical_conditions
order by highest_no_of_patients desc limit 1;

--21.	Find the medical condition having the highest average billing amount. 
select medical_conditions,avg(billing_amount) as avg_billing_amount
from hospital_dataset
group by medical_conditions
order by avg_billing_amount desc limit 1;

--22.	Find the average billing amount separately for Male and Female patients. 
select gender,avg(billing_amount) as avg_billing_amount
from hospital_dataset
group by gender;

--23.	Find the number of Male and Female patients in each hospital. 
select gender,count(*) from hospital_dataset
group by gender;

--24.	Find the number of patients for each blood type. 
select blood_type,count(*) from hospital_dataset
group by blood_type
order by count(*) desc;

--25.	Find the most frequently used medication. 
select medication,count(*) as frequency
from hospital_dataset
group by medication
order by count(*) desc limit 1;

--26.	Find the earliest and latest admission date. 
select min(date_of_admission) as earliest_admission,
max(date_of_admission) as latest_admission
from hospital_dataset;

--27.	Find the number of patients admitted in each year. 
select extract(year from date_of_admission) as year,count(*) as no_of_patients
from hospital_dataset
group by year;

--28.	Find the number of patients admitted in each month. 
select extract(month from date_of_admission) as month,count(*) as no_of_patients
from hospital_dataset
group by month
order by month asc;

--29.	Calculate the number of days each patient stayed in the hospital. 
select name,discharge_date-date_of_admission as stay_days
from hospital_dataset;

--30.	Find patients who stayed for more than 10 days. 
select name,discharge_date-date_of_admission as stay_days
from hospital_dataset
where discharge_date-date_of_admission>10;

--31.	Find the average hospital stay for each hospital.
select name,discharge_date-date_of_admission as stay_days
from hospital_dataset
where discharge_date-date_of_admission>10;

--32.	Find the hospital having the highest average hospital stay.
select hospital,avg(discharge_date-date_of_admission) as avg_stay_days
from hospital_dataset
group by hospital
order by avg_stay_days desc limit 1;

--33.	Create an age category using CASE WHEN: Minor, Adult, Middle Age, Senior. 
--Create a new column
alter table hospital_dataset
add column age_category varchar(50);
--update the column
Update hospital_dataset
set age_category=
		case 
			when age<13 Then 'Minor'
			when age between 13 and 19 then 'Teenager'
			when age between 20 and 39 then 'Adult'
			when age between 40 and 59 then 'Middle Age'
			when age >=60 then 'Senior'
			end;
select *from hospital_dataset;


--35.	Find the percentage of patients admitted through Emergency. 
select admission_type,count(*)*100/(select count(*) from hospital_dataset) AS percentage 
from hospital_dataset
group by admission_type;

--36.	Find the percentage of patients with Abnormal test results. 
select test_results,round(count(*)*100.0/(select count(*) from hospital_dataset),2) as percentage
from hospital_dataset
where test_results='Abnormal'
group by test_results;

--37.	Find patients whose billing amount is greater than the overall average billing amount.
select *from hospital_dataset
where billing_amount>(select avg(billing_amount) from hospital_dataset)

--38.	Find patients whose age is greater than the average age. 
select *from hospital_dataset
where age>(select avg(age) from hospital_dataset);

--39.	Find the hospital with the highest total billing amount. 
select hospital,billing_amount from hospital_dataset
order by billing_amount desc 
limit 1;

--40.	Find hospitals whose total billing amount is greater than ₹1,000,000. 
select hospital,billing_amount from hospital_dataset
where billing_amount>(select avg(billing_amount) from hospital_dataset);

--41.	Find doctors who have treated more than 10 patients. 
select doctor,count(*) from hospital_dataset
group by doctor
having count(*)>10
order by count(*) desc;

--42.	Find patients older than 60 who have an Abnormal test result. 
select *from hospital_dataset
where age>60 and test_results='Abnormal';

--43.	Find the average billing amount for each admission type. 
select admission_type,avg(billing_amount)
from hospital_dataset
group by admission_type;






 














