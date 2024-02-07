variable "html_data" {
  description = "heading one title for index.html"
  default     = "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\" /><style>body {background-color: #101010;color: #ffffff;}h1 {color: #ffffff;}nav a {color: #ffffff;}footer {color: #ffffff;}</style><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" /><meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\" /><title>My Website</title><link rel=\"stylesheet\" href=\"./style.css\" /><link rel=\"icon\" href=\"./favicon.ico\" type=\"image/x-icon\" /></head><body><main><h1>Welcome to My Website</h1></main><script src=\"index.js\"></script></body></html>"
  type        = string
}

variable "location" {}

variable "resource_group" {}

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

variable "public_key_path" {}
