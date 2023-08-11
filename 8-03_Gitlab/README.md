# Домашнее задание к занятию "`Что такое DevOps. СI/СD`" - `Гущин Евгений`

### Задание 1

![Go tests](img/Task1_1.png?raw=true)
![Go build results](img/Task1_2.png?raw=true)
![Build steps in Jenkins job](img/Task1_3.png?raw=true)


---

### Задание 2

```groovy
pipeline {
 agent any
 stages {
  stage('Git') {
   steps {git 'https://github.com/netology-code/sdvps-materials.git'}
  }
  stage('Test') {
   steps {
    sh '/usr/local/go/bin/go test .'
   }
  }
  stage('Build') {
   steps {
    sh 'docker build . -t ubuntu-bionic:8082/hello-world:v$BUILD_NUMBER'
   }
  }
 }
}
```
![Build results](img/Task2_1.png?raw=true "Build results")

---

### Задание 3

```
pipeline {
 agent any
 
 stages {
  stage('Git') {
   steps {git 'https://github.com/netology-code/sdvps-materials.git'}
  }
  stage('Test') {
   steps {
    sh '/usr/local/go/bin/go test .'
   }
  }
  stage('Build') {
   steps {
    sh 'CGO_ENABLED=0 GOOS=linux /usr/local/go/bin/go build -a -installsuffix nocgo -o ./hello_world .'
   }
  }
  stage('Upload to nexus') {
    steps{
      nexusArtifactUploader artifacts: [[artifactId: 'hello_world', classifier: '', file: 'hello_world', type: 'bin']], credentialsId: 'nexus-credentials', groupId: 'HW', nexusUrl: 'my-nexus:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'netology-hw', version: '$BUILD_NUMBER'  
    }
  }
 }
}
```

![Build steps results](img/Task3_1.png?raw=true)
![Nexus repo](img/Task3_2.png?raw=true)

### Задание 4 (со звездочкой*)


Чтобы каждый следующий запуск сборки присваивал имени файла новую версию можно добавить переменную `$BUILD_NUMBER` к названию файла
```
stage('Build') {
   steps {
    sh 'CGO_ENABLED=0 GOOS=linux /usr/local/go/bin/go build -a -installsuffix nocgo -o ./hello_world_v$BUILD_NUMBER .'
   }
  }
```

В моем случае это бесполезно потому, что при загрузке артефакта в репозиторий	 Нексуса, я уже использую `$BUILD_NUMBER` и в результате этого файлы в репе сгрупированы по номеру версии и имееют соответсвующий суффикс (на скриншоте выше это видно)

