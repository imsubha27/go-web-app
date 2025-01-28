# Deploy Go-Web-App on Cloud - DevOps Project!

**Step 1: Launch EC2:**

- Provision an EC2 instance on AWS.
- Connect to the instance using SSH.

**Step 2: Clone the Code:**

- Update all the packages and then clone the application's code repository onto the EC2 instance.

    ```bash
     git clone https://github.com/imsubha27/go-web-app.git
   ```
**Step 3: Install docker and run the app using docker container:**
  
- Install docker on EC2, build docker image, run image and then push image to your dockerhub account.
- Put your dockerhub username in place of imsubha27.

    ```bash
     docker build -t imsubha27/go-web-app:v1 .
     docker run -d -p 8080:8080 imsubha27/go-web-app:v1
     docker push imsubha27/go-web-app:v1
   ```
- Now you can access the go-web-app by **public-ip**:8080
  
**Step 4:  Kubernetes:**
- Install kubectl, eksctl, awscli on EC2.
- Create an EKS Cluster. 
  
    ```bash
     eksctl create cluster --name go-cluster --region us-east-1 --nodegroup-name go-worker --node-type t2.medium --nodes 2 --nodes-min 2 --nodes-max 3 --managed
   ```
- Apply deployments/services/ingress on kubernetes.

    ```bash
     kubectl apply -f kubernetes/deployment.yaml
     kubectl apply -f kubernetes/service.yaml
     kubectl apply -f kubernetes/ingress.yaml
   ```
 - Install Nginx Ingress Controller.
   
    ```bash
     kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.1/deploy/static/provider/aws/deploy.yaml
   ```

 - Get DNS address, Map DNS address with hostname on local.

    ```bash
     kubectl get ing #Get DNS address
     nslookup <DNS Adress> #Put the DNS address and get the IP address
     sudo vim etc/hosts #DNS mapping with hostname
   ```
 - Now you can access the the app by hostname, e.g. **go-web-app.local**
 - Delete everything on kubernetes resources, as we'll be installing evrything through helm.
    ```bash
     kubectl delete deploy go-web-app
     kubectl delete svc go-web-app
     kubectl delete ing go-web-app
   ```
                              
**Step 5:  Helm:**
- Install Helm, go the helm dir and install go-web-app using helm.

    ```bash
     helm install go-web-app ./go-web-app-chart
   ```
- Uninstall Helm.
    ```bash
     helm uninstall go-web-app 
   ```