# Домашнее задание к занятию "`Базы данных`" - `Гущин Евгений`

### Задание 1

```yml
Employees:
  id: PK, serial, smallint,
  First name: varchar(50),
  Middle name: varchar(50),
  Last name: varchar(50)

Job Title:
  id: PK, serial, mediumint,
  job_title_name: varchar(50)

Department Type:
  id: PK, serial, tinyint,
  department_type_name: varchar(50)

Department:
  id: PK, serial, tinyint,
  department_name: varchar(50),
  department_type_id: FK, tinyint

Region:
  id: PK, serial, tinyint,
  region_name: varchar(50)

Cities:
  id: PK, serial, smallint,
  region_id: FK, tinyint,
  city_name: varchar(50)

Address:
  id: PK, serial, integer,
  region_id: FK, tinyint,
  city_id: FK, smallint,
  street_1: varchar(255),
  street_2: varchar(50)

Branch:
  id: PK, serial, tinyint,
  branch_name: varchar(50),
  address_id: FK, integer

Employee Job:
  id: PK, serial, integer,
  employee_id: FK, smallint,
  job_title_id: FK, mediumint,
  department_id: FK, tinyint,
  branch_id: FK, tinyint,
  salary: numeric,
  start_date: date

Customer:
  id: PK, serial, smallint,
  customer_name: varchar(50)

Project:
  id: PK, serial, integer,
  customer_id: FK, smallint,
  project_name: varchar(100)

Project team:
  project_id: FK, integer
  employee_id: FK, smallint

```
