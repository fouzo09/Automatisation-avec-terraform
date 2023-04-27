

resource "aws_instance" "WEBSERVER" {
    
    ami = "${var.instance_ami}"
    instance_type = "${var.instance_type}"
    subnet_id = "${var.subnet_id}"

    tags = {
        Name = "WebSite"
    }
  
}