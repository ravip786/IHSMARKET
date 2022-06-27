locals {
  fsx = {
    for i in var.payload_fsx :
    i.name => i
  }
  subnets = [
    for k, v in {
      for i in var.payload_fsx :
      i.name => {
        for j in i.subnets :
        i.name => merge(j, { "name" = i.name })...
      }
    } :
  v[k]]
  subnets_map = { for a in flatten(local.subnets) :
  "${a.name}_${a.id}" => a }
}

resource "aws_fsx_file_system" "this" {
  for_each         = local.fsx
  creation_token   = each.value.name
  performance_mode = each.value.performance_mode
  throughput_mode  = each.value.throughput_mode
  encrypted        = true

  lifecycle_policy {
    transition_to_ia = each.value.transition_to_ia
  }

  tags = merge(
    {
      "Name" = format("%s", each.value.name)
    },
    var.tags,
  )
}

resource "aws_fsx_mount_target" "this" {
  for_each        = local.subnets_map
  file_system_id  = aws_fsx_file_system.this[each.value.name].id
  subnet_id       = each.value.id
  security_groups = var.security_group_ids
}

resource "aws_fsx_access_point" "this" {
  for_each        = local.fsx
  file_system_id = aws_fsx_file_system.this[each.key].id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory  {
    path          = "/"
    creation_info  {
      owner_uid   = 1000
      owner_gid   = 1000
      permissions = 777
    }
  }

  tags = merge(
    {
      "Name" = format("%s", "${each.value.name}-access-point")
    },
    var.tags,
  )
}