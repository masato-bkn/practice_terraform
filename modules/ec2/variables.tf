variable "name" {
  description = "インスタンス名"
  type        = string
  default     = "sample_ec2"
}

variable "instance_type" {
  description = "インスタンスタイプ"
  type        = string
  default     = "t2.micro"
}

variable "subnet_public_a" {}
variable "web_sg" {}
variable "key_name" {}
variable "public_key" {}
