# Домашнее задание к занятию "`Введение в Ansible`" - `Гущин Евгений`

### Задание 1

1. ![task2](../../img/16-Ansible/HW1/task1.png)  

`some_fact = 12`

2. Нашел переменную в `example.yml` и поменял это значение на "all default fact".

3. ![task2](../../img/16-Ansible/HW1/task3.png)  

4. ![task2](../../img/16-Ansible/HW1/task4.png)  

5. В group_vars поменял значение для deb — "deb default fact", для el — "el default fact"

6. ![task2](../../img/16-Ansible/HW1/task5.png)  

7. ![task2](../../img/16-Ansible/HW1/task7.png)  

8. ![task2](../../img/16-Ansible/HW1/task8.png)  

9. выбрал `ansible.builtin.ssh`

![task2](../../img/16-Ansible/HW1/task9.png) 

10. В prod.yml добавил
```yml
local:
  hosts:
    localhost:
      ansible_connection: ssh
```

11. `ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass --ask-pass` 
![task2](../../img/16-Ansible/HW1/task9.png) 
---




[Playbook](./playbook)

