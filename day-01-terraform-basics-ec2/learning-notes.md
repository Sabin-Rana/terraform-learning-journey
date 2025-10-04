# EC2 Quick Reference

## My Mental Model: Building a Computer

Think of EC2 like assembling a computer:
1. Pick the OS (AMI)
2. Choose hardware specs (instance_type)
3. Decide where to put it (subnet)
4. Set up firewall rules (security_group)
5. Give it permissions (IAM role)
6. Add startup commands (user_data)
7. Label it (tags)

## Core Components I Need to Remember

AMI - The operating system template
- Region specific (ami-xxx only works in one region)
- Common: Amazon Linux, Ubuntu, Windows

Instance Type - The hardware power
- t2.micro: 1 CPU, 1GB RAM (free tier)
- t2.small: 1 CPU, 2GB RAM
- Pattern: t=general, c=compute heavy, r=memory heavy, m=balanced

Subnet - Where it lives
- Public subnet = has internet access
- Private subnet = internal only

Security Group - The firewall
- Stateful (response automatically allowed)
- Default blocks everything inbound

## Basic Patterns I Use

Minimal EC2:
```hcl
resource "aws_instance" "server" {
  ami           = "ami-0b1dcb5abc47cd8b5"
  instance_type = "t2.micro"
  
  tags = {
    Name = "MyServer"
  }
}
```

EC2 with networking:
```hcl
resource "aws_instance" "server" {
  ami                    = "ami-0b1dcb5abc47cd8b5"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
}
```

EC2 with startup script:
```hcl
resource "aws_instance" "server" {
  ami           = "ami-0b1dcb5abc47cd8b5"
  instance_type = "t2.micro"
  
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
  EOF
}
```

## Instance States Flow

pending -> running -> stopping -> stopped -> terminated

Stop = pause (still pay for storage)
Terminate = delete forever

## IP Address Types

Private IP - internal network only (always there)
Public IP - internet accessible (temporary, changes on stop/start)
Elastic IP - static public IP (costs money when not attached)

## Common Mistakes I Made

Problem: Can't SSH into instance
Check: Security group has port 22 open, instance has public IP, using correct key

Problem: AMI not found error
Cause: Using AMI from different region

Problem: Instance terminated accidentally
Lesson: Enable termination protection for important instances

## Quick SSH Commands

```bash
ssh ec2-user@PUBLIC_IP              # Amazon Linux
ssh ubuntu@PUBLIC_IP                # Ubuntu
ssh -i mykey.pem ec2-user@PUBLIC_IP # With key file
```

## Storage Quick Notes

EBS - network attached, persistent (keeps data after stop)
Instance Store - temporary, faster (loses data on stop)

Root volume - usually deleted on termination (can change with delete_on_termination = false)

## Terraform Attributes I Use Often

```hcl
ami                     # Which OS image
instance_type           # Hardware size
subnet_id               # Network location
vpc_security_group_ids  # Firewall rules
key_name                # SSH key pair
user_data               # Startup script
iam_instance_profile    # Permissions
tags                    # Labels

disable_api_termination # Prevent accidental deletion
```

## My Rule of Thumb

For learning/testing: t2.micro (free tier)
For small web apps: t3.small or t3.medium
For databases: r5 series (more RAM)
For processing: c5 series (more CPU)

## User Data Use Cases

Install web server, download app code, configure services, set hostname, mount volumes, register with monitoring

Remember: user_data only runs on first boot (not on restart)