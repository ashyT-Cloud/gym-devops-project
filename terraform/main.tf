provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "gym_target_key" {
  key_name   = "gym-target-key"
  public_key = file("/home/ubuntu/.ssh/gym-target-key.pub")
}

resource "aws_security_group" "gym_sg" {
  name = "gym-devops-sg"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow App Port"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "gym_target" {
  ami                    = "ami-0b6c6ebed2801a5cb"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.gym_target_key.key_name
  vpc_security_group_ids = [aws_security_group.gym_sg.id]

  tags = {
    Name = "gym-target-node"
  }
}

output "target_public_ip" {
  value = aws_instance.gym_target.public_ip
}
