#Installing Gloo Edge on Kubernetes
https://docs.solo.io/gloo-edge/latest/installation/gateway/kubernetes/

##check
kubectl get all -n gloo

#API gateway mode
glooctl get upstream -n gloo

glooctl get upstream -n gloo kafkaui-kafkaui-80 --output kube-yaml

kubectl label namespace kafkaui  discovery.solo.io/function_discovery=enabled

glooctl get upstream kafkaui-kafkaui-80 -n gloo --output kube-yaml

glooctl add route \
--name kafkaui \
--path-exact /kafkaui \
--dest-name kafkaui-kafkaui-80 \
--dest-namespace gloo-system \
--prefix-rewrite /

glooctl get vs kafkaui --output kube-yaml

curl $(glooctl proxy url -n gloo)/api/all-pets

kubectl create namespace gloo-system
helm install gloo gloo/gloo --namespace gloo-system \
--set gateway.enabled=false,ingress.enabled=true

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout my_key.key -out my_cert.cert -subj "/CN=gloo.example.com/O=gloo.example.com"

kubectl create secret tls my-tls-secret --key my_key.key --cert my_cert.cert

# get the IP:Port instead of the full URL this time
INGRESS_HTTPS=$(glooctl proxy url --name ingress-proxy --port https | sed -n -e 's/^.*:\/\///p')
echo $INGRESS_HTTPS

curl --cacert my_cert.cert --connect-to gloo.example.com:443:${INGRESS_HTTPS} https://gloo.example.com/api/pets

---
# create TLS ingress for kafkaui

#create cert file in kafkaui ns
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout my_key.key -out my_cert.cert -subj "/CN=oktatest.example.com/O=oktatest.example.com"
kubectl create secret -n kafkaui tls my-tls-secret --key my_key.key --cert my_cert.cert

create ingress for kafkaui

# get the IP:Port instead of the full URL this time
INGRESS_HTTPS=$(glooctl proxy url --name ingress-proxy --port https | sed -n -e 's/^.*:\/\///p')
echo $INGRESS_HTTPS

curl --cacert my_cert.cert --connect-to gloo.example.com:443:${INGRESS_HTTPS} https://oktatest.example.com/
