# Terraform AWS EC2 Instance Deployment

This repository contains Terraform configuration files to deploy an EC2 instance on AWS.

## Prerequisites

Before you begin, make sure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html)
- AWS account with appropriate permissions

## Usage

1. Clone this repository:

   ```bash
   git clone https://github.com/wussh/terraform-aws.git
   ```

2. Navigate to the cloned directory:

   ```bash
   cd terraform-aws
   ```

3. Create a `production.tfvars` file and add your AWS access key, secret key, and any other required variables:

   ```plaintext
   access_key = "YOUR_ACCESS_KEY_HERE"
   secret_key = "YOUR_SECRET_KEY_HERE"
   key_name = "YOUR_KEY_PAIR_NAME_HERE"
   ec2_name = "YOUR_EC2_INSTANCE_NAME_HERE"
   ```

4. Initialize Terraform:

   ```bash
   terraform init
   ```

5. Run Terraform plan to see what changes will be applied:

   ```bash
   terraform plan -var-file=production.tfvars
   ```

6. Apply the Terraform configuration to create the EC2 instance:

   ```bash
   terraform apply -var-file=production.tfvars
   ```

7. After the deployment is complete, the public IP address of the EC2 instance will be displayed in the Terraform output. You can also retrieve it using:

   ```bash
   terraform output instance_public_ip
   ```

## IAM User and Access Key Creation

To use Terraform with your AWS account, you'll need to create an IAM user and generate an access key:

1. Log in to the AWS Management Console.

2. Navigate to the IAM service.

3. Click on "Users" in the left sidebar.

4. Click on "Add user".

5. Enter a username.

6. Click on "Next: Permissions".

7. Attach policies that grant the necessary permissions for Terraform operations. For example, you can attach the "AdministrationAccess" policy to allow managing EC2 instances.

8. Click on "Next: Tags" and optionally add any tags.

9. Click on "Next: Review".

10. Review the user details and click on "Create user".

11. Once the user is created, you'll see a success message along with the user's access key ID and secret access key. Make sure to copy these keys and keep them secure, as they will be needed to authenticate Terraform with AWS.

12. After creating the user and obtaining the access keys, add them to the `production.tfvars` file as `access_key` and `secret_key` respectively.


## Passwordless SSH Access Setup

To set up passwordless SSH access to your EC2 instances, follow these steps:

1. **Ensure your SSH agent is running and has your key added:**

    ```sh
    eval "$(ssh-agent -s)"
    ssh-add /home/wush/playground/terraform-aws/kocak.pem
    ```

2. **Copy your public key to the EC2 instances manually using `scp`:**

    ```sh
    scp -i /home/wush/playground/terraform-aws/kocak.pem ~/.ssh/id_rsa.pub ubuntu@<EC2_PUBLIC_IP>:~
    ```

3. **Log in to each EC2 instance using SSH and configure the keys:**

    ```sh
    ssh -i /home/wush/playground/terraform-aws/kocak.pem ubuntu@<EC2_PUBLIC_IP>
    ```

    Once logged in, run:

    ```sh
    mkdir -p ~/.ssh
    cat ~/id_rsa.pub >> ~/.ssh/authorized_keys
    rm ~/id_rsa.pub
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys
    exit
    ```

4. **Try logging in again without specifying the key:**

    ```sh
    ssh ubuntu@<EC2_PUBLIC_IP>
    ```