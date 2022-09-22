# provider "aws" {
#   region     = "us-east-1"
  
# }
data "aws_availability_zones" "available" {
  state = "available"
}


//vpc create
resource "aws_vpc" "my-vpc001" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = "true"


  tags = {
    Name = "${terraform.workspace}-dev-vpc"
    env = terraform.workspace
  }
}

# //subnet creation
# //pub-subnet
# resource "aws_subnet" "pub-snet1" {
#     count = length(var.pub_snet-cidr)
#   vpc_id     = aws_vpc.my-vpc001.id
#   cidr_block = var.pub_snet-cidr[count.index]
#    availability_zone = data.aws_availability_zones.available.names[count.index]
#   # availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"

#   tags = {
#     Name = "${terraform.workspace}-pub-sub_${data.aws_availability_zones.available.names[count.index]}"
#   env = terraform.workspace
#   }

# }
# # //pri-subnet
# # resource "aws_subnet" "pri-snet2" {
# #   vpc_id     = aws_vpc.my-vpc001.id
# #   cidr_block = var.pri-snet-cidr

# #   tags = {
# #     Name = "pri-sub"
# #   }
# # }

# //route table for pub-snet
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.my-vpc001.id

  
tags = {
    Name = "${terraform.workspace}-pub-route001"
  env = terraform.workspace
  }
}

# # //route table for pri -subnet
# # resource "aws_route_table" "pri-rt" {
# #   vpc_id = aws_vpc.my-vpc001.id

  

# #   tags = {
# #     Name = "pri-route002"
# #   }
# # }


# //route table attach to subnet
# //attach with public subnet
# resource "aws_route_table_association" "pub1-asso" {
#     count = length(var.pub_snet-cidr)
#   subnet_id      = aws_subnet.pub-snet1[count.index].id
#   route_table_id = aws_route_table.pub-rt.id
# }

# # //attch with private subnet
# # resource "aws_route_table_association" "pri1-asso" {
# #   subnet_id      = aws_subnet.pri-snet2.id
# #   route_table_id = aws_route_table.pri-rt.id
# # }

# //creation igw
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc001.id

  tags = {
    Name = "${terraform.workspace}-igw001"
    env = terraform.workspace
  }
}
# # //igw association with pub-route-table
resource "aws_route" "igw001" {
    route_table_id = aws_route_table.pub-rt.id
    destination_cidr_block = var.all_traffic_allow
    gateway_id = aws_internet_gateway.my-igw.id
  
}

# //security group creation
# resource "aws_security_group" "sg-vpc-001" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.my-vpc001.id

# #   ingress {
# #     description      = "TLS from VPC"
# #     from_port        = 443
# #     to_port          = 443
# #     protocol         = "tcp"
# #     cidr_blocks      = [aws_vpc.main.cidr_block]
# #     ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
# #   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "${terraform.workspace}-sg-001"
#     env = terraform.workspace
#   }
# }

# //security group rule for all traffic
# resource "aws_security_group_rule" "sg-rule-001" {
#     for_each = var.sg_rule
#   type              = each.value["type"]
#   from_port         = each.value["from_port"]
#   to_port           = each.value["to_port"]
#   protocol          = each.value["protocol"]
#   cidr_blocks       = [aws_vpc.my-vpc001.cidr_block]
#   ipv6_cidr_blocks  = [aws_vpc.my-vpc001.ipv6_cidr_block]
#   security_group_id = aws_security_group.sg-vpc-001.id
# }

// subnet ceration using for each loop

resource "aws_subnet" "pub-subnet" {
  for_each = var.pub-snets
  map_public_ip_on_launch = "true"
 availability_zone  = each.value["availability_zone"]
  cidr_block = each.value["cidr_block"]
  vpc_id     = aws_vpc.my-vpc001.id

  tags = {
    Name = "${terraform.workspace}-pub-snets"
  }
}
//private subnet
resource "aws_subnet" "pri-subnet" {
  for_each = var.pri-snets
 availability_zone  = each.value["availability_zone"]
  cidr_block = each.value["cidr_block"]
  vpc_id     = aws_vpc.my-vpc001.id

  tags = {
    Name = "${terraform.workspace}-pri-snets"
  }
}
//route table association
resource "aws_route_table_association" "pub-ass" {
    for_each = aws_subnet.pub-subnet
   subnet_id      = each.value.id
   route_table_id = aws_route_table.pub-rt.id
 }
 //eip
#  resource "aws_eip" "nat-ip" { }

//nat gateway
# resource "aws_nat_gateway" "nat-gateway" {
#   # for_each = var.nat-req ? aws_subnet.pub-subnet : null
#   #for_each = var.nat-req ? lookup(aws_subnet.pub-subnet,var.snt-id,null) : null
#   allocation_id = aws_eip.nat-ip.id
#   count = var.nat-req ? 1 : 0
#   subnet_id     = lookup(aws_subnet.pub-subnet,var.snt-id,null).id
 
#   tags = {
#     Name = "gw NAT"
#   }
# }
# pub-sub-1
# pub-subnet