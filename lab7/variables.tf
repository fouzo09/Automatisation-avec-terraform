variable "WEBSERVER_INSTANCE_USER_DATA" {
  type = string
  default = <<-EOF
		#!/bin/bash
        sudo apt-get update
		sudo apt-get install -y apache2
		sudo systemctl start apache2
		sudo systemctl enable apache2
		sudo echo "<h1>WebServer</h1>" > /var/www/html/index.html
	EOF
}