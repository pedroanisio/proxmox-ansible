#!/bin/bash

# Present menu to the user to run the Ansible playbook with an option for a dry run
# Script location: Root directory of the Proxmox playbook

clear  # Clears the terminal screen for a clean start

echo "Available Options:"
options=("Init" "Install Kernel Headers" "Install NVIDIA Drivers" "Run All" "Dry Run" "Quit")

select opt in "${options[@]}"; do
    case $opt in
        "Init")
            echo "Running initialization playbook..."
            ansible-playbook -i hosts.yaml pve-cluser-coma.yaml --ask-vault-pass
            ;;
        "Install Kernel Headers")
            echo "Running playbook to install kernel headers..."
            ansible-playbook -i hosts.yaml pve-cluser-coma.yaml
            ;;
        "Install NVIDIA Drivers")
            echo "Running playbook to install NVIDIA drivers..."
            ansible-playbook -i hosts.yaml pve-cluser-coma.yaml
            ;;
        "Run All")
            echo "Running all tasks..."
            ansible-playbook -i hosts.yaml pve-cluser-coma.yaml
            ;;
        "Dry Run")
            echo "Dry run selected. Commands to be executed:"
            echo "ansible-playbook -i hosts.yaml roles/pve-cluster-coma.yaml --ask-vault-pass --tags cluster_init"
            echo "ansible-playbook -i hosts.yaml roles/pve-cluster-coma.yaml --ask-vault-pass --tags setup_nfs"
            echo "ansible-playbook -i hosts.yaml roles/pve-cluster-coma.yaml --ask-vault-pass --tags kernel_headers"
            echo "ansible-playbook -i hosts.yaml roles/pve-cluster-coma.yaml --ask-vault-pass --tags addnvidia"              
            echo "ansible-playbook -i hosts.yaml roles/pve-cluster-universe.yaml --ask-vault-pass --tags cluster_init"
            echo "ansible-playbook -i hosts.yaml roles/pve-cluster-universe.yaml --ask-vault-pass --tags setup_nfs"
            echo "ansible-playbook -i hosts.yaml roles/pve-cluster-universe.yaml --ask-vault-pass --tags kernel_headers"            
            echo "ansible-playbook -i hosts.yaml roles/pve-cluster-universe.yaml --ask-vault-pass --tags addnvidia"                                 
            echo "ansible-playbook -i hosts.yaml roles/proxmox/tasks/kernel.yaml"
            echo "ansible-playbook -i hosts.yaml roles/proxmox/tasks/nvidia.yaml"
            echo "ansible-playbook -i hosts.yaml roles/proxmox/main.yaml"
            ;;
        "Quit")
            echo "Exiting..."
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done
