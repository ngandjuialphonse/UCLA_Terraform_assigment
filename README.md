# Terraform Cloud Naming Modules

This repository contains Terraform modules for generating resource names in cloud environments based on specified naming conventions.

## Modules

### 1. naming_module

This module handles the logic for generating resource names based on the provided `base_name` and `resource_type`. It follows the following rules:

1. If the resource_type is "virtual_machine", the module appends "vm-" to the front of the `base_name` and "-00" to the back.
2. If the resource_type is "key_vault", the module appends "kv-" to the front of `base_name` and then sets all characters to lowercase.
3. If the resource_type is "storage_account", the module appends "sa" to the front of `base_name`, removes all "-" from the name, and sets all characters to lowercase.

#### Inputs

- `base_name`: The base name for the resource.
- `resource_type`: The type of the resource. Allowed values: virtual_machine, key_vault, storage_account.

#### Outputs

- `resource_name`: The generated resource name.

### 2. parent_module

This module serves as the interface for users to input a map of `base_name` and `resource_type` pairs. It calls the `naming_module` for each pair and reflects all the outputs of the child module.

#### Inputs

- `resource_map`: A map of base names and resource types.

#### Outputs

- `resource_names`: A list of generated resource names.
