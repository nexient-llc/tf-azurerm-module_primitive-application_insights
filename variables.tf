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

variable "name" {
  description = "The name of the resource"
  type        = string
}

variable "location" {
  description = "The location/region where the resource will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resource will be created"
  type        = string
}

variable "application_type" {
  description = "Specifies the type of the application - web, ios, java etc."
  type        = string
  default     = "web"
}

variable "retention_in_days" {
  description = <<EOT
    Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730.
    Defaults to 90
  EOT
  type        = number
  default     = 30

  validation {
    condition     = contains([30, 60, 90, 120, 180, 270, 365, 550, 730], var.retention_in_days)
    error_message = "retention_in_days must be one of 30, 60, 90, 120, 180, 270, 365, 550 or 730"
  }
}

variable "daily_data_cap_in_gb" {
  description = "Specifies the Application Insights component daily data volume cap in GB."
  type        = number
  default     = null
}

variable "daily_data_cap_notifications_disabled" {
  description = "Specifies if a notification email will be send when the daily data volume cap is met."
  type        = bool
  default     = null
}

variable "sampling_percentage" {
  description = <<EOT
    Specifies the percentage of the data produced by the application which is sampled for Application Insights.
    Defaults to 100
  EOT
  type        = number
  default     = 100
}

variable "disable_ip_masking" {
  description = <<EOT
    By default the real client IP is masked as 0.0.0.0 in the logs. Use this argument to disable masking and
    log the real client IP. Defaults to false
  EOT
  type        = bool
  default     = false
}

variable "workspace_id" {
  description = "Specifies the id of a log analytics workspace resource."
  type        = string
  default     = null
}

variable "local_authentication_disabled" {
  description = " Disable Non-Azure AD based Auth. Defaults to false."
  type        = bool
  default     = false
}

variable "internet_ingestion_enabled" {
  description = "Should the Application Insights component support ingestion over the Public Internet? Defaults to true."
  type        = bool
  default     = true
}

variable "internet_query_enabled" {
  description = <<EOT
    Should the Application Insights component support querying over the Public Internet? Defaults to true.
  EOT
  type        = bool
  default     = true
}

variable "force_customer_storage_for_profiler" {
  description = <<EOT
    Should the Application Insights component force users to create their own storage account for profiling?
    Defaults to false.
  EOT
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
  default     = {}
}
