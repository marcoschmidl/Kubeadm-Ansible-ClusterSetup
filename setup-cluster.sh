#!/bin/bash

# Define the playbook files
PLAYBOOK1="/home/ubuntu/kubernetes/github-repo/Kubeadm-Ansible-ClusterSetup/kubeadm-playbooks/1-setup-user.yaml"
PLAYBOOK2="/home/ubuntu/kubernetes/github-repo/Kubeadm-Ansible-ClusterSetup/kubeadm-playbooks/2-setup-kube-dependencies.yaml"
PLAYBOOK3="/home/ubuntu/kubernetes/github-repo/Kubeadm-Ansible-ClusterSetup/kubeadm-playbooks/3-setup-master.yaml"
PLAYBOOK4="/home/ubuntu/kubernetes/github-repo/Kubeadm-Ansible-ClusterSetup/kubeadm-playbooks/4-join-worker.yaml"

# Define the inventory file
INVENTORY="/home/ubuntu/kubernetes/github-repo/Kubeadm-Ansible-ClusterSetup/inventory.yaml"

# Run the first playbook using ansible-playbook
ansible-playbook -K -i $INVENTORY $PLAYBOOK1

ansible-playbook -i $INVENTORY $PLAYBOOK2

ansible-playbook -i $INVENTORY $PLAYBOOK3

ansible-playbook -i $INVENTORY $PLAYBOOK4