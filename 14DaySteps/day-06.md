# Day 6 Goal: Make your app accessible on public IP without :PORT

- In production, applications:
  - Run inside containers on non-privileged ports (like 5000)
  - Expose port 80 at the host level
  - Use Docker port mapping to forward traffic
  - We will: Map EC2 port 80 → Container port 5000
 
  - Step 1: Update EC2 Security Group and conform inbound rules
```
Type	Protocol	Port	Source
HTTP	TCP	      80	  0.0.0.0/0
```

- In EC2
Check status of containers
```
docker ps -a
```
Stop running docker using container ID or name
```
docker stop flask-devops-app
```
```
docker rm flask-devops-app
```
Run docker image to update the port 
```
docker run -d \
  -p 80:5001 \
  --name flask-devops-app \
  859525218899.dkr.ecr.us-east-1.amazonaws.com/flask-devops-app:latest
```
- Public IP should now work in browser, No port number needed, traffic to port 80 will forward to your Flask container on port 5001.
