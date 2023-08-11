# Домашнее задание к занятию "`GitLab`" - `Гущин Евгений`

### Задание 1

![Project](../img/Task8_2.png?raw=true)
![Runner](../img/Task8_1.png?raw=true)
![Runner2](../img/Task8_3.png?raw=true)
![Runner3](../img/Task8_4.png?raw=true)


---

### Задание 2

```yaml
stages:
  - static-analysis
  - test
  - build

test:
  stage: test
  image: golang:1.16
  script:
    - go test .

static-analysis:
  stage: static-analysis
  image:
    name: sonarsource/sonar-scanner-cli
    entrypoint: [""]
  variables:
  script:
    - sonar-scanner -Dsonar.projectKey=my_project -Dsonar.sources=. -Dsonar.host.url=http://http://158.160.3.26:9000 -Dsonar.login=sqp_e18a39c96a85d2095e9d64f7b2f80ca82f0ad004

build:
  stage: build
  image: docker:latest
  script:
    - docker build .
```
![Build results](../img/Task8_2_1.png?raw=true "Build results")
![Build results2](../img/Task8_2_2.png?raw=true "Build results 2")

---

### Задание 3 (со звездочкой*)

```yaml
stages:
  - static-analysis
  - build
  - test

test:
  stage: test
  only:
    changes:
      - "**/*.go"
  image: golang:1.16
  script:
    - go test .

static-analysis:
  stage: static-analysis
  image:
    name: sonarsource/sonar-scanner-cli
    entrypoint: [""]
  variables:
  script:
   - sonar-scanner -Dsonar.projectKey=my_project -Dsonar.sources=. -Dsonar.host.url=http://158.160.3.26:9000 -Dsonar.login=sqp_e18a39c96a85d2095e9d64f7b2f80ca82f0ad004

build:
  stage: build
  image: docker:latest
  script:
    - docker build .
```
