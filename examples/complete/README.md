# complete

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.67 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | git::https://github.com/nexient-llc/tf-module-resource_name.git | 1.1.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | git::https://github.com/nexient-llc/tf-azurerm-module_primitive-resource_group.git | 0.2.0 |
| <a name="module_log_analytics_workspace"></a> [log\_analytics\_workspace](#module\_log\_analytics\_workspace) | git::https://github.com/nexient-llc/tf-azurerm-module_primitive-log_analytics_workspace.git | 0.1.1 |
| <a name="module_app_insights"></a> [app\_insights](#module\_app\_insights) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_product_family"></a> [product\_family](#input\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"dso"` | no |
| <a name="input_product_service"></a> [product\_service](#input\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"kube"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region in which the infra needs to be provisioned | `string` | `"eastus"` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-module-resource\_name to generate resource names | <pre>map(object(<br>    {<br>      name       = string<br>      max_length = optional(number, 60)<br>    }<br>  ))</pre> | <pre>{<br>  "app_insights": {<br>    "max_length": 60,<br>    "name": "appins"<br>  },<br>  "log_workspace": {<br>    "max_length": 60,<br>    "name": "logs"<br>  },<br>  "rg": {<br>    "max_length": 60,<br>    "name": "rg"<br>  }<br>}</pre> | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone,<br>    Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018. | `string` | `"PerGB2018"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_insights_id"></a> [app\_insights\_id](#output\_app\_insights\_id) | n/a |
| <a name="output_app_insights_name"></a> [app\_insights\_name](#output\_app\_insights\_name) | n/a |
| <a name="output_log_analytics_id"></a> [log\_analytics\_id](#output\_log\_analytics\_id) | n/a |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
