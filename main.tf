#####################################
#############ACM#####################
#####################################
module "Window_acm" {
  source            = "./modules/ACM"
  domain_name       = "jenkins.ihms.co"
  validation_method = "DNS"

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
########################################
##############ALB-TG####################
########################################
module "window_tg" {
  source          = "./modules/ALB_TG"
  create          = true
  name            = "phonexpaix-${var.environment}-window-alb-tg"
  protocol        = "HTTP"
  port            = "8080"
  vpc_id          =  "vpc-0f04d79e7020f3c87"

  /*target_group_rule = [
    {
      listener_arn  = module.snipeit_lb.lb_listener_arn
      listener_arn  = "arn:aws:elasticloadbalancing:us-east-1:033333781728:listener/app/grupdev-prod-snipeit-alb/fee0650eb050c33e/9d32ee0c54febab8
      priority      = "3"
      host_header   = "phonexpax.ihms.co"
    } */
  #]

  health_check      = {
    matcher = "200-403"
  
  }
 
  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
#######################################################
#######################FSX#############################
#######################################################

module "Window_fsX" {
  source               = "./modules/FSX"
  payload_fsx          = local.payload_fsx
  #security_group_ids   = [module.jenkins_efs_sg.security_group_id]
  security_group_ids   = "sg-0f51749cb998e1277"

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
#############################################################
#####################ALB#####################################
#############################################################
module "snipeit_lb" {
  source          = "./modules/ALB"
  create_lb       = true
  name            = "phonepax-${var.environment}-window-alb"
  security_groups = "sg-094f9715eff228860"
  subnets         = "subnet-0b3b9cb24804b08e5"

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

