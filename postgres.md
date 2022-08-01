## задача 1
```
docker pull postgres:13
docker volume create vol1       
vol1
docker run  -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -ti -p 5432:5432 -v vol1:/var/lib/postgresql/data postgres:13

# psql -U admin
```
+ Вывод списка бд:
##### admin=# \l
```
                             List of databases
   Name    | Owner | Encoding |  Collate   |   Ctype    | Access privileges
-----------+-------+----------+------------+------------+-------------------
 admin     | admin | UTF8     | en_US.utf8 | en_US.utf8 |
 postgres  | admin | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | admin | UTF8     | en_US.utf8 | en_US.utf8 | =c/admin         +
           |       |          |            |            | admin=CTc/admin
 template1 | admin | UTF8     | en_US.utf8 | en_US.utf8 | =c/admin         +
           |       |          |            |            | admin=CTc/admin
(4 rows)
```
+ Подключения к БД:
##### admin=# \c postgres
```
You are now connected to database "postgres" as user "admin".
```
+ Вывод списка таблиц:
##### postgres=# \dt
```
Did not find any relations
```
##### postgres=# \dtS
```
                  List of relations
   Schema   |          Name           | Type  | Owner
------------+-------------------------+-------+-------
 pg_catalog | pg_aggregate            | table | admin
 pg_catalog | pg_am                   | table | admin
 pg_catalog | pg_amop                 | table | admin
 pg_catalog | pg_amproc               | table | admin
 pg_catalog | pg_attrdef              | table | admin
 ...
 pg_catalog | pg_user_mapping         | table | admin
(62 rows)
```
+ Вывод описания содержимого таблиц:
##### postgres=# \dS+ pg_type
```
                                       Table "pg_catalog.pg_type"
     Column     |     Type     | Collation | Nullable | Default | Storage  | Stats target | Description
----------------+--------------+-----------+----------+---------+----------+--------------+-------------
 oid            | oid          |           | not null |         | plain    |              |
 typname        | name         |           | not null |         | plain    |              |
 typnamespace   | oid          |           | not null |         | plain    |              |
 typowner       | oid          |           | not null |         | plain    |              |
 typlen         | smallint     |           | not null |         | plain    |              |
 typbyval       | boolean      |           | not null |         | plain    |              |
 typtype        | "char"       |           | not null |         | plain    |              |
 typcategory    | "char"       |           | not null |         | plain    |              |
 typispreferred | boolean      |           | not null |         | plain    |              |
 typisdefined   | boolean      |           | not null |         | plain    |              |
 typdelim       | "char"       |           | not null |         | plain    |              |
 typrelid       | oid          |           | not null |         | plain    |              |
 typelem        | oid          |           | not null |         | plain    |              |
 typarray       | oid          |           | not null |         | plain    |              |
 typinput       | regproc      |           | not null |         | plain    |              |
 typoutput      | regproc      |           | not null |         | plain    |              |
 typreceive     | regproc      |           | not null |         | plain    |              |
 typsend        | regproc      |           | not null |         | plain    |              |
 typmodin       | regproc      |           | not null |         | plain    |              |
 typmodout      | regproc      |           | not null |         | plain    |              |
 typanalyze     | regproc      |           | not null |         | plain    |              |
 typalign       | "char"       |           | not null |         | plain    |              |
 typstorage     | "char"       |           | not null |         | plain    |              |
 typnotnull     | boolean      |           | not null |         | plain    |              |
 typbasetype    | oid          |           | not null |         | plain    |              |
 typtypmod      | integer      |           | not null |         | plain    |              |
 typndims       | integer      |           | not null |         | plain    |              |
 typcollation   | oid          |           | not null |         | plain    |              |
 typdefaultbin  | pg_node_tree | C         |          |         | extended |              |
 typdefault     | text         | C         |          |         | extended |              |
 typacl         | aclitem[]    |           |          |         | extended |              |
Indexes:
    "pg_type_oid_index" UNIQUE, btree (oid)
    "pg_type_typname_nsp_index" UNIQUE, btree (typname, typnamespace)
Access method: heap
```
+ Выход из psql
##### \q

## задача 2

##### psql -U admin
```
psql (13.7 (Debian 13.7-1.pgdg110+1))
Type "help" for help.
```
##### admin=# CREATE DATABASE test_database;
```CREATE DATABASE```
##### psql -U admin -f /tmp/test_dump.sql test_database
##### admin=# \c test_database
```You are now connected to database "test_database" as user "admin".```
##### test_database=# \dt
```        List of relations
 Schema |  Name  | Type  | Owner
--------+--------+-------+-------
 public | orders | table | admin
(1 row)
```
##### test_database=# analyze verbose orders;
```INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
```
##### test_database=# SELECT * FROM pg_stats WHERE tablename='orders';
 ```
 schemaname | tablename | attname | inherited | null_frac | avg_width | n_distinct | most_common_vals | most_common_freqs |                    histogram_bounds                                                                 											  | correlation | most_common_elems | most_common_elem_freqs | elem_count_histogram
------------+-----------+---------+-----------+-----------+-----------+------------+------------------+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------+-------------+-------------------+------------------------+----------------------
 public     | orders    | id      | f         |         0 |         4 |         -1 |                  |                   | {1,2,3,4,5,6,7,8}                                                                                                                                 |           1	|                   |                        |
 public     | orders    | title   | f         |         0 |        16 |         -1 |                  |                   | {"Adventure psql time",Dbiezdmin,"Log gossips","Me and my bash-pet","My little database","Server gravity falls","WAL never lies","War and peace"} |  -0.3809524 |                   |                        |
 public     | orders    | price   | f         |         0 |         4 |     -0.875 | {300}            | {0.25}            | {100,123,499,500,501,900}                                                                                                                         |   0.5952381 |                   |                        |
(3 rows)

Столбец: avg_width
 ```
## задача 3
##### test_database=# create table orders_1
##### test_database-# (check (price > 499))
##### test_database-# inherits (orders);
```CREATE TABLE```
##### test_database=# create table orders_2
##### test_database-# (check (price <=499))
##### test_database-# inherits (orders);
```CREATE TABLE```
##### select * from orders;
```
 id |        title         | price
----+----------------------+-------
  1 | War and peace        |   100
  2 | My little database   |   500
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  6 | WAL never lies       |   900
  7 | Me and my bash-pet   |   499
  8 | Dbiezdmin            |   501
(8 rows)
```
##### # \dt
```
         List of relations
 Schema |   Name   | Type  | Owner
--------+----------+-------+-------
 public | orders   | table | admin
 public | orders_1 | table | admin
 public | orders_2 | table | admin
(3 rows)
```
#### при создании таблицы необходимо было определить тип: partitioned table

## задача 4
##### # pg_dump -U admin test_database > /tmp/test_database.sql
##### # cd /tmp
##### # ls
```test_database.sql  test_dump.sql```

+ Для добавления уникальности значения столбца title можно установить ограничения целостности:
##### # ALTER TABLE orders ALTER COLUMN title SET NOT NULL; 
##### # ALTER TABLE orders ADD CONSTRAINT orders_title_key UNIQUE (title)
