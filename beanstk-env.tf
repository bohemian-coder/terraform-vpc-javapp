resource "aws_elastic_beanstalk_environment" "javapp-bean-prod-env" {
    name = "javapp-bean-prod-env"
    application = aws_elastic_beanstalk_application.javapp-bean-prod
    solution_stack_name = "64bit Amazon Linux 2 v4.3.8 running Tomcat 8.5 Corretto 11"
    cname_prefix = "javapp-bean-prod-domain"
    setting {
        namespace = "aws:ec2:vpc"
        name = "VPCId"
        value = module.vpc.default_vpc_id
    }
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "IamInstanceProfile"
        value = "aws-elastickbeanstalk-ec2-role"
    }
    setting {
        namespace = "aws:ec2:vpc"
        name = "AssociatePublicIpAddress"
        value = false
    }
    setting {
        namespace = "aws:ec2:vpc"
        name = "subnets"
        value = join(",", [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]])
    }
    setting {
        namespace = "aws:ec2:vpc"
        name = "ELBsubnets"
        value = join(",", [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]])
    }
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "InstanceType"
        value = "t2.micro"
    }
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "EC2KeyName"
        value = aws_key_pair.javappkey.key_name
    }
    setting {
        namespace = "aws:autoscaling:asg"
        name = "Availability Zone"
        value = "Any 3"
    }
    setting {
        namespace = "aws:autoscaling:asg"
        name = "MinSize"
        value = 1
    }
    setting {
        namespace = "aws:autoscaling:asg"
        name = "MaxSize"
        value = 6
    }
    setting {
        namespace = "aws:elasticbeanstalk:application:environment"
        name = "environment"
        value = "prod"
    }
    setting {
        namespace = "aws:elasticbeanstalk:application:environment"
        name = "LOGGING_APPENDER"
        value = "GRAYLOG"
    }
    setting {
        namespace = "aws:elasticbeanstalk:healthreporting:system"
        name = "SystemType"
        value = "basic"
    }
    setting {
        namespace = "aws:elasticbeanstalk:updatepolicy:rollingupdate"
        name = "RollingUpdateEnabled"
        value = "true"
    }
    setting {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name      = "RollingUpdateType"
        value     = "Health"
    }
    setting {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name      = "MaxBatchSize"
        value     = "1"
    }
    setting {
        namespace = "aws:elb:loadbalancer"
        name      = "CrossZone"
        value     = "true"
    }
    setting {
        name      = "StickinessEnabled"
        namespace = "aws:elasticbeanstalk:environment:process:default"
        value     = "true"
    }
    setting {
        namespace = "aws:elasticbeanstalk:command"
        name      = "BatchSizeType"
        value     = "Fixed"
    }
    setting {
        namespace = "aws:elasticbeanstalk:command"
        name      = "BatchSize"
        value     = "1"
    }
    setting {
        namespace = "aws:elasticbeanstalk:command"
        name      = "DeploymentPolicy"
        value     = "Rolling"
    }
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "SecurityGroups"
        value     = aws_security_group.javapp-beanstalk-prod-sg.id
    }
    setting {
        namespace = "aws:elbv2:loadbalancer"
        name      = "SecurityGroups"
        value     = aws_security_group.javapp-beanstalk-elb-sg.id
    }

    depends_on = [aws_security_group.aws_security_group.javapp-beanstalk-elb-sg, aws_security_group.aws_security_group.javapp-beanstalk-prod-sg]

}