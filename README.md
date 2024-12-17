# rdb-intro: Introduction to Relational Database

## On a schema _very_ close to HR by Oracle DB
- https://github.com/oracle/db-sample-schemas

## Tested on these DBMS
- MySQL 9
- Oracle DB 21c
- PostgreSQL 14
- SQLite 3
- H2 2

## Database setup
- SQLite
  - Run setup.sql to (re)set data

- MySQL, Oracle, PostgreSQL
  - Run once once.sql as dba to create user/schema "hron"
  - Run setup.sql as "hron" to (re)set data

- H2
  - scripts: java -cp h2.jar org.h2.tools.RunScript -url jdbc:h2:./hron -script <script name>
  - server: java -cp h2.jar org.h2.tools.Server -baseDir .
