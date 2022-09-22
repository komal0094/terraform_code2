
provider "aws" {
  region     = "us-east-1"
  

  }


# my new branch test
//module nw
module "nw" {
  source = "./module/nw"
  pub-snets = {
    pub-sub-1 = {
          availability_zone = "us-east-1a"
        cidr_block = "10.0.0.0/18"
      },
      pub-sub-2 = {
          availability_zone = "us-east-1b"
         cidr_block= "10.0.64.0/18"
      }
  }
  //private sub
  pri-snets = {
    pri-sub-1 = {
          availability_zone = "us-east-1c"
        cidr_block = "10.0.128.0/18"
      },
      pri-sub-2 = {
          availability_zone = "us-east-1d"
         cidr_block= "10.0.192.0/18"
      }
  }
  //nat gateway variable both
  # snt-id = "pub-sub-1"
  # nat-req = true
}



/*
#
# module "db" {
#   source = "./module/sg"
#   sg_details = {
#     "rds-sg" = {
#         name = "rds"
#         description = "rds"
#         vpc_id = module.nw.vpc_id

#         ingress_rules = [
#             {
#                 from_port = 3306
#                 to_port = 3306
#                 protocol = "tcp"
#                 cidr_blocks = ["0.0.0.0/0"]
#                 security_groups = [lookup(module.sg.output-sg, "ec2-sg", null)]
#                 self = null
#             }
            
#         ]
#     }
# }
# }


//module ec2
# module "ec2-instance" {
#   # count =  2
#   source = "./module/ec2-instance"
#   ami = "ami-052efd3df9dad4825"
#   insta-type = "t2.micro"
#   pub-snet = lookup(module.nw.pub-snet-id, "pub-sub-1", null).id
#   pub-snet2 = lookup(module.nw.pub-snet-id, "pub-sub-2", null).id
#  sg = lookup(module.sg.output-sg, "ec2-sg", null)
#  //rds specific things
# # db-instance = module.rds.db-instance
# # username1 = module.rds.username
# #   password1 = module.rds.password
# #   dbname1 = module.rds.dbname
#   #  pub-sub = "${element(module.nw.pub-subnet, count.index)}"
# }

////
# module "ec2-instance2" {
#   # count =  2
#   source = "./module/ec2-instance"
#   ami = "ami-052efd3df9dad4825"
#   insta-type = "t2.micro"
 
#   pub-snet= lookup(module.nw.pub-snet-id, "pub-sub-2", null).id
#  sg = lookup(module.sg.output-sg, "ec2-sg", null)
 
# }

# module "ec2-instance2" {
#   source = "./module/ec2-instance"
#   pub-sub = element(module.nw.pub-subnet,1)
#   sg = lookup(module.sg.output-sg, "web-sg", null)
# }

//module lb
# module "lb" {
#   source = "./module/lb"
#   lb-sg = lookup(module.sg.output-sg, "lb-sg", null)
#   lb-snets = lookup(module.nw.pub-snet-id, "pub-sub-1", null).id
#   lb-snets2 = lookup(module.nw.pub-snet-id, "pub-sub-2", null).id
#   ec2-attach = module.ec2-instance.*.ec2-id
#     # ec2-attach = module.ec2-instance.ec2-id
#   vpc_id = module.nw.vpc_id
#   elb-name = "elb-test"
#   bol = false
#   lb-type = "application"
#   ip_address_type = "ipv4"

 
# }

//module asg
# module "asg" {
#   source = "./module/asg"
# asg-sg = lookup(module.sg.output-sg, "lb-sg", null)
# asg-snets = module.nw.pub-subnet
# tg_arn = module.lb.tg-arn
#  ami = "ami-081861d718d9fbf06"
# ec2-type = "t2.micro"
# key_name = "key001"
# name_prefix = "asg-test"
# des-cap = 2
# min_size = 1
# max_size = 4
# }

//module rds
# module "rds"{
#   source = "./module/rds"
#   rds-snet1 = lookup(module.nw.pub-snet-id, "pub-sub-1", null).id
#   rds-snet2 = lookup(module.nw.pub-snet-id, "pub-sub-2", null).id
#   rds-sg-id = lookup(module.db.output-sg, "rds-sg", null)
#   username = "admin"
#   password = "password123"
#   dbname = "db_rds"
# }

# output "pub-snt-id" {
#   value = lookup(module.nw.pub-snet-id,"pub-sub-1",null)
  
# }


//ec2 for each module
# module "ec2" {
#   source = "./module/ec2-instance"
#   ec2-sub = {
#     test-ec2 = {
#          pub-snet = lookup(module.nw.pub-snet-id, "pub-sub-1", null)
#       },
#       demo-ec2 = {
#          pub-snet = lookup(module.nw.pub-snet-id, "pub-sub-2", null)
#       }
#   }
#   sg = lookup(module.sg.output-sg, "ec2-sg", null)
#   ami = "ami-052efd3df9dad4825"
#   insta-type = "t2.micro"
# }


# output "weyhg" {
#   value = lookup(module.ec2.ec2-id, "test-ec2", null)
  
# }

# module "lb" {
#    source = "./module/lb"
#    lb-sg = lookup(module.sg.output-sg, "lb-sg", null)
#   # subnet = [lookup(module.nw.pub-snet-id,"pub-sub-1",null).id,lookup(module.nw.pub-snet-id,"pub-sub-2",null).id]
#    sub-id = {
#     lb-sub = {
#       snet-id = lookup(module.nw.pub-snet-id, "pub-sub-1", null)
#     },
#     lb-sub2 = {
#       snet-id = lookup(module.nw.pub-snet-id, "pub-sub-2", null)
#     }
    
#    } 
  # ec2-attach = [lookup(module.ec2.ec2-id, "test-ec2", null), lookup(module.ec2.ec2-id, "demo-ec2", null)]
  # ec2-id = {
  #   ec2-1 ={
  #     s-id = lookup(module.ec2.ec2-id, "test-ec2", null)
  #   },
  #   ec2-2 ={
  #     s-id = lookup(module.ec2.ec2-id, "demo-ec2", null)
  #   }
  # }
  # ec2-id = module.ec2.ec2-id
   vpc_id = module.nw.vpc_id
   elb-name = "elb-test"
  bol = false
   lb-type = "application"
   ip_address_type = "ipv4"
 
 }

#  output "ec2-id" {
#    value = module.ec2.ec2-id
#  }
//asg for each module
module "asg" {
  source = "./module/asg"
asg-sg = lookup(module.sg.output-sg, "lb-sg", null)
asg-snets = [lookup(module.nw.pub-snet-id,"pub-sub-1",null),lookup(module.nw.pub-snet-id,"pub-sub-2",null)]
tg_arn = module.lb.tg-arn
 ami = "ami-081861d718d9fbf06"
ec2-type = "t2.micro"
key_name = "key001"
name_prefix = "asg-test"
des-cap = 2
min_size = 1
max_size = 4
}
=======
>>>>>>> daf08454dabcc0beb222d2372d5f186cc9f0d4c6
*/