variable "BUCKET_NAME" {
}

variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_ACCESS" {
}

variable "USER_CONTENT" {
}

variable "SERVER_NAME" {
}

variable "SERVER_VERSION" {
}

variable "OUTPUTS_PUBLISHER_STR_OLD" {
}

variable "OUTPUTS_PUBLISHER_STR" {
}

variable "OUTPUTS_PUBLISHER_SPECIAL_CHARS_STR" {
}

variable "OUTPUTS_PUBLISHER_NUMBER" {
    type = number
}

variable "OUTPUTS_PUBLISHER_FRACTION" {
    type = number
}

variable "OUTPUTS_PUBLISHER_BOOL" {
    type = bool
}

variable "VIRTUAL_NETWORK_ID_NEW" {
}

variable "VIRTUAL_NETWORK_ID" {
}

variable "PUBLIC_ADDRESS_NEW" {
}

variable "PUBLIC_ADDRESS" {
}

variable "PUBLIC_ADDRESS_OLD" {
}

variable "SANDBOX_ID_NEW" {
}

variable "SANDBOX_ID" {
}

variable "SANDBOX_ID_OLD" {
}

variable "LITERAL_PARAMETER" {
}

variable "AWS_SSM_PARAMETER" {
}

variable "OUTPUTS" {
}

variable "ALL_IN_ONE" {
}

variable "TF_LIST_STRING" {
    type = list(string)
}

variable "TF_MAP" {
    type = map
}

variable "TF_TUPLE" {
    type = tuple([map(string),string,number])
}

variable "TF_OBJECT" {
    type = object({
        symbol = string
        price = number
        levels = list(number)
    })
}
