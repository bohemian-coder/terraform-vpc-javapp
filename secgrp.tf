resource "aws_security_group" "javapp-beanstalk-elb-sg" {
    name = "javapp-beanstalk-elb-sg"
    description = "Security group for beanstalk-elb"
    vpc_id = module.vpc.default_vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "javapp-bastion-sg" {
    name = "javapp-bastion-sg"
    description = "Security group for jump box instance"
    vpc_id = module.vpc.default_vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.MYIP
    }
}

resource "aws_security_group" "javapp-beanstalk-prod-sg" {
    name = "javapp-beanstalk-prod-sg"
    description = "Security group for beanstalk instances"
    vpc_id = module.vpc.default_vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [aws_security_group.javapp-bastion-sg.id]
    }
}

resource "aws_security_group" "javapp-backend-sg" {
    name = "javapp-backend-sg"
    description = "Security group for RDS, elastic cache and active MQ"
    vpc_id = module.vpc.default_vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        security_groups = [aws_security_group.javapp-beanstalk-prod-sg.id]
    }
}

resource "aws_security_group_rule" "allow_access_from_self" {
    type = "ingress"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    security_group_id = aws_security_group.javapp-backend-sg.id
    source_security_group_id = aws_security_group.javapp-backend-sg.id
}