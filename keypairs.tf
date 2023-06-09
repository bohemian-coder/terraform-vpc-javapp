resource "aws_key_pair" "javappkey" {
    key_name = "javappkey"
    public_key = file(var.PUB_KEY_PATH)
}