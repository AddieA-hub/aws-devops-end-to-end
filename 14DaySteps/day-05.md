# DAY 4: PUSH YOUR DOCKER IMAGE TO AWS (ECR)
- Docker image is stored in Amazon ECR (AWS’s container registry).
  
Mental model 
- Docker image → built on your laptop
- ECR → AWS’s private Docker Hub
- EC2/ECS will pull images from ECR

- STEP 1: Configure AWS CLI (10 minutes)
Run:
```
aws configure
``` 
Enter:
- AWS Access Key ID
- AWS Secret Access Key
- Default region → choose one (e.g. us-east-1)
- Output format → json

- STEP 2: Create an ECR repository 
Run
```
aws ecr create-repository \
  --repository-name flask-devops-app \
  --region us-east-1
```

You’ll get output containing something like:

```
123456789012.dkr.ecr.us-east-1.amazonaws.com/flask-devops-app
```
Copy this URL


- STEP 3: Authenticate Docker to ECR 
Run:
```
aws ecr get-login-password --region us-east-1 \
| docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com
```
You should see:

```
Login Succeeded
```

- STEP 4: Tag your Docker image 
First, confirm the image exists:

```
docker images
```

Then tag it for ECR: Command is docker tag flask-devops-app:latest/(url copied above). See below:

```
docker tag flask-devops-app:latest \
123456789012.dkr.ecr.us-east-1.amazonaws.com/flask-devops-app:latest
```


- STEP 5: Push the image to ECR

```
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/flask-devops-app:latest
```

You’ll see layers uploading.


- STEP 6: Verify in AWS Console
  - Open AWS Console
  - Go to ECR → Repositories → flask-devops-app
  - Confirm the image is there
