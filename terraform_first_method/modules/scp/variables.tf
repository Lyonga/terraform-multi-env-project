variable "scp_name" {
  description = "The name of the SCP"
  type        = string
}

variable "scp_description" {
  description = "The description of the SCP"
  type        = string
}

variable "scp_content" {
  description = "The JSON content of the SCP"
  type        = string
}

variable "target_ou_id" {
  description = "The ID of the target OU for the SCP"
  type        = string
}
