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
    description = "Security group for EC2 jump box"
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
    description = "Security group for EC2 instances"
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
