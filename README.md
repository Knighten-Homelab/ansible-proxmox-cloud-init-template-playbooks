# Ansible Proxmox Cloud-Init Templates Playbooks

A collection of Ansible playbooks to createProxmox Cloud-Init templates for various Linux distributions. These playbooks run *on* your Proxmox host; so either run them directly on the host or use Ansible to SSH into the host.

## Features
- **Checksum‑verified**: automatically fetches SHA512SUMS  
- **Package injection**: adds `qemu-guest-agent`, `net-tools`, `htop`, etc.  
- **Safe overwrite**: can destroy & recreate templates on demand  
- **Multi‑distro**: Debian & Ubuntu examples provided  

## Cloud‑Init Templates

| Distro                                 | Playbook Path   |
|----------------------------------------|-----------------|
| Debian 12 “Bookworm”                   | `debian-12/`    |
| Ubuntu 22.04 LTS “Jammy Jellyfish”     | `ubuntu-22-04/` |

## Example Usage

```bash
ansible-playbook \
  -i inventories/hosts.ini \
  create-pve-cloud-init-template.yml \
  -e host_group_var=proxmox-nodes \
  -e template_id=999 \
  -e public_key="$(< ~/.ssh/id_rsa.pub)" \
  -e overwrite_existing_template=true
```
