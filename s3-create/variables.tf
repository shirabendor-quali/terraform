variable "region" {
    description = "Region where to create resources" 
    type = string
    default = "eu-west-1"
}

variable "name" {
    description = "Region where to create resources" 
    type = string
}

variable "encryption_key_arn" {
    default = ""
    type = string
}
