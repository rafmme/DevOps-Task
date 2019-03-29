#!/usr/bin/env bash

# to ensure the script terminate immediately it encounters an error
set -o pipefail

BLUE=`tput setaf 2`
GREEN=`tput setaf 4`
RESET=`tput sgr0`

# load the variables declared in the .env file into the shell
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

  # packer command to start the building of the AMI
  packer build packer.json

  # conditional statement to check if the command above failed
  if [ $? -gt 0 ]; then
       echo "Image <$TF_VAR_ami_name> build failed"
       exit 1
  else
       display_success_message "IMAGE <$TF_VAR_ami_name> BUILD WAS SUCCESSFUL"

       # function that handles creation of EC2 instance with Terraform
       create_instance
  fi
}

# function to create the instance after creating the AMI
function create_instance() {
    display_message $BLUE "CREATING EC2 INSTANCE"

    # this change directory to the ec2_build folder containing the terraform script
    cd ec2_build

    # terraform commands to initialize, make a plan and then  create the EC2 instance
    terraform init -input=false
    terraform plan -out=tfplan -input=false
    terraform apply -input=false tfplan
    display_success_message "INSTANCE CREATION DONE"
}

# the script starting point
function main () {
    build_ami_image
}


main
