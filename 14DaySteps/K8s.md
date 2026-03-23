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
- Auto scaling based on CPU
```
kubectl autoscale deployment flask-app --min=2 --max=10 --cpu-percent=70
```
- Your CI/CD pipeline (GitHub Actions, Jenkins, etc.) then runs kubectl apply automatically when you push code. So scaling is treated like any other code change. 
Kubernetes has a controller that constantly watches your pods and compares the current state to your desired state (what's in your YAML). If a pod dies:

- Kubernetes detects it's gone
- Automatically spins up a new pod to replace it
- The new pod joins the service and starts receiving traffic

- This happens within seconds, automatically, with no manual intervention. That's why replicas: 3 is safer than replicas: 1 in production — if one pod crashes, the other two keep serving traffic while Kubernetes heals the third
