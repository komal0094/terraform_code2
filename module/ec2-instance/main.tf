//ec2 start


# resource "aws_instance" "dev-ec2" {
#   ami           = var.ami
#   instance_type = var.insta-type
#   key_name = var.key_name
#   subnet_id = var.pub-snet
#   security_groups = [var.sg]
#   # iam_instance_profile = aws_iam_instance_profile.instance_profile.name_prefix
# user_data = <<-EOF
# #!/bin/bash
# sudo su -
# apt update -y
# apt install nginx -y
# systemctl start nginx.service
# apt install mysql-sever -y 
# apt install php-fpm php-mysql -y
# cd /var/www/html
# wget http://wordpress.org/latest.tar.gz
# tar -xvzf latest.tar.gz
# apt install awscli -y
# systemctl restart nginx.service

# EOF
# #  depends_on = [
# #     aws_db_instance.database1,
# #   ]
#   tags = {
#     Name = "${terraform.workspace}-ec2"
#     env = terraform.workspace
#   }
#   provisioner "file" {
#     content     = data.template_file.phpconfig.rendered
#     destination = "/tmp/wp-config.php"

#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       host = self.public_ip
#       private_key = file(var.ssh_key_pri)
#     }
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sleep 120 && sudo cp /tmp/wp-config.php /var/www/html/wordpress/wp-config.php",
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       host = self.public_ip
#       private_key = file(var.ssh_key_pri)
#     }
#   }

#   provisioner "file" {
#     content     = data.template_file.nginx.rendered
#     destination = "/tmp/default"

#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       host = self.public_ip
#       private_key = file(var.ssh_key_pri)
#     }
#   }
# provisioner "remote-exec" {
#     inline = [
#       "sleep 120 && sudo cp /tmp/default /etc/nginx/sites-enabled",
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       host = self.public_ip
#       private_key = file(var.ssh_key_pri)
#     }
#   }
# }
//ec2 end
//creating iam role
# resource "aws_iam_role" "s3_role" {
#   name = "s3_full_access"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

//iam policy
# resource "aws_iam_policy" "s3_policy" {
#   name = "s3_test_policy"
#   # role = aws_iam_role.s3_role.id

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
#     Version = "2012-10-17",
#     "Statement" : [
#       {
#         "Effect": "Allow",
#         "Action": [
#           "s3:*",
#           "s3-object-lambda:*"
#         ],
#         "Resource": "*"
#       }
#     ]
#   })
# }

//policy attach to role
# resource "aws_iam_policy_attachment" "policy-attach" {
#   name       = "test-attachment"
#   roles      = [aws_iam_role.s3_role.name]
#   policy_arn = aws_iam_policy.s3_policy.arn
# }

//iam instance profile
# resource "aws_iam_instance_profile" "instance_profile" {
#   name = "s3_instance_profile"
#   role = aws_iam_role.s3_role.name
# }

//provisioner key
# resource "aws_key_pair" "keypair1" {
#   key_name   = key001
#   public_key = file(var.ssh_key_pub)
# }

# data "template_file" "phpconfig" {
#   template = file("files/wp-config.php")

#   vars = {
#     # db_port = aws_db_instance.mysql.port
#     db_host = var.db-instance
#     db_user = var.username1
#     db_pass = var.password1
#     db_name = var.dbname1
#   }
# }
# data "template_file" "nginx" {
#   template = file("files/default")


#   }
# //provisioner for automation file
# provisioner "file" {
#     content     = data.template_file.phpconfig.rendered
#     destination = "/tmp/wp-config.php"

#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       host = self.public_ip
#       private_key = file(var.ssh_key_pri)
#     }
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo cp /tmp/wp-config.php /var/www/html/wp-config.php",
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       host = self.public_ip
#       private_key = file(var.ssh_key_pri)
#     }
#   }
//ec2 creating using for each loop
resource "aws_instance" "dev-ec2" {
  for_each = var.ec2-sub
   ami           = var.ami
  instance_type = var.insta-type
  key_name = var.key_name
   subnet_id = each.value["pub-snet"]
   security_groups = [var.sg]
}
# cidr_block = each.value["cidr_block"]

