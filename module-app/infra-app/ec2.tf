resource "aws_key_pair" "deployer" {
  key_name   = "${var.env}-infra-app-key-ec2"
  public_key =  file("terra-key-ec2.pub")

  tags = {
    env = var.env
  }
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "${var.env}-Default VPC"
  }
}

resource "aws_security_group" "example_tls" {

    name = "${var.env}-infra-app"
    description = "Allow traffic for terraform"
    vpc_id = aws_default_vpc.default.id

    tags = {
    Name = "infra-app-sg"
    env = var.env
  }

    ingress {
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port = 80
      to_port = 80
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "access to all port"
    } 
}

resource "aws_instance" "from_terraform" {
    count = var.instance_count

    depends_on = [ aws_security_group.example_tls, aws_key_pair.deployer ]
    key_name = aws_key_pair.deployer.key_name
    vpc_security_group_ids = [aws_security_group.example_tls.id]
    ami = var.ec2-ami-infra-type
    instance_type = var.instance-type

    root_block_device {
        volume_size = var.env == "prod" ? 20 : 10
        volume_type = "gp3"
    }
    tags = {
        Name = "${var.env}-infra-app"
        env = var.env
    }
}