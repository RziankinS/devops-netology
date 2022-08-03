## Задача 1

##### docker pull mysql:8.0
##### docker volume create vol1
##### docker run -e MYSQL_ROOT_PASSWORD=admin -ti -p 3306:3306 -v vol1:/etc/mysql/ mysql:8.0
##### docker ps
```
CONTAINER ID   IMAGE       COMMAND                  CREATED         STATUS         PORTS                                                  NAMES
863c85082633   mysql:8.0   "docker-entrypoint.s…"   3 minutes ago   Up 3 minutes   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   reverent_blackburn
```
##### docker cp test_dump.sql 863c85082633:/tmp
##### docker exec -it 863c85082633 bash
##### # mysql -u root -p -e "create database test_db";
##### # mysql -u root -p test_db < /tmp/test_dump.sql;
##### # mysql -u root -p
##### mysql> \s
```
--------------
mysql  Ver 8.0.30 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		15
Current database:	
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.30 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8mb4
Db     characterset:	utf8mb4
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/run/mysqld/mysqld.sock
Binary data as:		Hexadecimal
Uptime:			33 min 30 sec

Threads: 2  Questions: 45  Slow queries: 0  Opens: 141  Flush tables: 3  Open tables: 59  Queries per second avg: 0.022
--------------
```

##### mysql> use test_db;
```Database changed```
##### mysql> show tables;
```
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)
```
##### mysql> SELECT COUNT(*) FROM orders WHERE price > 300;
```
+----------+
| COUNT(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```
## Задача 2

##### mysql> create user 'test'@'localhost'
##### -> IDENTIFIED WITH mysql_native_password BY 'test-pass'
##### -> WITH MAX_CONNECTIONS_PER_HOUR 100
##### -> PASSWORD EXPIRE INTERVAL 180 DAY
##### -> FAILED_LOGIN_ATTEMPTS 3 
##### -> ATTRIBUTE '{"first_name":"James", "last_name":"Pretty"}';
```Query OK, 0 rows affected (0.01 sec)```

##### mysql> grant select on test_db.* to test@'localhost';
```Query OK, 0 rows affected, 1 warning (0.00 sec)```

##### mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER = 'test';
```
+------+-----------+------------------------------------------------+
| USER | HOST      | ATTRIBUTE                                      |
+------+-----------+------------------------------------------------+
| test | localhost | {"last_name": "Pretty", "first_name": "James"} |
+------+-----------+------------------------------------------------+
1 row in set (0.00 sec)
```
## Задача 3

##### mysql> SELECT table_schema,table_name,engine FROM information_schema.tables WHERE table_schema = DATABASE();
```
+--------------+------------+--------+
| TABLE_SCHEMA | TABLE_NAME | ENGINE |
+--------------+------------+--------+
| test_db      | orders     | InnoDB |
+--------------+------------+--------+
1 row in set (0.00 sec)
```
##### mysql> SET profiling = 1;

##### mysql> ALTER TABLE orders ENGINE = MyISAM;
```
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0
```
##### mysql> ALTER TABLE orders ENGINE = InnoDB;
```
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0
```
##### mysql> SHOW PROFILES;
```
+----------+------------+-----------------------------------------+
| Query_ID | Duration   | Query                                   |
+----------+------------+-----------------------------------------+
|        1 | 0.00014675 | SET profiling = 1			  |
|        2 | 0.01649550 | ALTER TABLE orders ENGINE = MyISAM      |
|        3 | 0.01868975 | ALTER TABLE orders ENGINE = InnoDB      |
+----------+------------+-----------------------------------------+
3 rows in set, 1 warning (0.00 sec)
```
## Задача 4
```
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

#IO Speed
innodb_flush_log_at_trx_commit = 0
#compression
innodb_file_format=Barracuda
#buffer
innodb_log_buffer_size	= 1M
#ram
innodb_buffer_pool_size=2G
#log_size
max_binlog_size	= 100M
#all_in_one
innodb_file_per_table = 1
```




