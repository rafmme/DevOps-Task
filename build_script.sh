#!/usr/bin/env bash

set -o pipefail

BLUE=`tput setaf 2`
GREEN=`tput setaf 4`
RESET=`tput sgr0`

source .env

# a function to display a message of what action is going on
function display_message() {
    echo "        "
    echo -e "${1} ## ${2} ## ${RESET}"
    echo "        "
}

# a function to display completion message when an action is complete
function display_success_message() {
    echo "        "
    echo -e "${GREEN} *** ${1} *** ${RESET}"
    echo "        "
}

# function to build the AMI
function build_ami_image() {
  display_message $BLUE "BUILDING IMAGE <$TF_VAR_ami_name>"
  packer build packer.json

  if [ $? -gt 0 ]; then
       echo "Image <$TF_VAR_ami_name> build failed"
       exit 1
  else
       display_success_message "IMAGE <$TF_VAR_ami_name> BUILD WAS SUCCESSFUL"
       create_instance
  fi
}

# function to create the instance after creating the AMI
function create_instance() {
    display_message $BLUE "CREATING EC2 INSTANCE"
    cd ec2_build
    terraform init -input=false
    terraform plan -out=tfplan -input=false
    terraform apply -input=false tfplan
    display_success_message "INSTANCE CREATION DONE"
}

build_ami_image
