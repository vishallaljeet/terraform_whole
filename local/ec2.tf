resource "aws_key_pair" "deployer" {
  key_name   = "terra-key-ec2"
  public_key =  file("terra-key-ec2.pub")
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "example_tls" {

    name = "automate-sg"
    description = "Allow traffic for terraform"
    vpc_id = aws_default_vpc.default.id

    tags = {
    Name = "allow_tls"
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
    for_each = tomap({
        test_nginx = "t3.micro"
        nginx_server = "t3.micro"
        sandbox = "t2.large"
    })

    depends_on = [ aws_security_group.example_tls, aws_key_pair.deployer ]
    key_name = aws_key_pair.deployer.key_name
    vpc_security_group_ids = [aws_security_group.example_tls.id]
    ami = var.ec2-ami-tyoe
    instance_type = each.value
    user_data = file("install_nginx.sh")

    root_block_device {
        volume_size = var.env == "prod" ? 20 : var.ec2-default-volume-size
        volume_type = "gp3"
    }
    tags = {
        Name = each.key
    }
}

