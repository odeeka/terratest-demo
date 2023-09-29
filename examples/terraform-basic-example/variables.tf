# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "example" {
  description = "Example variable"
  type        = string
  default     = "example"
}

variable "example2" {
  description = "Example variable 2"
  type        = string
  default     = "test"
}

variable "example_list" {
  description = "An example variable that is a list."
  type        = list(string)
  default     = []
}

variable "example_map" {
  description = "An example variable that is a map."
  type        = map(string)
  default     = {}
}

variable "example_any" {
  description = "An example variable that is can be anything"
  type        = any
  default     = null
}

variable "example_rg_name" {
  description = "An example variable that s can be anything"
  type = string
  default = ""
}

variable "tenant_id" {
  type    = string
  default = "8619c67c-945a-48ae-8e77-35b1b71c9b98"
}

variable "subscription_id" {
  type    = string
  default = "fe60a7de-b871-43b9-81ff-921945ef53ef"
}

variable "client_id" {
  type    = string
  default = "0f84ed37-2ddb-49af-8189-baf69920b8b4"
}

variable "client_secret" {
  type      = string
  default   = ".Wr8Q~i2pd1gojhbOCC4qRBHaUM768UPhcn73bce"
  sensitive = true
}
