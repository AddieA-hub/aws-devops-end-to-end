- Deploy Docker Container to Kubernetes
```
1. Current (AWS EC2 + Docker + CI/CD) ✅
2. New (Kubernetes via Minikube) ✅
```

- Setp 1: Download minikube and kubectl with homebrew
```
brew install minikube
brew install kubectl
```
- Step 2: Use Minikube Docker and rebuild docker image 
```
eval $(minikube docker-env)
```
- Step 3: Create new directory and files
```
mkdir k8s
touch deployment.yaml
touch service.yaml
```
deployment.yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: flask-app
  template:
    metadata:
      labels:
        app: flask-app
    spec:
      containers:
      - name: flask-container
        image: flask-devops-app
        imagePullPolicy: Never
        ports:
        - containerPort: 5001
```
service.yaml
```
apiVersion: v1
kind: Service
metadata:
  name: flask-service
spec:
  type: NodePort
  selector:
    app: flask-app
  ports:
    - port: 80
      targetPort: 5001
      nodePort: 30007
```
- Step 4: Build the image inside minikube apply and run
```
docker build -t flask-devops-app .
kubectl apply -f k8s/
kubectl get pods
minikube service flask-service
```
