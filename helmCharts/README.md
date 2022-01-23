# Install applications with helm

## Add remote helm repo
    helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets

## Installing chart via remote repo
    kubectl create ns sealedsecrets
    helm install sealed-secrets sealed-secrets/sealed-secrets -n sealedsecrets

## Download remote helm chart to local
    helm pull sealed-secrets/sealed-secrets
    tar xvf sealed-secrets-2.1.1.tgz
## Installing chart from local templates
    