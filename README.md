# PostgreSQL Practice Assignment

This practice assignment is designed to help you practice various PostgreSQL clauses, constraints, joins, subqueries, and aggregations using the provided database schema.

## Database Schema

The database schema for this assignment consists of the following tables:

- titles: stores the different titles available for employees.
- employees: stores employee information, including their titles and managers.
- teams: stores team information, including team names and locations.
- projects: stores project information, including project names, clients, start dates, deadlines.
- team_project: a joining table for the many-to-many relationship between teams and projects.
- hour_tracking: tracks the total working hours of employees on various projects, including employee_id, project_id, total_hours

## Folder structure

.
├── data
│ ├── employees.csv
│ ├── hour_tracking.csv
│ ├── projects.csv
│ ├── team_project.csv
│ ├── teams.csv
│ └── titles.csv
├── querries
│ ├── createDatabase.sql
│ ├── functions.sql
│ └── retrieval.sql
└── README.md
