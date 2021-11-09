variable "BUCKET_NAME" {
}

variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_ACCESS" {
}

variable "SERVER_NAME" {
}

variable "SERVER_VERSION" {
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

variable "LITERAL_PARAMETER" {
}

variable "AWS_SSM_PARAMETER" {
}

variable TF_INPUT_STRING {
    type = string
}

variable TF_INPUT_NUMBER {
    type = number
}

variable "TF_INPUT_LIST" {
    type = list(string)
}

variable "TF_INPUT_MAP" {
    type = map
}

variable "TF_INPUT_TUPLE" {
    type = tuple([map(string),string,number])
}

variable "TF_INPUT_OBJECT" {
    type = object({
        symbol = string
        price = number
        levels = list(number)
    })
}
