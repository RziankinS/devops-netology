## 1.	Какого типа команда cd
```
cd - встроенная программа, запускается и выполняется в текущем расположении.
Предположим "cd" внешняя программа, то,скорее всего, смена каталога в текущей оболочке не происходит, а открывается новое окружение и работает только там.
```
## 2. альтернатива команде grep <some_string> <some_file> | wc -l
```
grep <some_string> <some_file> -с
```
## 3. Какой процесс с PID 1 является родителем для всех процессов
```
pstree -p
systemd(1)
```
## 4. перенаправление вывода stderr ls на другую сессию терминала
```
ls /root 2>/dev/pts/1
```
## 5.одновременная передача команде файл на stdin и вывести ее stdout в другой файл
```
cat <test.txt >test1.txt
```
## 6. вывести данные из PTY в какой-либо из эмуляторов TTY
```
vagrant@vagrant:~$ echo 'Hello' > /dev/tty1
результат: если открыт превью в Oracle, то наблюдаем сообщение Hello
```
## 7. выполните команду bash 5>&1. К чему она приведет
```
bash 5>&1 - Создаст дескриптор с 5 и перенатправит его в stdout
echo netology > /proc/$$/fd/5 - выведет в дескриптор "5", который был пернеаправлен в stdout
```	
## 8. получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty
```
ls % 3>&2 2>&1 1>&3 | wc -l
1
```
## 9.	команда cat /proc/$$/environ
```
cat /proc/$$/environ
выводит переменные окружение. Можно посмотреть командой env
```
## 10. /proc/<PID>/cmdline и /proc/<PID>/exe
```
/proc/$pid/cmdline — содержит параметры командной строки, переданные на этапе запуска процесса
/proc/$pid/exe — является ссылкой на исполненный бинарный файл
```
## 11. старшая версия набора инструкций SSE
```
@vagrant:~$ cat /proc/cpuinfo | grep sse
поддержка sse версии 4_2
```	
## 12. открытие нового окна терминала и vagrant ssh
```
можно выполнить вход через: vagrant ssh -t
получаем новое подключение:
vagrant@vagrant:~$ tty
/dev/pts/1

имеющееся подключение:
vagrant@vagrant:~$ tty
/dev/pts/2
```
## 13. переместить запущенный процесс из одной сессии в другую
```
@vagrant:~$ top
@vagrant:~$ bg
[1]+ top &
@vagrant:~$ jobs -l
[1]+ 15940 Stopped (signal)        top
@vagrant:~$ disown top
-bash: warning: deleting stopped job 1 with process group 15940
vvagrant@vagrant:~$ ps -a
    PID TTY          TIME CMD
  15940 pts/1    00:00:00 top

@vagrant:~$ tmux
@vagrant:~$ reptyr 15940
![top](https://user-images.githubusercontent.com/98005611/161374157-6a3813be-d01e-439c-945a-e60ca3a2f568.png)

```
## 14. команда tee
```
tee делает вывод из stdin в stdout, под правами администратора(sudo)
```
