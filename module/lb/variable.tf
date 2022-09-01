variable "elb-name" {
    }
variable "bol" {
   }
variable "lb-type" {
   }
variable "lb-sg" {
  
}
variable "lb-snets" {
  
}
variable "ip_address_type" {
  
}
# variable "ec2-attach" {
  
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