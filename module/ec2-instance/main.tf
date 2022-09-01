//ec2 start


resource "aws_instance" "dev-ec2" {
  ami           = var.ami
  instance_type = var.insta-type
  key_name = var.key_name
  subnet_id = var.pub-snet
  security_groups = [var.sg]
# user_data = <<-EOF
# #!/bin/bash
# sudo yum update -y
# sudo yum install nginx -y
# echo "hey jkuhkk $(hostname -f)" > /var/www/html/index.html
# service nginx start
# chkconfig httpd on
# EOF
  tags = {
    Name = "${terraform.workspace}-ec2"
    env = terraform.workspace
  }
}


