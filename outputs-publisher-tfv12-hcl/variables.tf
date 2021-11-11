variable "num" {
  type = number
  default = 5
}

variable "fraction" {
  type = number
  default = 0.001
}

variable "boolean" {
  type = bool
  default = true
}

variable "tf_string" {
  type = string
  default = "some-text"
}

variable "tf_tuple" {
  type = tuple([map(string),string,number])
  default = [{key1 = "out-val1", key2 = "out-val2"}, "out-string", 6.7]
}

variable "tf_object" {
  type = object({
      symbol = string
      price = number
      levels = list(number)
  })
  default = {symbol = "GRVI", price = 1.2, levels = [1, 1.1, 1.4]}
}
