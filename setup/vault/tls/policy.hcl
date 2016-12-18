backend "inmem" {
  path = "vault"
}

listener "tcp" {
  address = "127.0.0.1:8300"
  tls_disable = 1
}

listener "tcp" {
  address = "127.0.0.1:8400"
  tls_cert_file = "tls.crt"
  tls_key_file = "tls.key"

}

disable_mlock = true
