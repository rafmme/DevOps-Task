# variables  declaration
variable "REGION" {}
variable "AMI_ID" {}
variable "INSTANCE_TYPE" {
  default = "t2.micro"
}
variable "KEYPAIR_NAME" {}
variable "NAME_TAG" {}
variable "ami_name" {}

