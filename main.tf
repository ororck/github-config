locals {
  repositories = yamldecode(file("${path.module}/repositories.yml"))
}

module "repo" {
  source   = "./modules/repo"
  for_each = local.repositories

  name        = each.key
  description = each.value.description
  topics      = try(each.value.topics, [])
}
