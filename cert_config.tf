# certificate_config.tf

# Request and validate an SSL certificate from AWS Certificate Manager (ACM)
resource "aws_iam_server_certificate" "iam_cert" {
  name      = "iam_cert"
  certificate_body = "${file("certificates/server.crt")}"
  private_key      = "${file("certificates/server.key")}"

}


resource "tls_private_key" "example" {
  algorithm = "RSA"
  #rsa_bits  = "4096"
}

resource "tls_self_signed_cert" "example" {
  private_key_pem = tls_private_key.example.private_key_pem
  is_ca_certificate = true

  subject {
    common_name  = "amazonaws.com"
    organization = "SED Challenge, Inc"
  }

  validity_period_hours = 720

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "cert_signing"
  ]
}

resource "aws_acm_certificate" "my-certificate" {
  private_key      = tls_private_key.example.private_key_pem
  certificate_body = tls_self_signed_cert.example.cert_pem
}