#Private subnets
resource "aws_subnet" "private_subnets" {
  for_each   = var.private_subnets
  vpc_id     = data.aws_vpc.default.id
  cidr_block = cidrsubnet(data.aws_vpc.default.cidr_block, 8, each.value)

  tags = {
    Terraform = true
  }
}

#Security Groups
resource "aws_security_group" "tier_2" {
  name        = "tier_2"
  description = "Allow inbound traffic"
  vpc_id      = data.aws_vpc.default.id
  ingress {
    description = "SSH Inbound"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.31.250.0/24", "120.29.76.169/32"]
  }
  egress {
    description = "Global Outbound"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name    = "tier_2"
    Purpose = "For dev"
  }
}

resource "aws_instance" "terraform_key" {
  ami                         = "ami-0ffac3e16de16665e"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_subnets["tier_2"].id
  security_groups             = [aws_security_group.tier_2.id]
  associate_public_ip_address = true
  key_name                    = data.aws_key_pair.terraform_key.key_name
  #   iam_instance_profile        = "CloudWatchAgentServerPolicy"

  tags = {
    "Name" = "tier_2"
  }
}
