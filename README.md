# Ansible and Terraform demo

## Prerequisites

1. ansible
2. ansible-galaxy install anxs.postgresql
3. terraform
4. aws cli (with creds in ~/.aws)

## Infrastructure Deployment

```bash
1. cd terraform/env/$env_name
2. terraform init
3. terrorm apply
4. copy output into clipboard (instances hostnames)
```
## Postgresql deployment, databases restore, nginx configuration, users management (using Ansible)

1. Paste terraform outputs in ansible inventory files ansible/inventory/hosts
2. cd ansible
3. ansible-playbook -i inventory/$env_name common.yml
4. ansible-playbook -i inventory/$env_name db.yml
5. ansible-playbook -i inventory/$env_name web.yml

