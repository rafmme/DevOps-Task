# outputs the ip address of the instance
output "ip" {
  value = "${aws_instance.neon-ah.public_ip}"
}

# outputs the ami image id of the instance
output "ami_id" {
  value = "${data.aws_ami.image.id}"
}

