locals {
  policies_files = fileset(path.module, "policies/*.hcl")
  policies = {
    for path in local.policies_files :
    replace(basename(path), ".hcl", "") => file(path)
  }
}

module "policy" {
  source   = "./modules/policy"
  for_each = local.policies

  name   = each.key
  policy = each.value
}
