variable "str" {
  type = string
  default = "some text"
}

variable "list" {
  type    = list
  default = ["a", "b", "c"]
}

variable "map" {
  type = map
  default = {
      "user-a" = "a-topic",
      "user-b" = "c-topic",
      "user-c" = "c-topic"
  }
}

variable "obj" {
  type = map
  default = {
    "age" = 52,
    "name" = "John",
    "user" = [
      {
        "user-a" = "a-topic",
        "user-b" = "c-topic",
        "user-c" = "c-topic"
      }
    ],
    "data" = "/!@#$@#%#$^!!~///!~\"!@#$!#~~~//##\\$\\#$%^&*(&*()sa\\df\nAFSDRFQW1'2''3'''4''''SDFSDF\\sdfrt\\\tt{}|||'''''df'"
  }           
}