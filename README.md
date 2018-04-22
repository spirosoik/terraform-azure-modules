Terraform modules for Azure
===========

This repo includes reusable modules for Azure for quick servers spin up with the followings:

This repo also shows a folder structure based on app and environment level. More specific:
`<app-name>/<level>` -> `example.com/production`, `example.com/staging` etc.


Modules
----------------------

- `docker_public_vm` - creates an Ubuntu VM which is provisioned with Ansible to setup it with Docker and docker-compose
- `virtual_network` - creates a Virtual network with two subnets, private and public
- `vm_storage` - create an Azure managed disk which can be attached in a VM.

VM Provisioning 
----------------------

The docker public vm uses Ansible [here](https://github.com/spirosoik/terraform-azure-modules/tree/master/ansible) to install the followings:
- Docker
- docker-compose

The provisioning uses terraform [remote-exec](https://www.terraform.io/docs/provisioners/remote-exec.html) in order to wait the machine to be started and [local-exec](https://www.terraform.io/docs/provisioners/local-exec.html) to run the ansible playbooks. 

In order to use the provisioner you should have installed the followings:

```
ansible-galaxy install angstwad.docker_ubuntu
ansible-galaxy install franklinkim.docker-compose
```

Also in 

Example 
-----

An example of modules and the recommended project structure can be found [here](https://github.com/spirosoik/terraform-azure-modules/tree/master/example.com)

## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (Apache license 2.0).