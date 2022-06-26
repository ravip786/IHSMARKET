output "fsx_id" {
  description = "The id of the fsx filesystem."
  value = {
    for fsx in aws_fsx_file_system.this :
    fsx.tags.Name => fsx.id
  }
}

output "fsx_arn" {
  description = "The ARN of the fsx filesystem."
  value = {
    for fsx in aws_fsx_file_system.this :
    fsx.tags.Name => fsx.arn
  }
}

output "access_point_id" {
  description = "The ARN of the fsx filesystem."
  value = {
    for access_point in aws_fsx_access_point.this :
    access_point.tags.Name => access_point.id
  }
}