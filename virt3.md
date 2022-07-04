## Задача 1
```
https://hub.docker.com/r/rziankins/test
```
## Задача 2
```
*Высоконагруженное монолитное java веб-приложение - виртуальный или физический сервер (нет необходимости создавать контейнеры) 
*Nodejs веб-приложение - Docker простота развертывания приложения, не требует много ресурсов, масштабирование.
*Мобильное приложение c версиями для Android и iOS - Docker быстрое развёртывание и лёгкость масштабирование приложения.
*Шина данных на базе Apache Kafka - Docker необходимость во множестве контейнеров
*Elasticsearch кластер для реализации логирования продуктивного веб-приложения - виртуальные сервера, требуется большое количество ресурсов
*Мониторинг-стек на базе Prometheus и Grafana - Docker масштабируемость, лёгкость и скорость развёртывания.
*MongoDB, как основное хранилище данных для java-приложения - виртуальный сервер из-за возможности гибкого распределения ресурсов и хороший вариант в плане бэкапа данных 
*Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry - физические или виртуальные сервера для обеспечения безопасноти и сохранности данных
```
## Задача 3
```
PS C:\users\sergei\docker\nginx> docker run -v /data:/data -dt centos 
baf94a6583cbe3cecc3ee0d7496263d970f3f71964d7389beb9a76942fcb35f4
PS C:\users\sergei\docker\nginx> docker run -v /data:/data -dt debian
88909b1ad428bf8007bfca1ef312549c745df7fd9f37bcef41ed3ea9c73aeafa
PS C:\users\sergei\docker\nginx> docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
88909b1ad428   debian    "bash"        2 minutes ago    Up 2 minutes              infallible_chaplygin
baf94a6583cb   centos    "/bin/bash"   10 minutes ago   Up 10 minutes             intelligent_kepler

PS C:\users\sergei\docker\nginx> docker exec -it intelligent_kepler /bin/bash
[root@baf94a6583cb /]# echo 'test cenos baf94a6583cb' > /data/test
[root@baf94a6583cb /]# cat /data/test
test centos baf94a6583cb
[root@baf94a6583cb /]# exit
exit

PS C:\users\sergei\docker\nginx> docker exec -it infallible_chaplygin /bin/sh
# cat /data/test
test centos baf94a6583cb
# exit

PS C:\users\sergei\docker\nginx> docker exec -it intelligent_kepler /bin/bash
[root@baf94a6583cb /]# mkdir /data/for_debian
[root@baf94a6583cb /]# exit
exit

PS C:\users\sergei\docker\nginx> docker exec -it infallible_chaplygin /bin/sh
# cd /data
# ls -la
total 8
drwxr-xr-x 3 root root   80 Jul  4 07:41 .
drwxr-xr-x 1 root root 4096 Jul  4 07:31 ..
drwxr-xr-x 2 root root   40 Jul  4 07:41 for_debian
-rw-r--r-- 1 root root   24 Jul  4 07:36 test
# exit
```
