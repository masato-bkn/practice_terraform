output "sample-vpc" {
  value = aws_vpc.sample_vpc
}

output "sample-subnet-1a" {
  value = aws_subnet.sample_subnet_1a[0]
}

output "sample-subnet-1c" {
  value = aws_subnet.sample_subnet_1c[0]
}

output "sample-private-subnet-1a" {
  value = aws_subnet.sample_private_subnet_1a[0]
}

output "sample-private-subnet-1c" {
  value = aws_subnet.sample_private_subnet_1c[0]
}
