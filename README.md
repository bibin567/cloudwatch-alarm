# Cloudwatch-alarm

## Description

This repository contains code for setting up a CloudWatch alarm that tracks CPU usage on an EC2 instance. When the CPU usage exceeds 80% for a 5-minute period, an alert is sent using Amazon SNS. Additionally, an alternative action is provided to reboot the EC2 instance when the CPU usage exceeds 80%.

## Prerequisites

Before using the code in this repository, make sure you have the following prerequisites:

- An AWS account
- AWS CLI installed and configured with your credentials
- Terraform installed on your local machine

## Usage

Follow the steps below to set up and test the CloudWatch alarm:

1. Clone the repository to your local machine.

2. Modify the `variables.tf` file to customize the configuration according to your requirements. Set the following variables:

   - `aws_region`: The AWS region in which the resources will be created.
   - `access_key`: Your AWS access key.
   - `secret_key`: Your AWS secret key.
   - `vpc_cidr_block`: The CIDR block for the VPC.
   - `vpc_name`: The name of the VPC.
   - `sns_topic_name`: The name of the SNS topic.
   - `sns_topic_email`: The email address to which the SNS notifications will be sent.
   - `public_subnet_cidr_block`: The CIDR block for the public subnet.
   - `public_subnet_name`: The name of the public subnet.
   - `sg1_name`: The name of the security group.
   - `ami_name`: The name of the Amazon Machine Image (AMI) to use for the EC2 instance.
   - `instance1_name`: The name of the EC2 instance.

3. Initialize the Terraform configuration by running the following command:

```bash
Run
  terraform init
```
4. Create the necessary AWS resources by running the following command:

```bash
Run
  terraform apply
```
This will create the VPC, SNS topic, CloudWatch alarm, subnet, security group, internet gateway, route table, route table association, and EC2 instance.

5. Perform a CPU stress test on the EC2 instance to trigger the CloudWatch alarm. Monitor the CPU usage in the AWS Management Console.

6. If the CPU usage exceeds 80% for a 5-minute period, an alert will be sent to the specified email address. Check your email for the notification.

7. (Optional) To test an alternative action, instead of sending an SNS notification, the CloudWatch alarm can be configured to reboot the EC2 instance. Modify the `main.tf` file and uncomment the line that sets the `alarm_actions` property to perform the reboot action. Repeat steps 3-5 to test the reboot action.

## Cleanup

To clean up and delete the AWS resources created by this repository, run the following command:

```bash
Run
  terraform destroy
```
## Conclusion

By following the steps outlined above, you can set up a CloudWatch alarm that tracks CPU usage on an EC2 instance and sends alerts using Amazon SNS when the CPU exceeds 80%. Additionally, you can configure an alternative action to reboot the EC2 instance. Feel free to explore the code and customize it further to meet your specific requirements.


