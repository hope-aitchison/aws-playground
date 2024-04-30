### General Variables ###
variable "profile" {
  description = "Account to deploy into"
  type        = string
  default     = "redhat-dev"
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

variable "app-name" {
  description = "name of the application"
  type        = string
  default     = "redhat"
}

variable "key-pair" {
  description = "instance key pair name"
  type        = string
  default     = "redhat-development"
}

variable "internet_cidr" {
  description = "cidr block for all IP range"
  type        = string
  default     = "0.0.0.0/0"
}

variable "rhel_9_ami" {
  description = "free tier HVM RHEL 9 AMI"
  type        = string
  default     = "ami-035cecbff25e0d91e"
}