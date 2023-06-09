# terraform-vpc-javapp

Terraform: Deploy sample java application to AWS Beanstalk

This sample utilizes terraform modules.

Components:-

- VPC: Subnets, route tables, NAT Gateway with Elastic IP, Internet Gateway, Security groups, Elastic Load Balancer, DNS resolution, ACLs
- Instances: Bastion Host
- Other resources: AWS Beanstalk, RDS