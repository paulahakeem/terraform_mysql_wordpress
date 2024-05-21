variable "subnets" {
  type = map(object({
    cidr_block        = string
    public            = bool
    availability_zone = string # Adding availability zone
  }))
  default = {
    "public_subnet1" = {
      cidr_block        = "10.0.1.0/24"
      public            = true
      availability_zone = "us-east-1a"
    }
    "public_subnet2" = {
      cidr_block        = "10.0.2.0/24"
      public            = true
      availability_zone = "us-east-1b"
    }
    "private_subnet_1" = {
      cidr_block        = "10.0.3.0/24"
      public            = false
      availability_zone = "us-east-1a"
    }
  }
}

