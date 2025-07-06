data "http" "ip" {
    url = "https://api.ipify.org"
}

locals {
    my_ip = "${data.http.ip.response_body}/32"
}

output "my_ip_address" {
  description = "My local machine's IP"
   value = local.my_ip
}