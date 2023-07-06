-- Database: media

-- DROP DATABASE IF EXISTS media;

CREATE DATABASE media
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

GRANT TEMPORARY, CONNECT ON DATABASE media TO PUBLIC;

GRANT CREATE, CONNECT ON DATABASE media TO admin;

GRANT ALL ON DATABASE media TO postgres;

-- Table: public.employees

-- DROP TABLE IF EXISTS public.employees;

CREATE TABLE IF NOT EXISTS public.employees
(
    id integer NOT NULL DEFAULT nextval('"Employees_id_seq"'::regclass),
    first_name character(30) COLLATE pg_catalog."default" NOT NULL,
    last_name character(30) COLLATE pg_catalog."default" NOT NULL,
    hire_date date NOT NULL,
    hourly_salary double precision NOT NULL,
    title_id integer NOT NULL,
    manager_id integer,
    team integer,
    CONSTRAINT "Employees_pkey" PRIMARY KEY (id)
)

-- Table: public.hour_tracking

-- DROP TABLE IF EXISTS public.hour_tracking;

CREATE TABLE IF NOT EXISTS public.hour_tracking
(
    id integer NOT NULL DEFAULT nextval('"Hour_tracking_id_seq"'::regclass),
    employee_id integer NOT NULL,
    project_id integer NOT NULL,
    total_hours numeric NOT NULL,
    CONSTRAINT "Hour_tracking_pkey" PRIMARY KEY (id)
)

-- Table: public.projects

-- DROP TABLE IF EXISTS public.projects;

CREATE TABLE IF NOT EXISTS public.projects
(
    id integer NOT NULL DEFAULT nextval('projects_id_seq'::regclass),
    name character(30) COLLATE pg_catalog."default" NOT NULL,
    client character(30) COLLATE pg_catalog."default" NOT NULL,
    start_date date NOT NULL,
    deadline date NOT NULL,
    CONSTRAINT projects_pkey PRIMARY KEY (id)
)

-- Table: public.team_projects

-- DROP TABLE IF EXISTS public.team_projects;

CREATE TABLE IF NOT EXISTS public.team_projects
(
    id integer NOT NULL DEFAULT nextval('"Team_projects_id_seq"'::regclass),
    team_id integer NOT NULL,
    project_id integer NOT NULL,
    CONSTRAINT "Team_projects_pkey" PRIMARY KEY (id)
)

-- Table: public.teams

-- DROP TABLE IF EXISTS public.teams;

CREATE TABLE IF NOT EXISTS public.teams
(
    id integer NOT NULL DEFAULT nextval('teams_id_seq'::regclass),
    team_name character(30) COLLATE pg_catalog."default" NOT NULL,
    location character(85) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT teams_pkey PRIMARY KEY (id)
)

-- Table: public.titles

-- DROP TABLE IF EXISTS public.titles;

CREATE TABLE IF NOT EXISTS public.titles
(
    name character(30) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT titles_pkey PRIMARY KEY (name)
)




