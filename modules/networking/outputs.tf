output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "elastic_ips" {
  value = aws_eip.nat[*].id
}

output "security_groups" {
  value = {
    bastion = aws_security_group.bastion_sg.id
    app     = aws_security_group.app_sg.id
    db      = aws_security_group.db_sg.id
  }
}
