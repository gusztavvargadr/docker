storage "consul" {
  address = "consul_client:8500"
  token   = "master"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

disable_mlock = true
ui = true
