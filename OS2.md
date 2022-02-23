## 1. unit-файл для node_exporter:
```
vagrant@vagrant:~$ cat /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network-online.target
[Service]
User=node_exporter
Group=node_exporter
Type=simple
EnvironmentFile=-/etc/default/cron
ExecStart=/usr/sbin/cron -f -P $EXTRA_OPTS
[Install]
WantedBy=multi-user.target

добавляем в автозагрузку: 
vagrant@vagrant:~$ sudo systemctl enable node_exporter
vagrant@vagrant:~$ sudo systemctl is-enabled node_exporter
enabled
```
## 2. node_exporter и вывод /metrics
```
node_cpu_seconds_total{cpu="0",mode="idle"} - время простоя
node_cpu_seconds_total{cpu="0",mode="system"} - время выполнения процессов, которые выполняются в режиме ядра
node_cpu_seconds_total{cpu="0",mode="user"} - время выполнения обычных процессов, которые выполняются в режиме пользователя
node_memory_MemTotal
node_memory_MemAvailable
node_memory_MemFree
node_filesystem_avail_bytes - свободное место на дисках
node_disk_io_time_seconds_total{} - загрузка диска
node_disk_write_time_ms{} - запись диска
node_disk_read_time_ms{} - чтение диска
node_network_receive_bytes_total{} - сетевой трафик
```
## 3. netdata
```
vagrant@vagrant:~$ sudo lsof -i :19999
COMMAND PID    USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
netdata 642 netdata    4u  IPv4  23865      0t0  TCP *:19999 (LISTEN)
netdata 642 netdata   48u  IPv4  65416      0t0  TCP vagrant:19999->_gateway:57703 (ESTABLISHED)
```
## 4. dmesg
```
да, система видит, что используется виртуализация
DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Booting paravirtualized kernel on KVM
systemd[1]: Detected virtualization oracle.
```
## 5. sysctl fs.nr_open
```
vagrant@vagrant:~$ sysctl fs.nr_open
fs.nr_open = 1048576 - значение по умолчанию на максимальное количество открытых дискрипторов
через: ulimit -n
ps: формулировка вопроса крайне не понятна!
```
## 6. Запуск долгоживущего процесса (например, sleep 1h)
```
root@vagrant:/# unshare -f --pid --mount-proc sleep 1h
root@vagrant:/# ps -e | grep sleep
     16 pts/1    00:00:00 sleep
root@vagrant:/# nsenter --target 16 --pid --mount ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   5476   596 pts/1    S+   10:10   0:00 sleep 1h
root           3  0.0  0.1   8892  3420 pts/1    R+   10:20   0:00 ps aux	 
```
## 7. Опасная команда - :(){ :|:& };:
```
:(){ :|:& };: - функция с именем ‘:‘, которая вызывает сама себя дважды: один раз на переднем плане и один раз в фоне. Она продолжает своё выполнение снова и снова, пока не закончатся ресурсы системы, после чего система начинает блокирование данной функции.
установив значение: ulimit -u 10 мы ограничим число процессов для пользователя и функция :(){ :|:& };: перестает крашить систему
```
