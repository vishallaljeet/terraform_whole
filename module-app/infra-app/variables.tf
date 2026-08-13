variable "env" {
  description = "This is the env for infra"
  type = string
}

variable "bucket-name" {
  description = "This is the bucket name for s3 bucket"
  type = string
}

variable "ec2-ami-infra-type" {
  description = "This is the bucket name for s3 bucket"
  type = string
}

variable "ec2-infra-app-volume-size" {
  description = "This is the bucket name for s3 bucket"
  type = string

}

variable "instance_count" {
  description = "This is the count of number of ec2 instance"
  type = number
  
}

variable "instance-type" {
  description = "This is type of ec2 instance instance"
  type = string
}

variable "hash_key" {
  description = "This is for hask key input from user"
  type = string
}