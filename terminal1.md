## 1. Выделенные ресурсы, по умолчанию, для вм
```
RAM:1024mb
CPU:1 cpu
HDD:64gb
video:4mb
```

## 2. Добавил оперативной памяти
```
config.vm.provider "virtualbox" do |v|
        v.memory = 2048
    end
```
## 3.	Ознакомление с разделами man bash
  ```
  Переменная, которой можно задать длину журнала history:

HISTFILESIZE - Максимальное количество строк, содержащихся в файле истории для сохранения (строка 649)
HISTSIZE - Число команд которые будут сохранены (строка 660); на (строке 1871) отображается статус переменной, на данный момент history-size не установлен

Директива ignoreboth в bash:
  
  ignoreboth - сокращение от ignorespace (не сохранять команды, которые начинаются с пробела) и ignoredups (не сохранять, если такая команда уже есть в истории)
```
## 4.	Значение {}
```
означают зарезервированные слова, список, список команд. Также обозначает тело функции.
В командах выполняет подстановку элементов из списка, к примеру при создании файла new_{a,b,c}, будет создано три файла с именами new_a, new_b и new_c
(строка 213)
```
## 5.	touch 100000 файлов
```
touch {000001..100000}.md 300000 файлов создать не получается, слишком длинный список аргументов.
```
## 6. Значение конструкции [[ -d /tmp ]]	
```
конструкция [[ -d /tmp ]] проверяет существование каталога /tmp и возвращает ответ 0(true) или 1(false)
```
## 8. type -a bash
```
vagrant@vagrant:~$ type -a bash
	bash is /usr/bin/bash
	bash is /bin/bash
vagrant@vagrant:~$ mkdir /tmp/new_path_directory/
vagrant@vagrant:~$ cp /bin/bash /tmp/new_path_directory/
vagrant@vagrant:~$ PATH=/tmp/new_path_directory/:$PATH
vagrant@vagrant:~$ type -a bash
	bash is /tmp/new_path_directory/bash
	bash is /usr/bin/bash
	bash is /bin/bash
```
## 9. Отличия batch и at
```
at — команда запускается в указанное время.
batch - выполняет команды, когда позволяют уровни загрузки системы, когда среднее значение нагрузки падает ниже 1,5

установка:
sudo apt update
sudo apt install at
```
## 10.В ыключение вм через команду:
```
vagrant halt
```
