# Домашнее задание к занятию "`Микросервисы: подходы`" - `Гущин Евгений`

### Задание 1

В качестве обеспечения процесса разработки можно предложить следующие инструменты:

- Gitlab
- Yandex Lockbox + Yandex Key Management Service

**Gitlab** позволит:
- использовать систему контроля версий Git
- создавать репозиторий на каждый сервис
- запускать сборки по событию из системы контроля версий
- запускать сборки по кнопке с указанием параметров
- привязать настройки к каждой сборке
- создать шаблоны для различных конфигураций сборок
- использовать несколько конфигураций для сборки из одного репозитория
- внедрять кастомные шаги при сборке
- хранить собственные докер-образы для сборки проектов
- развернуть агентов сборки на собственных серверах
- параллельно запускать несколько сборок
- параллельно запускать тесты

**Yandex Lockbox + Yandex Key Management Service** позволит:
- безопасно хранить серктеные данные


Как вариант вместо Gitlab можно использовать как репозиторий GitHub или Bitbucket, тогда управление CI/CD процессом можно возложить на Jenkins. 
В качестве хранилища для секретных данных можно было бы использовать **Hashicorp Vault**, но только если ваш проект за пределами РФ, в противном случае можно исползовать **Deckhouse Stronghold**.


### Задание 2

Для мониторинга можно воспользоваться ELK стеком.

Logstash:

- сбор логов в центральное хранилище со всех хостов, обслуживающих систему;
- минимальные требования к приложениям, сбор логов из stdout;
- гарантированная доставка логов до центрального хранилища;

Elasticsearch:
- обеспечение поиска и фильтрации по записям логов;

Kibana:
- обеспечение пользовательского интерфейса с возможностью предоставления доступа разработчикам для поиска по - записям логов;
- возможность дать ссылку на сохранённый поиск по записям логов.


### Задание 3

Для организации мониторинга можно воспользоваться связкой **Prometheus + Grafana**

Prometheus позволит собирать данные и хранить их во встроенной TSDB.
Для сбора данных с обычных хостов на них потребуется установить **Node Exporter**, а для мониторинга докер контейнеров потребуется **cAdvisor**.

Grafana предоставит удобной UI с возжмонстью создания собственных дашбордов и тонкой настройкой информационных панелей. Grafana позволяет делать сложные запросы и предоставлять информацию в агрегированном виде. 
Также можно воспользоваться встройнной в Grafana системой оповещения, для нотификации о выходе контроллируемых параметров за пороговые значения. Если возможностей встроенного механизма оповещенеий будет недостаточно, то можно воспользоваться **AlertManager** 
