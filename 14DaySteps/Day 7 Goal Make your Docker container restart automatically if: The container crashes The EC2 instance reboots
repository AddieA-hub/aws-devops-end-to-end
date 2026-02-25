# Day 7 Goal: Make your Docker container restart automatically if: The container crashes or The EC2 instance reboots

- Step 1: Stop and remove old containers 
```
docker ps
docker stop flask-devops-app
docker rm flask-devops-app
```
- Step 2:Run Container with Restart Policy to allow restart unless stopped
```
docker run -d \
  -p 80:5001 \
  --name flask-devops-app \
  --restart unless-stopped \
  859525218899.dkr.ecr.us-east-1.amazonaws.com/flask-devops-app:latest
```

- Step 3: Test Auto-Restart
Test container crash recovery:
```
docker kill flask-devops-app
docker ps
```
or reboot EC2 instance, log out and ssh back in.

- Step 4: After it comes back up:
```
docker ps
```
Container should be running automatically, if not, procced to step 5

- Step 5: It may not run if docker does not restart automatically when EC2 reboots 
  — Verify Docker Service
```
sudo systemctl status docker
```
If inactive 
```
sudo systemctl is-enabled docker
```
Code should return enabled

- Step 6: Repeat steps 1-4. 
