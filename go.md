## Задача 1
![](https://github.com/RziankinS/devops-netology/blob/c48ab12c56992c10b9811ce80f7613478d24005f/screen/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202022-08-23%2014-06-16.png)
## Задача 2
```Ознакомился```
## Задача 3
+ ##### 1. Перевод метров в футы
```go
package main

import "fmt"

func main() {
	var n int
	fmt.Print("Введите высоту в метрах: ")
	fmt.Scanf("%d", &n)
	feet := 3.28 * float32(n)
	fmt.Println("Длина в футах:", feet)
}
```
![](https://github.com/RziankinS/devops-netology/blob/e8992c6bcc93e4fc51735f5c8c1ac6fc59af2507/screen/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202022-08-23%2015-15-18.png)
+ ##### 2. Поиск наименьшего элемента в любом заданном списке,
```go
package main

import "fmt"

func main() {
	values := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}

	min := values[0]
	for _, v := range values {
		if v < min {
			min = v
		}
	}
	fmt.Println(min)
}
```
![](https://github.com/RziankinS/devops-netology/blob/bdc64531b6810bd347fd298dd218b6d772f61733/screen/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202022-08-23%2015-17-02.png)
+ ##### 3. Вывод числа от 1 до 100, которые делятся на 3
```go
package main

import "fmt"

func main() {
	for i := 1; i <= 100; i++ {
		if i%3 == 0 {
			fmt.Println(i)
		}
	}
}
```
![](https://github.com/RziankinS/devops-netology/blob/ee1127bbb1c5e6bb93540c9b463bd05956899fab/screen/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202022-08-23%2015-50-43.png)
