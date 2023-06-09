variable "REGION" {
    default = "us-east-1"
}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0261755bbcb8c4a84"
        us-east-2 = "ami-0430580de6244e02e"
        us-west-1 = "ami-04d1dcfb793f6fa37"
    }
}

variable "PRIV_KEY_PATH" {
    default = "javappkey"
}
variable "PUB_KEY_PATH" {
    default = "javappkey.pub"
}
variable "USERNAME" {
    default = "ubuntu"
}
variable "MYIP" {
    default = "72.177.12.138/32"
}
variable "rabbitmquser" {
    default = "rabbit"
}
variable "rabbitmqpass" {
    default = file("./auth/rmqpass.txt")
}
variable "dbuser" {
    default = "admin"
}
variable "dbname" {
    default = "accounts"
}
variable "dbpass" {
    default = file("./auth/dbpass.txt")
}
variable "instance_count" {
    default = "1"
}
variable "VPC_NAME" {
    default = "javapp-vpc"
}
variable "ZONE1" {
    default = "us-east-1a"
}
variable "ZONE2" {
    default = "us-east-1b"
}
variable "ZONE3" {
    default = "us-east-1c"
}
variable "VPC_CIDR_BlK" {
    default = "173.31.0.0/16"
}
variable "pubSub1_CIDR" {
    default = "173.31.1.0/24"
}
variable "pubSub2_CIDR" {
    default = "173.31.2.0/24"
}
variable "pubSub3_CIDR" {
    default = "173.31.3.0/24"
}
variable "privSub1_CIDR" {
    default = "173.31.4.0/24"
}
variable "privSub2_CIDR" {
    default = "173.31.5.0/24"
}
variable "privSub3_CIDR" {
    default = "173.31.6.0/24"
}