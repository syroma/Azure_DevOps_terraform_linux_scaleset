variable "heading_one" {
  description = "heading one title for index.html"
  default     = "hi im bob"
  type        = string
}

variable "location" {}

variable "prefix" {}

variable "address_space" {}

variable "address_prefixes" {}

variable "vm_size" {}
variable "instances" {}
variable "admin_username" {}

variable "publisher" {}
variable "offer" {}
variable "sku" {}
variable "imgversion" {}

variable "disk_caching" {}
variable "storage_account_type" {}

variable "forList" {
  type = map(object({
    name      = string
    age       = number
    eyecolor  = string
    haircolor = string
  }))
  default = {
    "david" = {
      name      = "david"
      age       = 30
      eyecolor  = "brown"
      haircolor = "brown"
    }
    "stan" = {
      name      = "stan"
      age       = 50
      eyecolor  = "blue"
      haircolor = "blond"
    }
  }
}