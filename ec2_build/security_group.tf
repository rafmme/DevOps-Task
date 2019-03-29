# the security group for the Instance that will be created
resource "aws_security_group" "ah_security_group" {
  name        = "ah_security_group"
  description = "AH Security group"

  # this is the inbound rule for allowing tls on the incoming traffic to the instance
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # this is the inbound rule for allowing incoming http traffic to the instance on PORT 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # this is the inbound rule for allowing ssh access into the Instance 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # this is the outbound rule for allowing outgoing traffic from the instance 
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  # name tag given to the security group for identification
  tags = {
    Name = "ah_security_group"
  }
}
