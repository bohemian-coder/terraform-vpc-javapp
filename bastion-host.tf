# Setup bastion host to access private instances
resource "aws_instance" "javapp-bastion" {
    ami = lookup(var.AMIS, var.REGION)
    instance_type = "t2.micro"
    key_name = aws_key_pair.javappkey.key_name
    subnet_id = module.vpc.public_subnets[0]
    count = var.instance_count
    vpc_security_group_ids = [aws_security_group.javapp-bastion-sg.id]
    tags = {
      Name: "javapp-bastion"
    }
}
