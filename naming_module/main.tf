# naming_module/main.tf

variable "base_name" {
  description = "The base name for the resource"
}

variable "resource_type" {
  description = "The type of the resource. Allowed values: virtual_machine, key_vault, storage_account"
}

locals {
  truncated_base_name = substr(var.base_name, 0, min(length(var.base_name), 15))
}

resource "null_resource" "placeholder" {
  triggers = {
    base_name     = var.base_name
    resource_type = var.resource_type
  }

  # Logic to generate resource name based on resource_type
  # Rule 2: virtual_machine
  # Rule 3: key_vault
  # Rule 4: storage_account
  # Implementing each rule as required
  # Add more rules as needed
  dynamic "generated_name" {
    for_each = {
      virtual_machine = "${local.truncated_base_name}-vm-00",
      key_vault       = "kv-${lower(local.truncated_base_name)}",
      storage_account = "sa${replace(local.truncated_base_name, "-", "")}"
    }

    content {
      name = generated_name.value
    }
  }
}

output "resource_name" {
  value = null_resource.placeholder[*].generated_name[*].name
}
