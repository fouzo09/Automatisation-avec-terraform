// REMOTE EXEC ET LOCAL EXEC

provider "aws" {
  region     = var.AWS_REGION
}

resource "aws_key_pair" "my_ec2" {
    key_name   = "terraform-key"
    public_key = file("./terraform.pub")
}

resource "aws_security_group" "instance_sg" {
    name = var.SECURITY_GROUP_NAME

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "web" {
  key_name      = aws_key_pair.my_ec2.key_name
  ami               = var.INSTANCE_AMI
  instance_type     = var.INSTANCE_TYPE
  vpc_security_group_ids = [ aws_security_group.instance_sg.id ]

  tags = {
    Name = var.INSTANCE_WEB_SERVER_NAME
  }

  connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./terraform")
      host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.web.public_ip} > ip_address.txt"
  }

  provisioner "remote-exec" {
      inline = [
        "sudo apt-get -f -y update",
        "sudo apt-get install -f -y apache2",
        "sudo systemctl start apache2",
        "sudo systemctl enable apache2",
        "sudo sh -c 'echo \"<h1>Hello Mafouz you are now Terraform Guru</h1>\" > /var/www/html/index.html'",
      ]
  }
}

