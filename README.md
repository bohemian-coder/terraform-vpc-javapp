# terraform-vpc-javapp

Terraform: Deploy sample java application to AWS Beanstalk

### AWS Resources:-

- VPC: Subnets, route tables, NAT Gateway with Elastic IP, Internet Gateway, Security groups, Elastic Load Balancer, DNS resolution, ACLs
- EC2: Bastion Host, Backend instances, Frontend instances
- AWS Beanstalk
- RDS
- Amazon MQ

This sample uses terraform modules: https://registry.terraform.io/

TO validate network once the env is created;
- Update DB URL in application.properties with the domain url.
- Build project using mvn or gradle based on preference
- Upload artifact to application env on AWS