
--  Retrieve the team names and their corresponding project count.
Select teams.team_name, Count(*) as number_project 
from team_projects
inner join teams on teams.id = team_projects.team_id
Group by teams.team_name

-- Retrieve the projects managed by the managers whose first name starts with "J" or "D".

select distinct employees.first_name, employees.last_name, employees.manager_id, team_projects.team_id, team_projects.project_id, projects.name
from employees
left join team_projects on team_projects.team_id = employees.team 
left join projects on team_projects.project_id = projects.id
where manager_id is not null and (first_name Like 'J%' or first_name like 'D%') 
order by employees.first_name asc;

--  Retrieve all the employees (both directly and indirectly) working under Andrew Martin

with recursive emp_hierarchy as (
	Select first_name, last_name, manager_id, title_id, id
	from employees
	where manager_id = (Select id 
						from employees 
						where first_name = 'Andrew' and 
						last_name = 'Martin')
Union all
	
	Select e.first_name, e.last_name, e.manager_id, e.title_id, e.id
	from employees e, emp_hierarchy emp_hie
	where e.manager_id = emp_hie.id	

)

select * from emp_hierarchy

--  Retrieve all the employees (both directly and indirectly) working under Robert Brown

with recursive emp_hierarchy as (
	Select first_name, last_name, manager_id, title_id, id
	from employees
	where manager_id = (Select id 
						from employees 
						where first_name = 'Robert' and 
						last_name = 'Brown')
Union all
	
	Select e.first_name, e.last_name, e.manager_id, e.title_id, e.id
	from employees e, emp_hierarchy emp_hie
	where e.manager_id = emp_hie.id	

)

select * from emp_hierarchy

--  Retrieve the average hourly salary for each title.
select avg(hourly_salary) as Average_Pay, title_id
from employees
group by title_id
order by title_id asc

--  Retrieve the employees who have a higher hourly salary than their respective team's average hourly salary.
with avg_salary_table as (select avg(hourly_salary) as Average_Pay, title_id
from employees
group by title_id
order by title_id asc)

Select e.first_name, e.last_name, e.title_id, e.hourly_salary, ast.Average_Pay
from employees e
right join avg_salary_table ast on ast.title_id = e.title_id
where e.hourly_salary > (Select Average_Pay from avg_salary_table ast where ast.title_id = e.title_id)


--  Retrieve the projects that have more than 3 teams assigned to them.

select count(team_id) as number_of_teams, project_id from team_projects
group by project_id
having count(team_id)>3
order by project_id asc


--  Retrieve the total hourly salary expense for each team.

select sum(hourly_salary) as hourly_team_expense, team
from employees
group by team
order by team asc


