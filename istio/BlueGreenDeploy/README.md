#INSTALL COLIMA
colima start -k --disk 20 --cpu 4 --memory 12 --very-verbose --network-address --vm-type vz --kubernetes-version="v1.27.13+k3s1"

curl -L https://istio.io/downloadIstio | sh -

#INSTALL ISTIO
export PATH="$PATH:/Users/zhuxiang/istio-1.21.2/bin"

istioctl x precheck
istioctl install

#ENABLE ISTIO for namespace abtest
kubectl create ns abtest
kubectl label namespace abtest istio-injection=enabled
kubectl get namespace -L istio-injection

#DEPLOY nginx-v1 and nginx-v2
helm install -nabtest nginx-v1 ./nginx-versioned -f ./nginx-versioned/values-v1.yaml

helm install -nabtest nginx-v2 ./nginx-versioned -f ./nginx-versioned/values-v2.yaml

#SETUP istio ateway, virtualservice, etc. From there can check colima node ip, and ingress nodeport.
kubectl apply -f istio-gateway.yml
kubectl apply -f istio-settings.yml

kubectl get service istio-ingressgateway -n istio-system

#try set 2 deployment(nginx-v1, nginx-v2) use one k8s svc and set istio, but not work
#nginx-vs-svc.yaml, istio-settings-2.yml