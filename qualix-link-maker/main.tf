variable "target_ip_address" {
  type = string
}

resource "random_uuid" "resource_uuid" {
}

resource "time_static" "current_time_static" {
}

locals {
  guid       = random_uuid.resource_uuid.result
  guid_stripped = replace(local.guid, "-", "")
  curr_time_secs = time_static.current_time_static.unix
  qtoken_clean = "${local.guid_stripped},${local.curr_time_secs * 10000000}"
  qtoken_encoded = base64encode(local.qtoken_clean)
  qtoken_encoded_modified = replace(replace(replace(local.qtoken_encoded,"+","-"),"/","_"),"=","~")
  password_encoded = replace(base64encode(var.target_password),"=","~")
  extra_attributes = var.protocol == "rdp" ? "&security=any&ignore-cert=true" : ""
}

output http_link {
  # value       = local.password_encoded
  value = "https://${var.qualix_ip}/remote/#/client/c/${var.protocol}${local.guid_stripped}?qtoken=${local.qtoken_encoded_modified}&hostname=${var.target_ip_address}&protocol=${var.protocol}&port=${var.connection_port}&username=${var.target_username}&password=${local.password_encoded}${local.extra_attributes}"
}
