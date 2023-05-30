variable "rg-name" {
  description = "Resource Group name"
  type = string
}

variable "rg-location" {
    description = "Resource Group location"
    type = string
}

variable "rg-tags" {
    description = "Tags "
    type = map(any)
}