
# azure aks create app

## This file contains the commands to create an aks cluster with a running application 
requirements:

- have an azure account 
- have kubectl installed 
- have helm installed
- also, you should get Azure CLI installed if you don't work from the could 
- have your image uploaded to dockerhub in this case il be using my image at https://hub.docker.com/r/natai7/fastapi_html_bitcoin_printer 
    * using: natai7/fastapi_html_bitcoin_printer:0.02

### create a resource group

`az group create --name myResourceGroup --location eastus`

### create cluster 
wait a few seconds or the next command won't be able to run (check the portal)

`az aks create -g myResourceGroup -n myAKSCluster --enable-managed-identity --node-count 1 --enable-addons monitoring --enable-msi-auth-for-monitoring  --generate-ssh-keys`

### enable RBAC 
if you want you can do this at the end if you dont want to create roles right now

`az aks update -g myResourceGroup -n myAKSCluster --enable-aad `

`az aks update -g myResourceGroup -n myAKSCluster --enable-azure-rbac`

RBAC was enabledverify  
`az resource show -g myResourceGroup -n myAKSCluster --resource-type Microsoft.ContainerService/ManagedClusters --query properties.enableRBAC`

### get credentials

`az aks get-credentials -g myResourceGroup -n myAKSCluster`

## deploy the base app
`kubectl apply -f deployment.yaml`

### deploy ingress
`kubectl create namespace ingress-basic`

if you dont have the repo add it 

`helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx`

`helm repo update`

install command 

`helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-basic --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux --set controller.service.externalTrafficPolicy=Local`

add your ingress file 
`kubectl apply -f ingress.yaml`

### deploy network policies 
(in theory you should add the policies before the ingress)

`kubectl apply -f policies.yaml`

you can find the app on

http://20.81.97.59/service-A

http://20.81.97.59/service-B This is only a service and nothing is implemented (no deployment as of now)

the default gate will lead to service A

http://20.81.97.59

docker URL

https://hub.docker.com/r/natai7/fastapi_html_bitcoin_printer
