## 1. sparse файлы
```
файлы, где логический вес файла не равен физическому
файлы, которые при записи на физ носитель, сокращают свой размер посредствам пропуска нулевых байт, оставляя только запись о наличии этих нулевых байтах.
В случаи изменения файла, данные сохраняются вместо записей о нулевых байтах.
```
## 2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?
```
Нет не могут, так как хардлинк ссылается на один файл и имеет одинаковый inode
```
## 3. создание новую вм с двумя дополнительными неразмеченными дисками по 2.5 Гб
```
vagrant@vagrant:~$ lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop1                       7:1    0 55.4M  1 loop /snap/core18/2128
loop2                       7:2    0 70.3M  1 loop /snap/lxd/21029
loop3                       7:3    0 55.5M  1 loop /snap/core18/2284
loop4                       7:4    0 43.6M  1 loop /snap/snapd/14978
loop5                       7:5    0 61.9M  1 loop /snap/core20/1361
loop6                       7:6    0 67.9M  1 loop /snap/lxd/22526
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    1G  0 part /boot
└─sda3                      8:3    0   63G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm  /
sdb                         8:16   0  2.5G  0 disk
sdc                         8:32   0  2.5G  0 disk
```
## 4. разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство
```
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Device       Start     End Sectors  Size Type
/dev/sdb1     2048 4196351 4194304    2G Linux filesystem
/dev/sdb2  4196352 5242846 1046495  511M Linux filesystem
```
## 5. перенесите данную таблицу разделов на второй диск
```
root@vagrant:~# sfdisk -d /dev/sdb | sfdisk /dev/sdc

>>> Created a new GPT disklabel (GUID: AB2787BD-DD8E-3C44-9EB8-1A1D5271E11D).
/dev/sdc1: Created a new partition 1 of type 'Linux filesystem' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux filesystem' and of size 511 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: gpt
Disk identifier: AB2787BD-DD8E-3C44-9EB8-1A1D5271E11D

Device       Start     End Sectors  Size Type
/dev/sdc1     2048 4196351 4194304    2G Linux filesystem
/dev/sdc2  4196352 5242846 1046495  511M Linux filesystem

root@vagrant:~# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop1                       7:1    0 55.4M  1 loop /snap/core18/2128
loop2                       7:2    0 70.3M  1 loop /snap/lxd/21029
loop3                       7:3    0 55.5M  1 loop /snap/core18/2284
loop4                       7:4    0 43.6M  1 loop /snap/snapd/14978
loop5                       7:5    0 61.9M  1 loop /snap/core20/1361
loop6                       7:6    0 67.9M  1 loop /snap/lxd/22526
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    1G  0 part /boot
└─sda3                      8:3    0   63G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm  /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
└─sdb2                      8:18   0  511M  0 part
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
└─sdc2                      8:34   0  511M  0 part
```
## 6. создание RAID1 на паре разделов 2 Гб.
```
root@vagrant:~# mdadm --create --verbose /dev/md1 -l 1 -n 2 /dev/sd{b1,c1}
```
## 7. создание RAID0 на второй паре маленьких разделов
```
root@vagrant:~# mdadm --create --verbose /dev/md2 -l 0 -n 2 /dev/sd{b2,c2}
root@vagrant:~# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop1                       7:1    0 55.4M  1 loop  /snap/core18/2128
loop2                       7:2    0 70.3M  1 loop  /snap/lxd/21029
loop3                       7:3    0 55.5M  1 loop  /snap/core18/2284
loop4                       7:4    0 43.6M  1 loop  /snap/snapd/14978
loop5                       7:5    0 61.9M  1 loop  /snap/core20/1361
loop6                       7:6    0 67.9M  1 loop  /snap/lxd/22526
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    1G  0 part  /boot
└─sda3                      8:3    0   63G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md1                     9:1    0    2G  0 raid1
└─sdb2                      8:18   0  511M  0 part
  └─md2                     9:2    0 1017M  0 raid0
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md1                     9:1    0    2G  0 raid1
└─sdc2                      8:34   0  511M  0 part
  └─md2                     9:2    0 1017M  0 raid0
```
## 8. 2 независимых PV на получившихся md-устройствах
```
root@vagrant:~# pvcreate /dev/md1
  Physical volume "/dev/md1" successfully created.
root@vagrant:~# pvcreate /dev/md2
  Physical volume "/dev/md2" successfully created.
```
## 9. общая volume-group на этих двух PV
```
root@vagrant:~# vgcreate vg01 /dev/md1 /dev/md2
  Volume group "vg01" successfully created
```
## 10. создание LV размером 100 Мб, указав его расположение на PV с RAID0
```
root@vagrant:~# lvcreate -L 100M -n lv01 vg01 /dev/md2
  Logical volume "lv01" created
```
## 11. mkfs.ext4 ФС на получившемся LV
```
root@vagrant:~# mkfs.ext4 /dev/vg01/lv01
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```
## 12. монтирование раздела в директорию /tmp/new
```
root@vagrant:~# mkdir /tmp/new
root@vagrant:~# mount /dev/vg01/lv01 /tmp/new
```
## 13. копирование тестового файла
```
wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
root@vagrant:~# ls -lha /tmp/new
total 22M
drwxr-xr-x  3 root root 4.0K Mar  4 11:12 .
drwxrwxrwt 12 root root 4.0K Mar  4 11:08 ..
drwx------  2 root root  16K Mar  4 11:06 lost+found
-rw-r--r--  1 root root  22M Mar  4 10:02 test.gz
```
## 14. lsblk
```
root@vagrant:~# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop1                       7:1    0 55.4M  1 loop  /snap/core18/2128
loop2                       7:2    0 70.3M  1 loop  /snap/lxd/21029
loop3                       7:3    0 55.5M  1 loop  /snap/core18/2284
loop4                       7:4    0 43.6M  1 loop  /snap/snapd/14978
loop5                       7:5    0 61.9M  1 loop  /snap/core20/1361
loop6                       7:6    0 67.9M  1 loop  /snap/lxd/22526
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    1G  0 part  /boot
└─sda3                      8:3    0   63G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md1                     9:1    0    2G  0 raid1
└─sdb2                      8:18   0  511M  0 part
  └─md2                     9:2    0 1017M  0 raid0
    └─vg01-lv01           253:1    0  100M  0 lvm   /tmp/new
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md1                     9:1    0    2G  0 raid1
└─sdc2                      8:34   0  511M  0 part
  └─md2                     9:2    0 1017M  0 raid0
    └─vg01-lv01           253:1    0  100M  0 lvm   /tmp/new
```
## 15. проверка целостности файла
```
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0 - все ок
```
## 16. перемещение содержимого PV с RAID0 на RAID1
```
root@vagrant:~# pvmove /dev/md2 /dev/md1
  /dev/md2: Moved: 8.00%
  /dev/md2: Moved: 100.00%
```
## 17. fail на устройство в RAID1
```
root@vagrant:~# mdadm --fail /dev/md1 /dev/sdc1
mdadm: set /dev/sdc1 faulty in /dev/md1
```
## 18. проверка состояния raid1
```
root@vagrant:~# dmesg |grep raid1
[114983.238554] md/raid1:md1: not clean -- starting background reconstruction
[114983.238555] md/raid1:md1: active with 2 out of 2 mirrors
[117339.118495] md/raid1:md1: Disk failure on sdc1, disabling device.
                md/raid1:md1: Operation continuing on 1 devices.
```
## 19. повторная проверка целостности файла
```
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0 - по прежнему все норм
```
## 20. vagrant destroy тестового хоста
```
C:\Users\Sergei>vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
```
