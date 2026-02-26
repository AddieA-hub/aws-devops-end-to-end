# Day 8 Goal- Recreate your infrastructure using Terraform (Infrastructure as Code)

Step 1 — Create Project Structure (Locally)
On your PC:
```
mkdir terraform-aws-devops
cd terraform-aws-devops
```
Create a terraform file:
```
touch main.tf
```

Step 2 — Add Terraform Configuration to create the structure below:
```
VPC (10.0.0.0/16)
│
├── Public Subnet (10.0.1.0/24)
│     ├── Internet Gateway
│     ├── Route Table (0.0.0.0/0 → IGW)
│     └── EC2 (Flask App)
│
└── Security Group
```
- Breakdowm of main.tf script
- 
VPC
```
provider "aws" {
  region = "eu-north-1" # Should align with region that has available AMI and key pair. Gotten from EC2 created in thesame region with similar OS
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" #CIDR notation, defines number of IP addresses. 16 is used for VPC. 32 in total as each number
                          represents 8, the first two are fixed as 8 which totals 16, so the remaining two can get any combination
                          from 0-255. Total of 65.536 IPs
                          can be provided as it is calculated by 2^16. 2 is used because each bit can be 0 or 1
  enable_dns_hostnames = true

  tags = {
    Name = "flask-devops-vpc" #Name of vpc 
  }
}
```
Internet Gateway (Required for internet access)
```
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "flask-igw"
  }
}
```
Public Subnet
```
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24" # CIDR notation, defines number of IP addresses. 24 is used for VPC. 32 in total as each number
                          represents 8, the first three are fixed as 8 which totals 24, so the remaining one can get any combination
                          from 0-255. Total of 256 IPs
                          can be provided as it is calculated by 2^8. 2 is used because each bit can be 0 or 1
  map_public_ip_on_launch = true
  availability_zone       = "eu-north-1a"

  tags = {
    Name = "flask-public-subnet"
  }
}
```
Route Table 

```
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
```
Security Group
```
resource "aws_security_group" "flask_sg" {
  name        = "flask-devops-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to the IP of the PC that will SSH into server
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```
EC2 Created in the Subnet
```
resource "aws_instance" "flask" {
  ami                    = "ami-xxxxxxxx"  # Use correct AMI for region
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.flask_sg.id]
  key_name               = "your-key" # Created the first time an EC2 is launched and can be used to SSH

  tags = {
    Name = "Flask-Devops-Terraform"
  }
}
```
Complete main.tf script 
```
provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "flask-devops-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "flask-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-north-1a"

  tags = {
    Name = "flask-public-subnet"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "flask_sg" {
  name        = "flask-devops-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "flask" {
  ami                    = "ami-056335ec4a8783947"  # Use correct AMI for region
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.flask_sg.id]
  key_name               = "flaskappkeypair"

  tags = {
    Name = "Flask-DevOps-Terraform"
  }
}
```
Step 3: Initialise and run terraform to create a state file and launch all infrastructure as stated
```
terraform init   # ensures providers/modules are loaded
terraform plan   # check what Terraform wants to create 
terraform apply  # creates full networking + EC2
```
- What we should have after terraform apply (7 resources)
  - VPC
  - Internet Gateway
  - Public Subnet
  - Route Table
  - Route Table Association
  - Security Group
   -EC2 Instance

Step 4- List all insfrastructure created by terraform
```
terraform state list
```
Step 5 - SSH into launched EC2 (Remotely connect to AWS Server)
```
chmood 400 flaskappkeypair.pem # Activates permissions that allow key file read only for me. Should be done from folder with key-pair.
ssh -i flaskappkeypair.pem ec2-user@<public-ip> # This can only be done from the folder that the downloaded key-pair is saved. Username
                                                depends on AMI. EC2-USER for amazon linux, ubuntu for ubuntu
```

Current Architecture
```
User
↓
Internet Gateway
↓
Public Subnet
↓
EC2
↓
Security Group (80 + 22 open)
```
