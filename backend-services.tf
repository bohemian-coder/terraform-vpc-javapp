# RDS Setup
resource "aws_db_subnet_group" "javapp-rds-subgrp" {
  name       = "javapp-rds-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Description = "RDS Subnet group"
  }
}

resource "aws_db_instance" "javapp-rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.6.34"
  instance_class         = "db.t2.micro"
  name                   = var.dbname
  username               = var.dbuser
  password               = file(var.dbpass)
  parameter_group_name   = "default.mysql5.6"
  multi_az               = "false"
  publicly_accessible    = "false"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.javapp-rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.javapp-backend-sg.id]
}

# Elastic cache
resource "aws_elasticache_subnet_group" "javapp-ecache-subgrp" {
  name       = "javapp-ecache-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
}

resource "aws_elasticache_cluster" "javapp-cache" {
  cluster_id             = "javapp-cache"
  engine                 = "memcached"
  node_type              = "cache.t2.micro"
  num_cache_nodes        = 1
  parameter_group_name   = "default.memcached1.5"
  port                   = 11211
  vpc_security_group_ids = [aws_security_group.javapp-backend-sg.id]
  subnet_group_name      = aws_elasticache_subnet_group.javapp-ecache-subgrp.name
}

# Amazon MQ

resource "aws_mq_broker" "javapp-rmq" {
  broker_name        = "javapp-rmq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.15.0"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.javapp-backend-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]

  user {
    username = var.rabbitmquser
    password = file(var.rabbitmqpass)
  }
}