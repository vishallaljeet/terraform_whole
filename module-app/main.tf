##prod infra modules

module "prod-infra-app" {
  source = "./infra-app"
  env = "prod"
  bucket-name = "infra-app-bucket-vlaljeet"
  instance-type = "t2.micro"
  instance_count = 2
  ec2-infra-app-volume-size = 20
  ec2-ami-infra-type = "ami-0e5497a77ef21b5ac"  # Ubuntu ami
  hash_key = "studentId"
}

##stg infra modules

module "stg-infra-app" {
  source = "./infra-app"
  env = "stg"
  bucket-name = "infra-app-bucket-vlaljeet"
  instance-type = "t3.micro"
  instance_count = 1
  ec2-infra-app-volume-size = 15
  ec2-ami-infra-type = "ami-0e5497a77ef21b5ac"  # Ubuntu ami
  hash_key = "studentId"
}

##dev infra modules

module "dev-infra-app" {
  source = "./infra-app"
  env = "dev"
  bucket-name = "infra-app-bucket-vlaljeet"
  instance-type = "t3.micro"
  instance_count = 1
  ec2-infra-app-volume-size = 15
  ec2-ami-infra-type = "ami-0e5497a77ef21b5ac"  # Ubuntu ami
  hash_key = "studentId"
}