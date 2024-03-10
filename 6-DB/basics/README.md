# Домашнее задание к занятию "6.1. Типы и структура СУБД"

## Задача 1

Архитектор ПО решил проконсультироваться у вас, какой тип БД 
лучше выбрать для хранения определенных данных.

Он вам предоставил следующие типы сущностей, которые нужно будет хранить в БД:

- Электронные чеки в json виде
- Склады и автомобильные дороги для логистической компании
- Генеалогические деревья
- Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации
- Отношения клиент-покупка для интернет-магазина

Выберите подходящие типы СУБД для каждой сущности и объясните свой выбор.

1. Для хранения данных в формате json хорошо подойдет документориентированная БД, например, MongoDB.
2. Для задачи оптимизации логистики хорошо подойдет графовая БД, например, Neo4j.
3. Для генеалогических деревьев можно было бы использовать как графовую БД, так и документориентированную в зависимости от того, какие ограничнения будут в нашей системе.
4. Для кэширования данных можно исподьщовать БД ключ-значение, например, Memcached или Redis, которые позволяют устанавливать время жизни данных
5. Для магазина я бы взял реляционную БД MySQL или PostgresSQL. 

## Задача 2

Вы создали распределенное высоконагруженное приложение и хотите классифицировать его согласно 
CAP-теореме. Какой классификации по CAP-теореме соответствует ваша система, если 
(каждый пункт - это отдельная реализация вашей системы и для каждого пункта надо привести классификацию):

- Данные записываются на все узлы с задержкой до часа (асинхронная запись)
- При сетевых сбоях, система может разделиться на 2 раздельных кластера
- Система может не прислать корректный ответ или сбросить соединение

А согласно PACELC-теореме, как бы вы классифицировали данные реализации?

1. Система доступна и устойчива к разделению - PA. Так как есть задержка в записи на все узлы, то в какой-то момент данные неконсистентны, но доступны для чтения - PA/EС
2. Система доступна и устойчива к разделению, но не консистетна так как данные в кластерах могут отличаться - СA. PA/EL - 2 раздельных кластера явно ухудшают консистентность в угоду доступности
3. Система обеспечивает консистентность данных, но теряет доступность в случае когда теряет связь с частью узлов - СP. PC/EC максимальная консистентность данных, не присылает клиенту ответ в угоду Latency


## Задача 3

Могут ли в одной системе сочетаться принципы BASE и ACID? Почему?

Не могут. Так как в одном случае делается упор на надежность и предсказуемость, а в другом на производительность. Могут существовать БД, которые могут обладать определенными свойствами, характерными для другой системы, но полного соответсвия достичь невозможно.

## Задача 4

Вам дали задачу написать системное решение, основой которого бы послужили:

- фиксация некоторых значений с временем жизни
- реакция на истечение таймаута

Вы слышали о key-value хранилище, которое имеет механизм [Pub/Sub](https://habr.com/ru/post/278237/). 
Что это за система? Какие минусы выбора данной системы?

Ключ-значение + механизм Pub/Sub - скорей всего речь идет о Redis.

Механизм Pub/Sub - издатель-подписчик в этом механизме сообщения публикуются в каналы, подписчики могут подписываться на один или несколько каналов для получения сообщения. Издатель события и получатель не контактируют напрямую и не обмениваются запросами. Так же этот механизм никак не связан с пространством ключей.

Минусы:
- Возможны проблемы с масштабируемостью при увеличении нагрузки, в случае с Redis это связанно с однопоточностью
- сообщение может быть потеряно и необработано, если подписчик не готов его принять
- при сбое можно потерять данные, если они не попали в очередной снапшот