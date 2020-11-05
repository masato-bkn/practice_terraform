resource "aws_db_instance" "sample-db" {
  identifier             = "sample-db"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "11.5"
  instance_class         = "db.t3.micro"
  name                   = "sampledb"
  username               = "test"
  password               = "testtest"
  vpc_security_group_ids = [var.security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.sample-subnet-gp.name
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "sample-subnet-gp" {
  name = "sample-subnet-gp"
  subnet_ids = [
    var.private_subnet_1a.id,
    var.private_subnet_1c.id
  ]
}
