# Terraform Block

terraform {
  required_version = "~> 1.0.7"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.60.0"
    }
  }
}

# Provider Block
provider "aws" {
  region = "us-east-1"
}


# Security group that allow 22 and 8080

resource "aws_security_group_rule" "vcp-ssh-jenkins" {
    #name               = "vpc-ssh-jenkins"
    description        = "ssh port and jenkins port"
    type               = "ingress"
    from_port          = 8080
    to_port            = 8080
    protocol           = "tcp"
    cidr_blocks        = ["0.0.0.0/0"]
    security_group_id = "sg-034044a8927fe75ae"
}

# Resource: EC2 Instance
resource "aws_instance" "myec2vm"{
  ami = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-034044a8927fe75ae"]
  key_name = "new-amazon-key"
}


### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  public-dns = aws_instance.myec2vm.*.public_dns,
  public-ip = aws_instance.myec2vm.*.public_ip,
  public-id = aws_instance.myec2vm.*.id,
 }
 )
 filename = "inventory"
}
