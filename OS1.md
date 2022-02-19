## 1. Какой системный вызов делает команда cd
```
chdir("/tmp")
```

## 2.  Где находится база данных file на основании которой она делает свои догадки
```
через man file узнаем, что бд у файла является:
/usr/share/misc/magic.mgc
а через strace подтверждаем это:
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
```

## 3.	Cпособ обнуления открытого удаленного файла (чтобы освободить место на файловой системе)
```
vagrant@vagrant:~$ sudo lsof -p 1885
ping    1885 vagrant    1w   REG  253,0     5318 1048595 /home/vagrant/test (deleted)
vagrant@vagrant:~$ sudo cat /proc/1885/fd/1
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.020 ms
vagrant@vagrant:~$ kill 1885
процесс выключен, файл обнулился и удалился
```
## 4. Занимают ли зомби-процессы какие-то ресурсы в ОС	
```
Зомби процессы не занимают ресурсы в ОС, есть только запись в таблице процессов
```
## 5.	Утилита opensnoop
```
root@vagrant:~# sudo apt-get install bpfcc-tools linux-headers-$(uname -r)
root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
/usr/sbin/opensnoop-bpfcc
root@vagrant:~# /usr/sbin/opensnoop-bpfcc
PID    COMM               FD ERR PATH
831    vminfo              4   0 /var/run/utmp
639    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
639    dbus-daemon        20   0 /usr/share/dbus-1/system-services
639    dbus-daemon        -1   2 /lib/dbus-1/system-services
639    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
644    irqbalance          6   0 /proc/interrupts
644    irqbalance          6   0 /proc/stat
644    irqbalance          6   0 /proc/irq/20/smp_affinity
644    irqbalance          6   0 /proc/irq/0/smp_affinity
644    irqbalance          6   0 /proc/irq/1/smp_affinity
644    irqbalance          6   0 /proc/irq/8/smp_affinity
644    irqbalance          6   0 /proc/irq/12/smp_affinity
644    irqbalance          6   0 /proc/irq/14/smp_affinity
644    irqbalance          6   0 /proc/irq/15/smp_affinity
831    vminfo              4   0 /var/run/utmp
639    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
```

## 6. Какой системный вызов использует uname -a
```
uname()
Part of the utsname information is also accessible  via  /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.
```

## 7. Чем отличается последовательность команд через ; и через && в bash
```
; - разделитель, при помощи которого запускаются, последовательно, несколько команд
&& - оператор, выполнение последующей команды произойдет только при успешном выполнении предыдущей
использовать в bash && set -e не вижу смысла, так как вслучае ошибки в команде произойдет остановка сценария, что аналогично &&
```

## 8. Из каких опций состоит режим bash set -euxo pipefail
```
-e скрипт немедленно завершит работу, если любая команда выйдет с ошибкой.
-u проверяет инициализацию переменных в скрипте. Если переменной не будет, скрипт немедленно завершиться.  
-x печатает в стандартный вывод все команды перед их исполнением.
-o чтобы убедиться, что все команды в пайпах завершились успешно. 
set -euxo pipefail позволяет писать красивые и безопасные скрипты с автоматической обработкой ошибок
```

## 9.	-o stat для ps
```
Наиболее часто встречающийся статус - S*
Дополнительные символы к основной букве выводят расширенную информацию о процессе
```
