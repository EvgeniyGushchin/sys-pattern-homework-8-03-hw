# Домашнее задание к занятию "`Управление доступом`" - `Гущин Евгений`

### Задание 1

1. Создал пользовательский сертификат

2. Создал пользователя, контекст и проверил, что контекст появился

![task2](../../img/20-kuber/HW9/task1.png)  

3. Включил контроллер rbac

![task2](../../img/20-kuber/HW9/task2.png)

4. Создал роль [role.yaml](./role.yaml) 

![task2](../../img/20-kuber/HW9/task3.png)

5. Создал роль биндинг [rolebinding.yaml](./rolebinding.yaml) 

![task2](../../img/20-kuber/HW9/task4.png)

6. Переключил контекст и проверил, что доступно чтение списка подов и их логов

![task2](../../img/20-kuber/HW9/task5.png)

7. Также проверил, доступен ли пользователю user просмотр конфигурации пода

![task2](../../img/20-kuber/HW9/task6.png)

8. Проверил, что у польщователя нет прав на просмотр deployments и удаление подов

![task2](../../img/20-kuber/HW9/task7.png)