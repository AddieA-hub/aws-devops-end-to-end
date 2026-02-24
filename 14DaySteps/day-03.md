# DAY 3: DOCKERIZE THE FLASK APPLICATION

Docker packages your app + Python + Flask into a container. The container runs the same on your laptop, AWS, CI/CD, everywhere.

- STEP 1: Make sure Docker is running
  - Run on CLI:
```
docker --version
```

- STEP 2: Create a Dockerfile 
From the project root (aws-devops-end-to-end):
```
touch Dockerfile
```
Open dockerfile and paste 

```
# Use a lightweight Python image
FROM python:3.10-slim

# Set working directory inside container
WORKDIR /app

# Copy dependency file first (better catching)
COPY app/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/app.py .

# Expose port used by Flask
EXPOSE 5001

# Run the application
CMD ["python", "app.py"]
```

- STEP 3: Build the Docker image
From the project root:
```
docker build -t flask-devops-app .
```
  - The code above would build a docker image that works for the architecture of the environment you are building. For example, if this is built on apple, it will not run on linux because apple is arm64 and linux is amd64.
  - To prevent this error you have two options.
  - option 1 is to build for the  free tier cloud environment. See code below:
```
docker buildx build --platform linux/amd64 -t flask-devops-app .
```
 - option 2 is to build for all the possible environments that you know:
```
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t flask-devops-app \
  --push .
```

- STEP 4: Run the container 
Run:
```
docker run -p 5001:5001 flask-devops-app
```
code above maps container port → your laptop port, Flask runs inside Docker, but you access it from your browser

- STEP 5: Open the browser to view from docker 
Go to: http://localhost:5001

- STEP 6: Stop the container 
In the terminal running Docker: Ctrl + C

- STEP 7: Commit your work
```
git status
git add Dockerfile
git commit -m "Dockerize Flask application"
git push
```
