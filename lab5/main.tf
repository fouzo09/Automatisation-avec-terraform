//INSTALL DOCKER ON EC2 INSTANCE UNSING REMOTE EXEC

provider "aws" {
    access_key = "AKIAY44W4NNGOZZYSRFQ"
    secret_key = "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"
    region = "us-east-1"
}

variable "DOCKER_SOURCE" {
  type = string
  default = "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
}

resource "aws_key_pair" "ssh" {
    key_name   = "WebServerAccessKey"
    public_key = file("./terraform.pub")
}

resource "aws_security_group" "instance_sg" {
    name = "WebServerSG"

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

resource "aws_instance" "WebServer" {
    ami = "ami-007855ac798b5175e"
    instance_type = "t2.micro"
    key_name = aws_key_pair.ssh.key_name
    vpc_security_group_ids = [ aws_security_group.instance_sg.id ]
    connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("./terraform")
        host        = self.public_ip
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get -f -y update",
            "sudo apt install apt-transport-https ca-certificates curl software-properties-common -y",
            "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
            "sudo add-apt-repository --yes '${var.DOCKER_SOURCE}' ",
            "apt-cache policy docker-ce",
            "sudo apt install docker-ce -y",
            "sudo groupadd docker > /dev/null 2>&1",
            "sudo usermod -aG docker $USER > /dev/null 2>&1",
            "sudo docker run -d --name server -p 80:80 nginx:latest",
        ]
    }
}