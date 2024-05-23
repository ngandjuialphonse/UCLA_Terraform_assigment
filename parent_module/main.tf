# parent_module/main.tf

variable "resource_map" {
  description = "A map of base names and resource types"
  type        = map(string)
}

module "naming" {
  source = "./naming_module"  # Or replace with GitHub URL

  for_each = var.resource_map

  base_name     = each.key
  resource_type = each.value
}

output "resource_names" {
  value = module.naming[*].resource_name
}
