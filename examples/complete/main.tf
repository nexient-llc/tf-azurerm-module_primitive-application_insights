// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "resource_names" {
  source = "git::https://github.com/nexient-llc/tf-module-resource_name.git?ref=1.1.0"

  for_each = var.resource_names_map

  logical_product_family  = var.product_family
  logical_product_service = var.product_service
  region                  = var.region
  class_env               = var.environment
  cloud_resource_type     = each.value.name
  instance_env            = var.environment_number
  maximum_length          = each.value.max_length
}

module "resource_group" {
  source = "git::https://github.com/nexient-llc/tf-azurerm-module_primitive-resource_group.git?ref=0.2.0"

  name     = module.resource_names["rg"].standard
  location = var.region

  tags = merge(var.tags, { resource_name = module.resource_names["rg"].standard })

}

module "log_analytics_workspace" {
  source = "git::https://github.com/nexient-llc/tf-azurerm-module_primitive-log_analytics_workspace.git?ref=0.1.1"

  name                = module.resource_names["log_workspace"].standard
  location            = var.region
  resource_group_name = module.resource_group.name
  sku                 = var.sku

  tags = merge(var.tags, { resource_name = module.resource_names["log_workspace"].standard })

  depends_on = [module.resource_group]

}

module "app_insights" {
  source = "../.."

  name                = module.resource_names["app_insights"].standard
  location            = var.region
  resource_group_name = module.resource_group.name
  workspace_id        = module.log_analytics_workspace.id

  tags = merge(var.tags, { resource_name = module.resource_names["app_insights"].standard })

  depends_on = [module.resource_group, module.log_analytics_workspace]
}
