variable "name" {
  description = "Name of the autoscaling group"
}

variable "health_check_grace_period" {
  description = "Health check grace period"
}

variable "health_check_type" {
  description = "Health check type"
}

variable "force_delete" {
  description = "Force delete flag"
}

variable "vpc_zone_identifier" {
  description = "List of subnet IDs for the autoscaling group"
  type        = list(string)
}

# variable "load_balancers" {
#   description = "List of target group ARNs for load balancers"
  
# }

variable "desired_capacity" {
  description = "Desired capacity of the autoscaling group"
}

variable "max_size" {
  description = "Maximum size of the autoscaling group"
}

variable "min_size" {
  description = "Minimum size of the autoscaling group"
}

variable "launch_template_id" {
  description = "ID of the launch template"
}

variable "versions" {
  description = "Version of the launch template"
}

variable "cpu_policy_percentage" {
  description = "Target CPU percentage for the autoscaling policy"
}

variable "ec2_instance_name"{
  
}
variable "alb_target_group_arn"{
  
}