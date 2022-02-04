# Useful Commands

* ansible version

## Reachable via ssh, after updating hosts file
* ansible all -m ping

## syntax check
* ansible-playbook playbook.yml --syntax-check

## pre run check on playbook.yml
* ansible-playbook playbook.yml --check

## run the playbook
* ansible-playbook playbook.yml

## run the playbook with parameters
* ansible-playbook playbook.yml --extra-vars "tags=4.0.4"

## encrypt a playbook if you want with ansible-vault
* ansible-vault encrypt playbook.yml

## After doing that, cat playbook.yml wouldn't help
* ansible-vault view playbook.yml

## run the encrypted playbook
* ansible-playbook new.yml --ask-vault-pass
