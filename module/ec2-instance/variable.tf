variable "ami" {
    
}
variable "insta-type" {
    }
# variable "pub-snet" {
#     }
# variable "pub-snet2" {
  
# }
variable "sg" {
  
}

variable "key_name" {
    default = "key001"
  
}
# variable "db-instance" {
  
# }
# variable "username1" {
  
# }
# variable "password1" {
  
# }
# variable "dbname1" {
  
# }
# variable "ssh_key_pub" {
#   default = "/home/user/Downloads/key001.pub"
# }
# variable "ssh_key_pri" {
#   default = "/home/user/Downloads/key001.pem"
# }
# variable for for each loop ec2

variable "ec2-sub" {
   type = map(object({
    pub-snet = string
   })) 
}

