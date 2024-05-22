module "network" {
  source                      = "./modules/NETWORK"
  vpc_name                    = "Paula-MainVpc"
  vpc_cidr                    = "10.0.0.0/16"
  enable_dns_support          = true
  enable_dns_hostnames        = true
  subnets                     = var.subnets
  availability_zones          = "us-east-1a"
  auto_assign_public_ip_state = true
  cidr_from_anywhere          = "0.0.0.0/0"
  public_route_name           = "public-route"
  private_route_name          = "private-route"
  internet_gateway_name       = "paula-IGW"
  natgateway_name             = "paula-NGW"
  security_group_name         = "paula-SG"
  security_group_description  = "Allow HTTP traffic from anywhere"
  inport                      = ["80", "22", "3306", "9000", "3001"]
  in_protocol                 = "tcp"
  eg_port                     = 0
  eg_protocol                 = "-1"
}

module "frontendEC2" {
  source                      = "./modules/DB"
  ec2_name                    = "paula-db"
  ec2_ami                     = "ami-04b70fa74e45c3917"
  ec2_type                    = "t3.micro"
  SG_id                       = [module.network.secgroup-id]
  ec2_subnet_ID               = module.network.private_subnet_id1
  associate_public_ip_address = false
  key_pair                    = "paula-key"
  user_data                   = file("./install2.sh")
  depends_on                  = [module.network]
}

resource "null_resource" "update_docker_compose" {
  provisioner "local-exec" {
    command = "bash ./update_docker_compose.sh"
  }

  # Trigger the execution whenever there's a change in the frontend EC2 instance
  triggers = {
    when_frontend_ec2_private_ip_changed = module.frontendEC2.db_id
  }

  # Ensure the execution order is respected
  depends_on = [module.frontendEC2]
}

module "load_balancer" {
  source                     = "./modules/LB"
  lb_name                    = "paulaLB"
  internal                   = false
  load_balancer_type         = "application"
  security_group_ids_LB      = [module.network.secgroup-id]
  subnet_ids_LB              = [module.network.public_subnet_id1, module.network.public_subnet_id2]
  enable_deletion_protection = false
  port                       = 80
  protocol                   = "HTTP"
  vpc_id                     = module.network.vpc_id
  depends_on                 = [null_resource.update_docker_compose]
}

module "lunch_template" {
  source                      = "./modules/TEMPLATE"
  name                        = "paula-terraform-template"
  ami_id                      = "ami-04b70fa74e45c3917"
  instance_type               = "t3.micro"
  key_name                    = "paula-key"
  security_group_id           = [module.network.secgroup-id]
  subnet_id                   = module.network.public_subnet_id1
  associate_public_ip_address = true
  user_data                   = base64encode(file("./install.sh"))
  monitoring                  = true
  depends_on                  = [null_resource.update_docker_compose]
}

module "ASG" {
  source                    = "./modules/ASG"
  name                      = "paula-asg"
  health_check_grace_period = 100
  health_check_type         = "ELB"
  force_delete              = true
  vpc_zone_identifier       = [module.network.public_subnet_id1, module.network.public_subnet_id2]
  desired_capacity          = 1
  max_size                  = 4
  min_size                  = 1
  launch_template_id        = module.lunch_template.launch_template_id
  versions                  = "$Latest"
  cpu_policy_percentage     = 50.0
  ec2_instance_name         = "paula_wordpress"
  alb_target_group_arn      = module.load_balancer.target_group_arn
  depends_on                = [null_resource.update_docker_compose]
}

module "s3_backend" {
  source = "./modules/s3_backend"
}

output "DNS_LINK" {
  value = module.load_balancer.lb_dns_name
}