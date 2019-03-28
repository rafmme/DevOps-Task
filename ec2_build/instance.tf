# the data source for the AMI for the instance
data "aws_ami" "image" {
  owners = ["self"]

  filter {
    name   = "name"
    values = ["${var.ami_name}"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# The AWS instance resource
resource "aws_instance" "neon-ah" {
  ami           = "${data.aws_ami.image.id}"
  instance_type = "${var.INSTANCE_TYPE}"
  key_name      = "${var.KEYPAIR_NAME}"
  security_groups = ["${aws_security_group.ah_security_group.name}"]

  tags {
    Name = "${var.NAME_TAG}"
  }
}
