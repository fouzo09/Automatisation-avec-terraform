

resource "aws_key_pair" "MyEc2KeyPair" {
    key_name = "MyEc2KeyPair"
    public_key = file("./terraform.pub")
}

resource "aws_security_group" "WebServerSG" {
  name        = "WebServerSG"
  description = "Manage traffic"
  
  ingress {
    description      = "Allow SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow HTTP Access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "WebServerSG"
  }
}

resource "aws_instance" "WEBSERVER" {
    
    ami = "ami-007855ac798b5175e"
    instance_type = "t2.micro"
    key_name = aws_key_pair.MyEc2KeyPair.key_name
    vpc_security_group_ids = [ aws_security_group.WebServerSG.id ]

    tags = {
        Name = "WebSite"
    }

    user_data = <<-EOF
        #!/bin/sh
        sudo apt-get update
        sudo apt-get install -y nginx
        sudo echo "<h1>Mafouz DIALLO</h1>" > /var/www/html/index.html
        EOF
  
}