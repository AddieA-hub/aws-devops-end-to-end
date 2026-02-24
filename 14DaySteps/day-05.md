# DAY 5 – Deploy to EC2

- Step 1: Launch an EC2 Instance
  - Go to AWS Console → EC2 → Launch Instance
  - Settings:
  - Name: flask-devops-server
  - AMI: Amazon Linux 2023 (or Amazon Linux 2)
  - Instance Type: t2.micro (Free tier)
  - Key Pair: Create new key pair (download .pem file!)
  - Network settings:
  - Allow SSH (22)
  - Allow HTTP (80)
  - Add a rule:
  - Type: Custom TCP
  - Port: 5001
  - Source: Anywhere
  - Launch the instance.

- Step 2: Connect to EC2
  - Click instance
  - Click Connect
  - Choose EC2 Instance Connect
  - Click Connect

- Step 3: Install Docker on EC2
Run:
```
sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
```
Then log out and reconnect (important for permissions).
Test:
```
docker --version
```

- Step 4: Authenticate EC2 to ECR
Inside EC2 terminal, run:
```
aws configure
```
Enter:
```
Access key
Secret key
Region: us-east-1
Output: json
```
Then login Docker to ECR:
```
aws ecr get-login-password --region us-east-1 \
| docker login --username AWS --password-stdin 859525218899.dkr.ecr.us-east-1.amazonaws.com
```

If successfull, you should see:
```
Login Succeeded
```

- Step 5: Pull Your Image
```
docker pull 859525218899.dkr.ecr.us-east-1.amazonaws.com/flask-devops-app:latest
```

- Step 6: Run the Container
Very important — map port 5001:

```
docker run -d -p 5001:5001 \
859525218899.dkr.ecr.us-east-1.amazonaws.com/flask-devops-app:latest
```
Check:
```
docker ps
```
You should see the container running.

- Step 7: Access Your App
  - Go back to EC2 dashboard.
  - Copy the Public IPv4 address.
  - Open browser and enter. Make sure to include :5001 or port used in url.
