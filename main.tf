provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "example" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

# Create SNS topic

resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name
}


# Create SNS subscription

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = var.sns_topic_email
}

# Create CloudWatch alarm
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "CPUUsageAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 0.6
  alarm_description   = "CPU usage is above 0.6% for 1 minute"
  alarm_actions = [
    "arn:aws:automate:${data.aws_region.current.name}:ec2:reboot",
    aws_sns_topic.sns_topic.arn
  ]
  actions_enabled     = true
  dimensions = {
    InstanceId = aws_instance.bastion.id
  }
}

data "aws_region" "current" {}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = "${var.aws_region}c"
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_security_group" "public_ec2" {
  name        = "public_ec2"
  description = "Security group for public EC2 instance"
  vpc_id      = aws_vpc.example.id
  tags = {
    Name = var.sg1_name
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
  tags = {
    Name = "Project VPC IG"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}


resource "aws_instance" "bastion" {
  ami           = var.ami_name
  instance_type = "t2.micro"
  key_name      = "aws"
  associate_public_ip_address = true
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public_ec2.id]
  tags = {
    Name = var.instance1_name
  }
}

