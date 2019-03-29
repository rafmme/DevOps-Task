# Provisioning an AMI with Packer & Ansible and Creation of an EC2 Instance with Terraform.

## Introduction
This repository contains scripts that would enable you minimally provision an AMI containing a React Project and deployment to an EC2 instance created with Terraform.



### Technology and Platforms Used

- [Packer](https://www.packer.io/docs/index.html) 
- [Ansible](https://docs.ansible.com/ansible/latest/index.html)
- [Terraform](https://www.terraform.io/docs/index.html)
- [AWS](aws.amazon.com)
- [NGINX](https://www.nginx.com/)

### How to Build the Amazon Machine Image (AMI) for your deployment

In the root directory of this project, you will see a file named `packer.json`, that is where the config file packer will use to build the machine image.

In order to create the machine image on AWS, please do the following:
- export the AWS_ACCESS_KEY, AWS_SECRET_KEY & other important env variables as shown in the .env.sample file in your terminal like this
-  N.B: Do not push your Access Key and Secret key to Public view. If you don't have the keys, go to [AWS IAM](https://console.aws.amazon.com/iam/home?region=eu-west-2#/users) to create a user and give the user programmatic access

  - `export AWS_ACCESS_KEY_ID=<paste your aws access keys here>`
  - `AWS_SECRET_ACCESS_KEY=<paste your secret keys here>`
  - `export REGION=<paste your region here i.e. eu-west-2>`
  - `export INSTANCE_TYPE='t2.micro'`
  - `export NEW_AMI_NAME=''`
  - `export TF_VAR_ami_name=$NEW_AMI_NAME`

- After exporting the variables above, while in the root directory of this project, execute the command `packer build packer.json` to start the image build process.
  - After running the command you'll see the build flow on your terminal and you can also check your `AWS EC2 console` to monitor how the Image build is being done.


### How To Launch the Built AMI With Terraform.
To launch AMI machine images on AWS do the following
- To start this, ensure you have AWS CLI on your local machine. Steps to follow are here depending on your OS type [AWS CLI DOC](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- If you are on a MacOS and you have Homebrew install, just run this command to install the aws-cli ` brew install awscli`
- After installing the aws cli, run `aws configure` then add your access key and secret key
- Change directory into the `ec2_build` folder by running this command `cd ec2_build` from your terminal
- In the `ec2_build` directory, run the command `terraform init` to add the terraform plugins need for the instance launch on the chosen provider
- After initialising the directory, run the command `terraform plan`  to preview the information about the instance that will be created
- After running `terraform plan` above, run the command `terraform apply` and type `yes` when you get a prompt to begin the process of launching the instance.

### How To Automate the Image creation and Deployment process

In the root of the project, there is a `build_script.sh` script you can use to create both the `packer AMI` and deploy & launch the AMI created on AWS.

To run the script, ensure that you have all the necesary environment variables described above exported into the environment. Then run the command `./build_script.sh` and then watch the terminal to see how the deployment happens. You can check your AWS Console to see how the process is being done.

