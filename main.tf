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
  snt-id = "pub-sub-1"
  nat-req = true
}




# //module sg
module "sg" {
   source     = "./module/sg"
   sg_details = {
#     # "web-sg" = {
#     #     name = "test"
#     #     description = "test"
#     #     vpc_id = module.nw.vpc_id001

#     #     ingress_rules = [
#     #         {
#     #             from_port = 80
#     #             to_port = 80
#     #             protocol = "tcp"
#     #             cidr_blocks = ["0.0.0.0/0"]
#     #             self = null
#     #         },
#     #         {
                
#     #             from_port = 443
#     #             to_port   = 443
#     #             protocol = "tcp"
#     #             cidr_blocks = ["0.0.0.0/0"]
#     #             self = null
#     #         }
#     #     ]
#     # }
#     //sg lb
    "lb-sg" = {
        name = "test"
        description = "test"
        vpc_id = module.nw.vpc_id

        ingress_rules = [
            {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                self = null
            },
            {
                
                from_port = 443
                to_port   = 443
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                self = null
            }
        ]

  egress = {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    },
    
#     //sg ec2
    "ec2-sg" = {
        name = "test1"
        description = "test1"
        vpc_id = module.nw.vpc_id

        ingress_rules = [
            {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                self = null
            },
            {
                
                from_port = 443
                to_port   = 443
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                self = null
            }
         ]

  egress = {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    }
  }

}

//module ec2
# module "ec2-instance" {
#   count =  2
#   source = "./module/ec2-instance"
#   ami = "ami-052efd3df9dad4825"
#   insta-type = "t2.micro"
#   pub-snet = module.nw.pub-subnet[count.index]
#  sg = lookup(module.sg.output-sg, "ec2-sg", null)

#   #  pub-sub = "${element(module.nw.pub-subnet, count.index)}"
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
#   lb-snets = module.nw.pub-subnet
#   # ec2-attach = module.ec2-instance.*.ec2-id
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


output "pub-snt-id" {
  value = lookup(module.nw.pub-snet-id,"pub-sub-1",null).id
  
}
