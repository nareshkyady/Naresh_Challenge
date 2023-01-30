variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "us-east-1"
}
variable "PATH_TO_PRIVATE_KEY" {
    default = "mysedkey"
}
variable "PATH_TO_PUBLIC_KEY" {
    default = "mysedkey.pub"
}
variable "INSTANCE_USERNAME" {
    default = "ubuntu"
}