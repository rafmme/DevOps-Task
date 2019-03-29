# the AWS region/location where the instance will be created
variable "REGION" {}

# the machine image AMI ID of the image the instance will be running
variable "AMI_ID" {}

# the AWS Instance type for the instance we are creating 
variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

# the name of the keypair we will be using to access the instance created
variable "KEYPAIR_NAME" {}

# name tag to associate with the Instance being created
variable "NAME_TAG" {}

# name given to the AMI that was built with packer
variable "ami_name" {}

