## Задача 1

+ Будет лучше использовать неизменяемую инфраструктуру, организованную через средства виртуализации, например, используя гипервизор от VmWare или общедоступные облачные провайдеры.
 
+ При такой организации инфраструктуры центральный сервер для управления не требуется, для vmware будет достаточно тонкого клиента, для облачных технологий Terraform.

+ Указано, что Ansible уже используется, значит агентов не будет

+ Управление конфигурацией будет осуществляться через Ansible

+ Для нового проекта планируется использовать Terraform, Docker, Kubernetes, Ansible. 

+ Из новых инструментов я рассмотрел бы gitlab на замену teamcity, и возможно, стоило бы добавить систему мониторинга zabbix, так как проект со временем будет разрастаться и за всем не уследишь.

## Задача 2
```
root@admin-vm:~# terraform -version
Terraform v1.2.7
on linux_amd64
```
## Задача 3
##### Создаеv каталоги для хранения bin-файлов и делаем символические ссылки для двух версий Terraform
```
root@admin-vm:~# ln -s /usr/local/tf127/terraform /usr/bin/terraform1_2_7
root@admin-vm:~# ln -s /usr/local/tf012/terraform /usr/bin/terraform012
root@admin-vm:~# chmod ugo+x /usr/bin/terraform*
```
##### Запускаем необходимую версию
```
root@admin-vm:~# terraform1_2_7 -version
Terraform v1.2.7
on linux_amd64
```
```
root@admin-vm:~# terraform012 -version
Terraform v0.12.31

Your version of Terraform is out of date! The latest version
is 1.2.7. You can update by downloading from https://www.terraform.io/downloads.html
```
