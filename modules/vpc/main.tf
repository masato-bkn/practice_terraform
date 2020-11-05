resource "aws_vpc" "sample_vpc" {
  cidr_block                       = "10.0.0.0/16"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "sample_vpc"
  }
}

resource "aws_subnet" "sample_subnet_1a" {
  count                   = 1
  vpc_id                  = aws_vpc.sample_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.sample_vpc.cidr_block, 8, count.index)
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "sample_subnet_1a"
  }
}

resource "aws_subnet" "sample_subnet_1c" {
  count                   = 1
  vpc_id                  = aws_vpc.sample_vpc.id
  cidr_block              = "10.0.13.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "sample_subnet_1c"
  }
}

resource "aws_subnet" "sample_private_subnet_1a" {
  count                   = 1
  vpc_id                  = aws_vpc.sample_vpc.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "sample_private_subnet_1a"
  }
}

resource "aws_subnet" "sample_private_subnet_1c" {
  count                   = 1
  vpc_id                  = aws_vpc.sample_vpc.id
  cidr_block              = "10.0.12.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "sample_private_subnet_1c"
  }
}

resource "aws_internet_gateway" "sample_gw" {
  vpc_id = aws_vpc.sample_vpc.id

  tags = {
    Name = "sample_gw"
  }
}

resource "aws_route_table" "sample-rtb" {
  vpc_id = aws_vpc.sample_vpc.id

  tags = {
    Name = "sample_rtb"
  }
}

resource "aws_route" "sample_rt" {
  gateway_id             = aws_internet_gateway.sample_gw.id
  route_table_id         = aws_route_table.sample-rtb.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public-1a" {
  subnet_id      = aws_subnet.sample_subnet_1a[0].id
  route_table_id = aws_route_table.sample-rtb.id
}

resource "aws_route_table_association" "public-1c" {
  subnet_id      = aws_subnet.sample_subnet_1a[0].id
  route_table_id = aws_route_table.sample-rtb.id
}
