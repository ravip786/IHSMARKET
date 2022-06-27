 locals {
  payload_fsx = [
    {
      name = "phonepaix-${var.environment}-window-fsx"
      performance_mode = "generalPurpose"
      throughput_mode = "bursting"
      transition_to_ia  = "AFTER_30_DAYS"
      subnets = [
        {
          id =  "sg-0f51749cb998e1277"
        },
        {
          id =  "sg-0f51749cb998e1277"
        }
      ]
    }
 ]
 }