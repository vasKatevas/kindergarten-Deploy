# kindergarten-Deploy

Deployment scripts for: [kindergarten-Internal](https://github.com/vasKatevas/kindergarten-Internal) and [kindergarten-External](https://github.com/vasKatevas/kindergarten-External) 

Clone the above repositories

## Docker Compose

``` bash
cd kindergarten-Internal 
docker build -t kindergarten-internal -f Dockerfile .
docker build -t kindergarten-db -f sql.Dockerfile .
docker build -t kindergarten-nginx -f nginx.Dockerfile .
cd ../kindergarten-External
docker build -t kindergarten-external .
cd ..
docker-compose up
```
## Docker with ansible

Generate ssh key
``` bash 
ssh-keygen -f .ssh/rsa_deploy -t rsa
```
add the text below to ~/.ssh/config

```vim
Host app01
  HostName deployment ip address
		user azureuser
		IdentityFile ~/.ssh/rsa_deploy
```
or edit hosts.yml and replace or delete app01 from the commands below. If you want to deploy to every server on your hosts.yml you need to also delete -l from the commands
ansible commands: 
``` bash
ansible-galaxy install geerlingguy.docker
ansible-galaxy install geerlingguy.pip
cd ansible/ && ansible-playbook -i hosts.yml -l app01 install-requirements.yml
ansible-playbook -i hosts.yml -l app01 clone-repos.yml
ansible-playbook -i hosts.yml -l app01 build-run.yml
```

## Ansible without docker

Do everything except the ansible commands from the "ansible with docker"

```bash
ansible-galaxy install geerlingguy.mysql
ansible-galaxy install geerlingguy.pip
cd ansible/ && ansible-playbook -i hosts.yml -l app01 install-requirements-non-docker.yml
ansible-playbook -i hosts.yml -l app01 clone-repos.yml
ansible-playbook -i hosts.yml -l app01 build-run-non-docker.yml
ansible-playbook -i hosts.yml -l app01 testing.yml
```
## For jenkins use the preferred Jenkinsfile

For more details visit: https://www.jenkins.io/doc/book/pipeline/getting-started/
