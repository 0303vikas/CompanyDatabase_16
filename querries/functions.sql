-- FUNCTION: public.track_working_hours(integer, integer, numeric)

-- DROP FUNCTION IF EXISTS public.track_working_hours(integer, integer, numeric);

CREATE OR REPLACE FUNCTION public.track_working_hours(
	arg_employee_id integer,
	arg_project_id integer,
	arg_total_hours numeric)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	if not exists (Select 1 
				   from employees e
				   where e.id = arg_employee_id) then 
		raise exception 'Employee does not exist.';
	elsif not exists (Select 1
					  from projects pi
					  where pi.id = arg_project_id) then
		raise exception 'Project does not exist.';
	elsif not exists (Select 1 
					  from team_projects tp 
					  where tp.project_id = arg_project_id and
					  		tp.team_id = (Select team 
										  from employees e 
										  where e.id = arg_employee_id)
					  ) then		
		raise exception 'Wrong employee or project.';
	else
		if (Select 1
			from hour_tracking ht
			where ht.employee_id = arg_employee_id and
		   		  ht.project_id = arg_project_id
		   ) then
		   Update hour_tracking ht 
		   set ht.total_hours = ht.total_hours + arg_total_hours 
		   where ht.employee_id = arg_employee_id and
		   		 ht.project_id = arg_project_id;
		else
			Insert into hour_tracking (employee_id, project_id, total_hours) values (arg_employee_id, arg_project_id, arg_total_hours);
		end if;
	end if;
end;
$BODY$;


-- FUNCTION: public.create_project_with_teams(character, character, date, date, integer[])

-- DROP FUNCTION IF EXISTS public.create_project_with_teams(character, character, date, date, integer[]);

CREATE OR REPLACE FUNCTION public.create_project_with_teams(
	arg_project_name character,
	arg_client_name character,
	arg_start_date date,
	arg_end_date date,
	arg_team_id integer[])
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
i integer;
begin
	if arg_team_id is not null then
		foreach i in array arg_team_id loop
			if not exists (Select 1 
						   from employees
						   where id = i)
						   then
						   raise exception 'NotFound: Employee with id: %', i;
			end if;
			end loop;
	end if;		
	Insert into projects (name, client, start_date, deadline)
	values(arg_project_name, arg_client_name, arg_start_date, arg_end_date);
	
	if not exists (Select 1
				   from projects ps
				   where ps.name = arg_project_name 
				   and ps.client = arg_client_name)
				   then
				   raise exception 'Project was not inserted in the table.';
	else
		if arg_team_id is not null then
			foreach i in array arg_team_id loop
				insert into team_projects (team_id, project_id)
				values (i, (Select id 
							from projects ps
						    where ps.name = arg_project_name 
				   			and ps.client = arg_client_name)
					   );
			end loop;
		end if;
	end if;
end;
$BODY$;

