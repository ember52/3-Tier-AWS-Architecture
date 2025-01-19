output "primary_db_endpoint" {
  value = aws_db_instance.primary_db.endpoint
}

output "read_replica_1_endpoint" {
  value = aws_db_instance.read_replica_1.endpoint
}

output "read_replica_2_endpoint" {
  value = aws_db_instance.read_replica_2.endpoint
}
