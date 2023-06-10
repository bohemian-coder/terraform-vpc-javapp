# Setup bastion host to access private instances
resource "aws_instance" "javapp-bastion" {
  ami                    = lookup(var.AMIS, var.REGION)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.javappkey.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.javapp-bastion-sg.id]
  tags = {
    Name : "javapp-bastion"
  }

  provisioner "file" {
    content     = templatefile("templates/dbschema-deploy.tmpl", { rds-endpoint = aws_db_instance.javapp-rds.address, dbuser = var.dbuser, dbpass = file(var.dbpass) })
    destination = "/tmp/javapp-dbschemadeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/javapp-dbschemadeploy.sh",
      "sudo /tmp/javapp-dbschemadeploy.sh"
    ]
  }

  connection {
    user        = var.USERNAME
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }

  depends_on = [aws_db_instance.javapp-rds]
}
