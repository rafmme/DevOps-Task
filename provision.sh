#!/usr/bin/env bash

# function to install ansible
function add_ansible() {
    sudo apt-get update
    sudo apt-get install software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt-get install ansible -y
}

add_ansible
