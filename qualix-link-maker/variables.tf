variable "qualix_ip" {
  type = string
  default = "127.0.0.1"  
}

variable "target_username" {
  type = string
  default = "ubuntu"
}

variable "target_password" {
  type = string
  default = "P@$$w0rd1234!"
}

variable "protocol" {
  type = string
  default = "SSH"
}

variable "connection_port" {
  type = number
  default = 3389
}

