//sg variable
# variable "sg_rule" {
#     type = map(any)
  
# }

//sg variable for object
variable "sg_details" {
    type = map(object({
        name = string
       description = string
        vpc_id = string
        ingress_rules = list(object({
            from_port = number
            to_port   = number
            protocol  = string
            cidr_blocks = list(string)
            self      = bool
        }

        ))  

    }))
  
}