# aws-playground
Created to host a RedHat server for SysAdmin work.

## Terraform AWS Modules used in this repository:
https://github.com/terraform-aws-modules/terraform-aws-vpc
https://github.com/terraform-aws-modules/terraform-aws-ec2-instance
https://github.com/terraform-aws-modules/terraform-aws-security-group
https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table

## Network
Builds a VPC, and 2 sets of subnets across a and b availabilty zones; 2 private and 2 public.
VPC Endpoints created for remote access to instance hosted in private subnet.
VPC Endpoint security group with https ingress from VPC CIDR.

## Remote-backend
Builds an S3 / DynamoDB backend for remote state management. State files stored in S3 and state locking via DynamoDB. 

## App
Builds an EBS-volume backed EC2 instance, using the latest RHEL 9 AMI available from AWS catalogue.
Instance security group ingress rule allows for https traffic from VPC endpoints security group, and all egress https traffic.
IAM role grants for Systems Manager actions.
AWS secret stores local IP address, accessed using data sources.
User data file contains installation instructions for AWS SSM agent (not installed by default on RHEL AMI) and python3.