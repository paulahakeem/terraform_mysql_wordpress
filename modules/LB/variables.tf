variable "lb_name" {
    
}
variable "internal"{

}

variable "load_balancer_type"{

}

variable "security_group_ids_LB" {
  description = "The security group ID to associate with the load balancer"
 
}


variable "subnet_ids_LB" {
  description = "A list of subnet IDs to associate with the load balancer"
  
}

variable "enable_deletion_protection"{

}

# ----------------------- ------------------------------------#

variable "vpc_id" {
  description = "The ID of the VPC"
 
}

variable "port"{

}

variable "protocol"{
    
}

# variable "target_name" {
#   type = string
#
#   
# }

# variable "target_id" {

# }
