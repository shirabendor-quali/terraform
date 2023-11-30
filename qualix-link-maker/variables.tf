variable "qualix_ip" {
  type = string
  default = "127.0.0.1"  
}

variable "target_username" {
  type = string
  default = "ec2-user"
}

variable "target_password" {
  type = string
  default = "1234"
}

variable "protocol" {
  type = string
  default = "ssh"
}

variable "connection_port" {
  type = number
  default = 3389
}

