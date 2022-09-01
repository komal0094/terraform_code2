variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
  
}


# variable "pub_snet-cidr" {
#     type = list
#     default = ["10.0.0.0/18", "10.0.64.0/18"]
  
# }
# variable "az" {
#     type = list
#     default = ["us-east-1a", "us-east-1b"]
  
# }

# variable "pri-snet-cidr" {
#     type = string
#     default = "10.0.64.0/18"
  
# }


variable "all_traffic_allow" {
    type = string
    default = "0.0.0.0/0"
  
 }
//sg variable
# variable "sg_rule" {
#     type = map(any)
  
# }

# //sg variable for object
# variable "sg_rule" {
#     type = map(object({
#         type = string
#         from_port = number
#         to_port = number
#         protocol = string

#     }))
  
# }
///for each variable
variable "pub-snets" {
    type = map(object({
  cidr_block = string
  availability_zone = string
    }))
}
//private subnet
variable "pri-snets" {
    type = map(object({
  cidr_block = string
  availability_zone = string
    }))
}
# variable "pub-snets" {
#     type = map
#     default = {
#       pub-sub-1 = {
#           availability_zone = "us-east-1a"
#         cidr_block = "10.0.0.0/18"
#       }
#       pub-sub-2 = {
#           availability_zone = "us-east-1b"
#          cidr_block= "10.0.64.0/18"
#       }
#       pri-sub-3 = {
#           availability_zone = "us-east-1c"
#          cidr_block = "10.0.128.0/18"
#       }
#     }
# }
variable "snt-id" {}

variable "nat-req" {}