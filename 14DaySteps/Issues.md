## Issues Encoutered

# Day 2 
- Issue 1
    - I ran into an issue. I installed pip in the app folder then ran python app.py in the same folder and got this error 
'(venv) adinduaghanya@Adindus-Air app % python app.py Traceback (most recent call last): File 
"/Users/adinduaghanya/aws-devops-end-to-end/app/app.py", line 1, in <module> from flask import Flask ModuleNotFoundError:  No module named 'flask'
- Solution
    - Flask was never installed. I got a prompt to update pip. When I got the prompt to update pip, I was supposed to rerun the code pip install -r requirements.txt and rerun python app.py. I did this and it fixed the error. 


- Issue 2
    - I RAN THE python app.py but got this  * Serving Flask app 'app' * Debug mode: off Address already in use Port 5000 is in use by another program. Either identify and stop that program, or start the server with a different port. On macOS, try searching for and disabling 'AirPlay Receiver' in System Settings.'
- Solution
    - Port 5000 is already in use by my pc. So I updated the line below in my app.py file from 5000 to 5001
    - 
```
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
```

# Day 3
- Issue 1
    - I got this when I ran docker 'aws-devops-end-to-end % docker run -p 5001:5001 flask-devops-app Unable to find image 'flask-devops-app:latest' locally docker: Error response from daemon: pull access denied for flask-devops-app, repository does not exist or may require 'docker login' Run 'docker run --help' for more information'.
- Solution
- 
```
docker images
```
This should list the images. If nothing is listed then the image was never built. The issue was, the fullstop at the end of the code below was omitted.

```
docker build -t flask-devops-app .
```

# Day 4
- Issue 1
      - When i entered aws configure, i did not have a secret key and password. password cannot be retrieved when lost so i created a new secret key and password. 
- Solution
    - I have secret key and paasoword now saved in my downloads.

- Issue 2
    - When I was configuring in my CLI, i did not include the region and output format. this led to errors  
- Solution
    - Always include region and output format

# Day 5
- Issue 1
    - when I entered this docker pull 859525218899.dkr.ecr.us-east-1.amazonaws.com/flask-devops-app:latest - I GOT THIS 'no matching manifest for linux/amd64 in the manifest list entries'.
    - This means EC2 instance is linux/amd64 (assigned at setup) but the Docker image you pushed was built for a different architecture
Docker image is built on a Mac with Apple Silicon (M1/M2/M3) which builds images as
    - linux/arm64
but EC2 (t2.micro) runs on:
    - linux/amd64
- Solution
- Logged back into the project folder on CLI
- Built docker image with code below:
```
docker buildx build --platform linux/amd64 -t flask-devops-app .
```

- Issue 2
    - After rebuilding image, i tried to push to ecr repository using code below:
```
docker push 859525218899.dkr.ecr.us-east-1.amazonaws.com/flask-devops-app:latest
```

I got an error because I was not connected to ECR as connection lasts only 12hrs
- Solution
    - I relogged into ecr with code below
```
  aws ecr get-login-password --region us-east-1 \
| docker login --username AWS --password-stdin 859525218899.dkr.ecr.us-east-1.amazonaws.com
```

I pushed again with code below:
```
docker push 859525218899.dkr.ecr.us-east-1.amazonaws.com/flask-devops-app:latest
```
- Issue 3
    - After all was up and running on EC2, I copied in IPV4 public ip to test on the interbet but could not see the website.
- Solution
    - To debug, I checked the following
    - Confirm Security Group Allows Port 5001
        - Go to: AWS Console → EC2 → Security Groups
        - Select the security group attached to your instance.
        - Under Inbound Rules, you MUST have: Custom TCP, 5001, Anywhere (0.0.0.0/0)
    - Check Flask Is Listening on 0.0.0.0
        - In the app.py, code must be as below:
```
app.run(host="0.0.0.0", port=5001)
```
Flask binding to localhost instead of 0.0.0.0
    - Confirm container is running
```
docker ps
```
Expected result
```
0.0.0.0:5001->5001/tcp
```
Confirm you have the correct url. This was the issue at this stage, the :5001 was not included in the IPV4.




