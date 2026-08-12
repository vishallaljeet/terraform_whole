variable "ec2-instance-type" {
  default = "t3.micro"
  type = string
}

variable "ec2-default-volume-size" {
  default = 25
  type = number
}

variable "ec2-ami-tyoe" {
  default = "ami-0e5497a77ef21b5ac"
  type = string
}

variable "env" {
  default = "prod"
  type = string
}