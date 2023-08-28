### General Variables ###
variable "profile" {
  description = "Account to deploy into"
  type        = string
  default     = "personal-aws-account"
}

variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-west-2" # London
}

variable "stage" {
  description = "The environment to deploy into"
  type        = string
  default     = "dev"
}