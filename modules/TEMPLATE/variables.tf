variable "name" {
  description = "The name of the launch template"
  type        = string
}

variable "ami_id" {
  description = "The ID of the AMI to use for the launch template"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the launch template"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instances"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID to associate with the instances"
  type        = list(string)
}

variable "subnet_id" {
  description = "The subnet ID to associate with the instances"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
}

variable "monitoring" {
  description = "Whether to enable monitoring"
  type        = bool
}
