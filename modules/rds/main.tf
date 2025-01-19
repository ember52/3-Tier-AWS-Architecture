# Database Subnet Group
resource "aws_db_subnet_group" "database_subnet_group" {
  name       = "${var.project}-database-subnet-group"
  subnet_ids = var.database_subnet_ids

  tags = {
    Name = "${var.project}_database_subnet_group"
  }
}

# Primary Database Instance
resource "aws_db_instance" "primary_db" {
  allocated_storage      = 20
  db_name                = "primary_database"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  multi_az               = true
  storage_type           = "gp2"
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [var.db_security_group_id]  # Attach DB security group
  backup_retention_period = 7
  skip_final_snapshot    = true

  tags = {
    Name = "${var.project}_primary_db"
  }
}

# Read Replica 1
resource "aws_db_instance" "read_replica_1" {
  replicate_source_db    = aws_db_instance.primary_db.id
  instance_class         = "db.t3.micro"
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [var.db_security_group_id]  # Attach DB security group
  publicly_accessible    = false
  storage_type           = "gp2"

  tags = {
    Name = "${var.project}_read_replica_1"
  }
}

# Read Replica 2
resource "aws_db_instance" "read_replica_2" {
  replicate_source_db    = aws_db_instance.primary_db.id
  instance_class         = "db.t3.micro"
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [var.db_security_group_id]  # Attach DB security group
  publicly_accessible    = false
  storage_type           = "gp2"

  tags = {
    Name = "${var.project}_read_replica_2"
  }
}
