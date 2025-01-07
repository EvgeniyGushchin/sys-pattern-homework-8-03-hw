# Домашнее задание к занятию "`Helm`" - `Гущин Евгений`

### Задание 1

1. Создал Chart [Chart.yaml](./my-chart/Chart.yaml)
2. Создал:
- Deployment [deployment.yaml](./my-chart/templates/deployment.yaml)
- Service [service.yaml](./my-chart/templates/service.yaml)

3. Создал 3 версии Values:
- [values.yaml](./my-chart/values.yaml)
- [values2.yaml](./values2.yaml)
- [values3.yaml](./values3.yaml)

4. Проверил Chart 

![task2](../../img/20-kuber/HW10/task1_3.png)

### Задание 2

1. Создал необходимые namespaces

2. Установил чарты

![task2](../../img/20-kuber/HW10/task2_1.png)

3. Проверил, что чарты стартовали

![task2](../../img/20-kuber/HW10/task2_2.png)

3. Проверил, что работают деплойменты и поды

![task2](../../img/20-kuber/HW10/task2_3.png)
![task2](../../img/20-kuber/HW10/task2_4.png)