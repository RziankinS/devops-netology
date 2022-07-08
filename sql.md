## задача 1
```
docker-compose.yml:

version: '3'
services:
  postgres:
    image: postgres:12
    environment:
      POSTGRES_DB: "testbd"
      POSTGRES_USER: "admin"
      POSTGRES_PASSWORD: "admin"
      PGDATA: "/var/lib/postgresql/data/pgdata"
    volumes:
      - ./:/var/lib/postgresql/data
      - ./backup:/var/lib/postgresql/backup
    ports:
      - "5432:5432"
    restart: unless-stopped
	deploy:
      resources:
        limits:
          cpus: '1'
          memory: 4G
  pgadmin:
    container_name: pgadmin_container
    image: dpage/pgadmin4:6.11
    environment:
      PGADMIN_DEFAULT_EMAIL: "rziankins@mail.ru"
      PGADMIN_DEFAULT_PASSWORD: "admin"
      PGADMIN_CONFIG_SERVER_MODE: "False"
    volumes:
      - ./pgadmin:/var/lib/pgadmin
    ports:
      - "5050:80"
    restart: unless-stopped
```
```
docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS         PORTS                    NAMES
d9a1607e8eed   postgres:12   "docker-entrypoint.s…"   3 minutes ago   Up 3 minutes   0.0.0.0:5432->5432/tcp   docker-compose-app_postgres_1

docker volume ls
DRIVER    VOLUME NAME
local     docker-compose-app_backup
local     docker-compose-app_bd
```
## задача 2
```
testbd=# CREATE DATABASE test_db;
CREATE DATABASE

# export PGPASSWORD=admin && psql -h localhost -U admin test_db
psql (12.11 (Debian 12.11-1.pgdg110+1))
test_db=# CREATE USER "test-admin-user";
CREATE ROLE
```
```
test_db=# CREATE TABLE orders
test_db-# (
test_db(# id integer,
test_db(# name text,
test_db(# price integer
test_db(# );
CREATE TABLE
PRIMARY KEY - добавлен через PgAdmin

test_db=# CREATE TABLE clients
test_db-# (
test_db(# id integer PRIMARY KEY,
test_db(# фамилия text,
test_db(# страна text,
test_db(# заказ integer,
test_db(# FOREIGN KEY (заказ) REFERENCES orders (Id)
test_db(# );
CREATE TABLE

test_db=# \dt
        List of relations
 Schema |  Name   | Type  | Owner 
--------+---------+-------+-------
 public | clients | table | admin 
 public | orders  | table | admin 
(2 rows)
```
```
test_db=# \d orders
                  Table "public.orders"
    Column    |  Type   | Collation | Nullable | Default
--------------+---------+-----------+----------+---------
 id           | integer |           | not null |
 наименование | text    |           |          |
 цена         | integer |           |          |
Indexes:
    "id" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)

test_db=# \d clients
               Table "public.clients"
 Column  |  Type   | Collation | Nullable | Default
---------+---------+-----------+----------+---------
 id      | integer |           | not null |
 фамилия | text    |           |          |
 страна  | text    |           |          |
 заказ   | integer |           |          |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
```
```
test_db=# GRANT ALL PRIVILEGES ON DATABASE test_db TO "test-admin-user";
GRANT
test_db=# GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "test-admin-user";
GRANT
test_db=# GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO "test-admin-user";
GRANT
```
```
test_db=# CREATE USER "test-simple-user";
CREATE ROLE
test_db=# GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO "test-simple-user";
GRANT
 ```
## задача 3
```
test_db=#insert into orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
INSERT 0 5

test_db=# insert into clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
INSERT 0 5
```
```
test_db=# SELECT * FROM orders;
 
 id | наименование | цена 
----+--------------+------
  1 | Шоколад      |   10
  2 | Принтер      | 3000
  3 | Книга        |  500
  4 | Монитор      | 7000
  5 | Гитара       | 4000
(5 rows)

test_db=# select count (*) from orders;
 count 
-------
     5
(1 row)
```
```
test_db=# SELECT * FROM clients;

 id |       фамилия        | страна | заказ 
----+----------------------+--------+-------
  1 | Иванов Иван Иванович | USA    |
  2 | Петров Петр Петрович | Canada |
  3 | Иоганн Себастьян Бах | Japan  |
  4 | Ронни Джеймс Дио     | Russia |
  5 | Ritchie Blackmore    | Russia |
(5 rows)

test_db=# select count (*) from clients;
 count 
-------
     5
(1 row)
```
## задача 4
```
test_db=# update  clients set заказ = 3 where id = 1;
UPDATE 1
test_db=# update  clients set заказ = 5 where id = 3;
UPDATE 1
test_db=# update  clients set заказ = 4 where id = 2;
UPDATE 1
```
```
test_db=# select * from clients where заказ is not null;

 id |       фамилия        | страна | заказ 
----+----------------------+--------+-------
  1 | Иванов Иван Иванович | USA    |     3
  3 | Иоганн Себастьян Бах | Japan  |     5
  2 | Петров Петр Петрович | Canada |     4
(3 rows)
```
## задача 5
```
test_db=# EXPLAIN SELECT c.* FROM clients c JOIN orders o ON c.заказ = o.id;
                               QUERY PLAN
------------------------------------------------------------------------
 Hash Join  (cost=37.00..57.24 rows=810 width=72)
   Hash Cond: (c."заказ" = o.id)
   ->  Seq Scan on clients c  (cost=0.00..18.10 rows=810 width=72)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=4)
         ->  Seq Scan on orders o  (cost=0.00..22.00 rows=1200 width=4)
(5 rows)
```
```
Сканирует таблицы orders и clients и проверяет соответсвия хэшей заказов
cost - время обращения
rows - количество выводимых сток
width - длина строки в байтах
```
## задача 6
```
# export PGPASSWORD=admin && pg_dumpall -h localhost -U test-admin-user > /var/lib/postgresql/backup/test_db.sql

ls  /var/lib/postgresql/backup/
test_db.sql

Stopping docker-compose-app_postgres_1 ... done
```
```
docker run  -d -p 5432:5432 -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=test_db -v C:\Users\Sergei\docker\docker-compose-app\backup:/var/lib/postgresql/backup --name rest_sql postgres:12
20ab0d05375b78165b17fc0aef5b801639e7527aac7ce5af3588607

docker exec -it rest_sql bash
root@20ab0d05375b:/# ls /var/lib/postgresql/backup/
test_db.sql
```
```
root@20ab0d05375b:/# export PGPASSWORD=admin && psql -h localhost -U admin -f /var/lib/postgresql/backup/test_db.sql test_db

root@20ab0d05375b:/# psql -h localhost -U admin test_db
psql (12.11 (Debian 12.11-1.pgdg110+1))
Type "help" for help.

test_db=#
```
