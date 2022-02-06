## Install argocd
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

    kubectl get pods -n argocd -w

## Forward argocd service to local
    kubectl port-forward svc/argocd-server -n argocd 8080:443

## Get initial secret from argocd
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
>default user is admin

## Create project
kubectl create -f project.yml

## Deploy app 
    kubectl apply -f sealed-secrets.yml
    
    #another demo
    kubectl create -f demo-guestbook.yml

    #use argocd cli to deploy(need to manual sync on webui)
    argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default
## operation by argocd cli
after use kubectl to portforward argocd access port, or use a stable service entrance,

    argocd login 127.0.0.1:8080

## delete app
    argocd app delete guestbook
if use kubectl to delete, it will not clean resources in k8s.