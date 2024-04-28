# Proxmox Setup Playbook

This Ansible playbook is designed to configure a Proxmox Virtual Environment node for initial deployment and secure its settings. The playbook sets up necessary package sources, user configurations, and optimizes system parameters.

## Playbook Description

This playbook includes the following tasks:

- **Set correct Proxmox VE sources**: Configures the APT sources for the Debian and Proxmox VE repositories.
- **Set no-bookworm-firmware configuration**: Disables warnings for non-free firmware updates.
- **Disable 'pve-enterprise' repository**: Disables the commercial enterprise repository.
- **Enable 'pve-no-subscription' repository**: Enables the free version of Proxmox repository.
- **Set 'ceph package repositories'**: (All entries are commented out by default).
- **Add 'pvetest' repository**: Adds the Proxmox VE test repository (disabled by default).
- **Update and dist-upgrade Proxmox VE**: Updates all packages to the latest versions.
- **Install sudo if not already installed**: Ensures sudo is installed.
- **Create a new user with a home directory if it does not exist**: Adds a new system user with home directory.
- **Set password for the user**: Sets or updates the user's password.
- **Ensure sudo can be used by the user without a password**: Configures sudoers to allow the new user to execute sudo without a password.
- **Copy SSH public key to Proxmox**: Adds a public SSH key to the new user's authorized keys.
- **Sysctl configurations for network, memory, and kernel optimizations**: Applies several sysctl settings to optimize the performance and security.
- **Configure and restart autofs**: Sets up autofs to manage NFS mounts.
- **Configure ZFS options**: Sets ZFS memory usage parameters based on system RAM.
- **Conditionally reboot the server**: Reboots the server if required by some configuration changes.

## Requirements

- Ansible 2.9 or higher.
- Root access to a Proxmox VE node.

## Usage

1. Update the variables in the playbook as per your environment's requirements, such as the IP addresses and user credentials.
2. Run the playbook using the following command:

    ```bash
    ansible-playbook -i hosts setup.yaml
    ```

## Variables

- `ansible_user`: The default user for SSH (typically 'root').
- `vault_username`: The username for the new user to be created.
- `vault_password`: The password for the new user.
- `nfs_server_ip`: IP address of the NFS server for storage configurations.
- `min_ram`: Minimum RAM for ZFS ARC in bytes.
- `default_max_ram`: Default maximum RAM for ZFS ARC in bytes.

## Handlers

- **restart chrony**: Restarts the Chrony service.
- **reload sysctl**: Reloads sysctl configuration files for network, memory, and kernel optimizations.
- **update initramfs**: Updates initramfs if ZFS configurations change.

## Note

Make sure to test the playbook in a development environment before running it in production. Adjust the playbook according to your system specifications and Proxmox VE version.
