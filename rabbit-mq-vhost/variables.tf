variable "host" {
  default     = "infra.sandbox.com"
  description = "RabbitMQ host"
}

variable "admin_username" {
  default     = "admin"
  description = "RabbitMQ user"
}

variable "admin_password" {
  default     = "admin"
  description = "RabbitMQ password"
  sensitive   = true
}

variable "username" {
  default     = "colony"
  description = "RabbitMQ user"
}

variable "password" {
  default     = "colony"
  description = "RabbitMQ password"
  sensitive   = true
}

variable "vhost" {
  default     = "colony"
  description = "Colony vhost name"
}
