Nuvolar
---
_...Test Assignment 🚀..._

### Preconditions
Install the following software:
- [terraform ](https://www.terraform.io/)
- [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
- [docker](https://docs.docker.com/get-docker/)

### Minikube Setup
Run minikube:
``` bash
$ sudo usermod -aG docker $USER && newgrp docker #(Optional)
$ minikube start
```
If you run Optional command, you can run ***docker*** command without ***sudo*** command.

Enable the Nginx Ingress.
``` bash
$ minikube addons enable ingress
```

### API Gateway Setup
Configure the k8s cluster using Terraform, it can take near 1 min estimated.
Terraform will use the context minikube configured in `~/.kube/config`
``` bash
$ terraform init
$ terraform plan
$ terraform apply
```

If you want to destroy the K8S cluster, please run.
``` bash
$ terraform destroy
```

Append the host endpoint entry to `/etc/hosts`
``` bash
$ sudo echo $(minikube ip) test.com >> /etc/hosts
```

### Test
You can test api-gateway using curl command:
``` bash
$ curl -X GET http://test.com:31016/order
$ curl --head http://test.com:31016/order
```

### Commands to Debugs
minikube
``` bash
$ minikube stop
$ minikube start
$ minikube status
$ minikube ssh
$ minikube service list
$ minikube addons list | grep enabled
```

K8S
``` bash
$ kubectl get pods -A
$ kubectl get services -A
$ kubectl get ingress -A
$ kubectl get deployments -A
$ kubectl config set-context --current --namespace=NAMESPACE_NAME
$ kubectl describe pod POD_NAME -n NAMESPACE_NAME
$ kubectl describe service SERVICE_NAME -n NAMESPACE_NAME
$ kubectl describe ingress INGRESS_NAME -n NAMESPACE_NAME
$ kubectl describe deployment DEPLOYMENT_NAME -n NAMESPACE_NAME
$ kubectl logs POD_NAME -n NAMESPACE_NAME
$ kubectl exec --stdin --tty POD_NAME -- /bin/sh
```

### Why I choose what I choose ?

##### terraform:
Because, it is an standard in IaC, it has a long community. Many people contribute writing code, modules, libraries.
On the other hand, is very fast, maintain the state of the infrastructure, can work in a CI/CD, support many provider,
low curve to learn.
In this example, I use to create the K8S using minikube, but we can adapt to run in Google Cloud, Amazon AWS, Azure an others.
We can create monitors, dashboard, alert in Datadog, NewRelic and other providers while we are creating the K8S cluster.

##### minikube:
I was a long time using minikube as there is simply alternatives and to be honest it does a pretty good job at being a 
local Kubernetes for development environment. You can create the cluster, wait a few minutes and you are ready to go. 

##### docker:
It is the de facto Standard to build and share containerized applications and supported for many providers and container orchestrators.
It provides:
- Security
- Isolation
- Reproducible Image
- Easy CI/CD