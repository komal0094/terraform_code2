variable "elb-name" {
    }
variable "bol" {
   }
variable "lb-type" {
   }
variable "lb-sg" {
  
}
# variable "lb-snets" {
  
# }
# variable "lb-snets2" {
  
# }
variable "ip_address_type" {
  
}
# variable "ec2-id" {
#    type = map(object({
#    s-id = string
#    })) 
# }
variable "vpc_id" {
  
}
variable "interval" {
    default = 10
  
}
variable "timeout" {
    default = 5
  
}
variable "healthy_threshold" {
    default = 5
  
}
variable "unhealthy_threshold" {
    default = 2
  
}
variable "target_type" {
    default = "instance"
  
}
///for each loop
# variable "subnet" {
  
# }
variable "sub-id" {
  type = map
}