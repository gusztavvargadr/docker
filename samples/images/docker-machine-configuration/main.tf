provider "local" {
  version = "1.1.0"
}

provider "tls" {
  version = "1.1.0"
}

provider "template" {
  version = "1.0.0"
}

variable "machines" {
  default = "default"
}

variable "domain" {
  default = "local"
}

variable "path" {
  default = "."
}

locals {
  machines = ["${split(",", var.machines)}"]

  tls_algorithm                  = "RSA"
  tls_cert_validity_period_hours = 8760
  tls_domain                     = "${var.domain}"

  storage_path = "${var.path}"

  output_path  = "/data"
}

resource "tls_private_key" "ca" {
  algorithm = "${local.tls_algorithm}"
}

resource "tls_self_signed_cert" "ca" {
  key_algorithm   = "${tls_private_key.ca.algorithm}"
  private_key_pem = "${tls_private_key.ca.private_key_pem}"

  subject {
    common_name = "ca.${local.tls_domain}"
  }

  validity_period_hours = "${local.tls_cert_validity_period_hours}"

  allowed_uses = [
    "cert_signing",
  ]

  is_ca_certificate = true
}

resource "local_file" "ca_private_key_certs" {
  content  = "${tls_private_key.ca.private_key_pem}"
  filename = "${local.output_path}/certs/ca-key.pem"
}

resource "local_file" "ca_cert_certs" {
  content  = "${tls_self_signed_cert.ca.cert_pem}"
  filename = "${local.output_path}/certs/ca.pem"
}

resource "tls_private_key" "client" {
  algorithm = "${local.tls_algorithm}"
}

resource "tls_cert_request" "client" {
  key_algorithm   = "${tls_private_key.client.algorithm}"
  private_key_pem = "${tls_private_key.client.private_key_pem}"

  subject {
    common_name = "client.${local.tls_domain}"
  }

  dns_names = [
    "client",
    "client.${local.tls_domain}",
  ]
}

resource "tls_locally_signed_cert" "client" {
  cert_request_pem   = "${tls_cert_request.client.cert_request_pem}"
  ca_key_algorithm   = "${tls_private_key.ca.algorithm}"
  ca_private_key_pem = "${tls_private_key.ca.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.ca.cert_pem}"

  validity_period_hours = "${local.tls_cert_validity_period_hours}"

  allowed_uses = [
    "client_auth",
  ]
}

resource "local_file" "client_private_key_certs" {
  content  = "${tls_private_key.client.private_key_pem}"
  filename = "${local.output_path}/certs/key.pem"
}

resource "local_file" "client_cert_certs" {
  content  = "${tls_locally_signed_cert.client.cert_pem}"
  filename = "${local.output_path}/certs/cert.pem"
}

resource "tls_private_key" "server" {
  algorithm = "${local.tls_algorithm}"

  count = "${length(local.machines)}"
}

resource "tls_cert_request" "server" {
  key_algorithm   = "${element(tls_private_key.server.*.algorithm, count.index)}"
  private_key_pem = "${element(tls_private_key.server.*.private_key_pem, count.index)}"

  subject {
    common_name = "${element(local.machines, count.index)}.${local.tls_domain}"
  }

  dns_names = [
    "${element(local.machines, count.index)}",
    "${element(local.machines, count.index)}.${local.tls_domain}",
  ]

  count = "${length(local.machines)}"
}

resource "tls_locally_signed_cert" "server" {
  cert_request_pem   = "${element(tls_cert_request.server.*.cert_request_pem, count.index)}"
  ca_key_algorithm   = "${tls_private_key.ca.algorithm}"
  ca_private_key_pem = "${tls_private_key.ca.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.ca.cert_pem}"

  validity_period_hours = "${local.tls_cert_validity_period_hours}"

  allowed_uses = [
    "server_auth",
  ]

  count = "${length(local.machines)}"
}

resource "local_file" "ca_cert_machine" {
  content  = "${tls_self_signed_cert.ca.cert_pem}"
  filename = "${local.output_path}/machines/${element(local.machines, count.index)}/ca.pem"

  count = "${length(local.machines)}"
}

resource "local_file" "client_private_key_machine" {
  content  = "${tls_private_key.client.private_key_pem}"
  filename = "${local.output_path}/machines/${element(local.machines, count.index)}/key.pem"

  count = "${length(local.machines)}"
}

resource "local_file" "client_cert_machine" {
  content  = "${tls_locally_signed_cert.client.cert_pem}"
  filename = "${local.output_path}/machines/${element(local.machines, count.index)}/cert.pem"

  count = "${length(local.machines)}"
}

resource "local_file" "server_private_key_machine" {
  content  = "${element(tls_private_key.server.*.private_key_pem, count.index)}"
  filename = "${local.output_path}/machines/${element(local.machines, count.index)}/server-key.pem"

  count = "${length(local.machines)}"
}

resource "local_file" "server_cert_machine" {
  content  = "${element(tls_locally_signed_cert.server.*.cert_pem, count.index)}"
  filename = "${local.output_path}/machines/${element(local.machines, count.index)}/server.pem"

  count = "${length(local.machines)}"
}

data "template_file" "machine_config_machine" {
  template = "${file("${path.module}/templates/machine.json")}"

  vars {
    server = "${element(local.machines, count.index)}"
    domain = "${local.tls_domain}"
    path   = "${local.storage_path}"
  }

  count = "${length(local.machines)}"
}

resource "local_file" "machine_config_machine" {
  content  = "${element(data.template_file.machine_config_machine.*.rendered, count.index)}"
  filename = "${local.output_path}/machines/${element(local.machines, count.index)}/config.json"

  count = "${length(local.machines)}"
}

data "template_file" "server_config_linux_machine" {
  template = "${file("${path.module}/templates/server.linux.json")}"

  count = "${length(local.machines)}"
}

resource "local_file" "server_config_linux_machine" {
  content  = "${element(data.template_file.server_config_linux_machine.*.rendered, count.index)}"
  filename = "${local.output_path}/machines/${element(local.machines, count.index)}/server.linux.json"

  count = "${length(local.machines)}"
}

data "template_file" "server_config_windows_machine" {
  template = "${file("${path.module}/templates/server.windows.json")}"

  count = "${length(local.machines)}"
}

resource "local_file" "server_config_windows_machine" {
  content  = "${element(data.template_file.server_config_windows_machine.*.rendered, count.index)}"
  filename = "${local.output_path}/machines/${element(local.machines, count.index)}/server.windows.json"

  count = "${length(local.machines)}"
}

data "template_file" "server_script_linux" {
  template = "${file("${path.module}/templates/server.sh")}"
}

resource "local_file" "server_script_linux" {
  content  = "${data.template_file.server_script_linux.rendered}"
  filename = "${local.output_path}/server.sh"
}

data "template_file" "server_script_windows" {
  template = "${file("${path.module}/templates/server.ps1")}"
}

resource "local_file" "server_script_windows" {
  content  = "${data.template_file.server_script_windows.rendered}"
  filename = "${local.output_path}/server.ps1"
}

data "template_file" "client_script_linux" {
  template = "${file("${path.module}/templates/client.sh")}"
}

resource "local_file" "client_script_linux" {
  content  = "${data.template_file.client_script_linux.rendered}"
  filename = "${local.output_path}/client.sh"
}

data "template_file" "client_script_windows" {
  template = "${file("${path.module}/templates/client.ps1")}"
}

resource "local_file" "client_script_windows" {
  content  = "${data.template_file.client_script_windows.rendered}"
  filename = "${local.output_path}/client.ps1"
}
