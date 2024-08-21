# Vector Role 

## Description

Deploy Vector using Ansible.

## Requirements

- Ansible >= 2.10 (It might work on previous versions, but we cannot guarantee it)

- ## Role Variables

- All variables which can be overridden are stored in [defaults/main.yml](defaults/main.yml) file as well as in table below.

## Example Playbook

```yaml
---
- hosts: all
  roles:
  - vector
  vars:
    vector_version: "0.39.0"
    vector_arch: "amd64"
```
