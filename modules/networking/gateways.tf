resource "aws_eip" "nat" {
  count = 3
  tags = {
    Name = "${var.project}-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = 3
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name = "${var.project}-nat-${count.index + 1}"
  }
}
