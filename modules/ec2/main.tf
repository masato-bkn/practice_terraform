data "aws_ami" "sample_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.sample_ami.id
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet.id
  vpc_security_group_ids = [
    var.security_group.id
  ]
  key_name                    = aws_key_pair.sample_key_pair.id
  associate_public_ip_address = true

  user_data = <<EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo service httpd start
  EOF

  tags = {
    Name = "web"
  }
}

resource "aws_instance" "web-2" {
  ami           = data.aws_ami.sample_ami.id
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet.id
  vpc_security_group_ids = [
    var.security_group.id
  ]
  key_name                    = aws_key_pair.sample_key_pair.id
  associate_public_ip_address = true

  user_data = <<EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo service httpd start
  EOF

  tags = {
    Name = "web-2"
  }
}

resource "aws_key_pair" "sample_key_pair" {
  key_name   = var.key_name
  public_key = file("./${var.public_key}")
}

resource "aws_eip" "web_eip" {
  instance = aws_instance.web.id
  vpc      = true
}
