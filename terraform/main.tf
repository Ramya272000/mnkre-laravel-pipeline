provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "mnkre_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_eks_cluster" "mnkre_cluster" {
  name     = "mnkre-dev-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.mnkre_subnets[*].id
  }
}

resource "aws_security_group" "mnkre_sg" {
  name_prefix = "mnkre-sg-eks"
  vpc_id      = aws_vpc.mnkre_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
