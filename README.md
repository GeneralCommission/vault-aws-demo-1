# AWS Vault Demo
This repository contains example code and instructions for standing up an SSL-enabled Vault demo using the Vault Starter Module. This code might be useful when you want to see what a production reference architecture Vault cluster looks like and how easy it can be to set up.

https://github.com/hashicorp/terraform-aws-vault-starter

## Prerequisites
* A domain name that you own or control. Example: vaultdemo.net
* An AWS account where you can build resources [Instruqt sandboxes](https://play.instruqt.com/hashicorp/tracks/aws-sandbox-1) work well for this.
* Terraform with credentials configured for the AWS account above
* A default VPC to deploy the Vault cluster into
* An SSH key pair configured in the AWS region you want to deploy in

## Steps
1. If this is a fresh Instruqt-based AWS account you'll need to import your key pair and set up a default VPC before you do anything else. In these examples we're using us-west-2 as the region:

Import your key pair:
```bash
aws ec2 import-key-pair --key-name scarolan --public-key-material fileb://~/.ssh/id_rsa.pub --region us-west-2
```

Create a default VPC and make note of the VPC id.
```bash
aws ec2 create-default-vpc
```

2. Edit the main.tf file, replacing the VPC id and SSH key name with your own. You should also replace the owner and name_prefix with your own settings.

3. Build it! This should take around 10-12 minutes.

```bash
terraform init
terraform apply -auto-approve
```

4. Go into the AWS console and enter the AWS Certificate Manager page. Provision a new public certificate using your domain name. For example: **customer.vaultdemo.net**. You can use DNS validation, or if you own the domain name and have access to the administrator email account you can use email validation.

5. Once your SSL cert has been validated you can add a CNAME record to point your new hostname at the DNS of the AWS load balancer. Find the ELB dns address in the EC2 control panel under Load Balancers. This process may vary depending on your DNS provider.

6. Finally you can add an TLS listener in the load balancer settings to connect your new ACM certificate and enable SSL traffic to the Vault cluster. Go into the Listeners section for the load balancer and select TLS/443, for Default action(s) forward to your vault target group, and then select your ACM certificate at the very bottom under Default SSL Certificate. Click "Add Listener" at the top, and you're done! You can now access your Vault server at the DNS name you created using SSL. Note that you no longer need to add port 8200 to the end of the URL since AWS uses port 443 for TLS listeners.
