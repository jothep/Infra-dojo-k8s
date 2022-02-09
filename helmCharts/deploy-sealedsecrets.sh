#!/bin/bash -eu

helm upgrade sealedsecrets ./sealed-secrets \
  --install \
  --create-namespace \
  --namespace kube-system \
  --values sealed-secrets/values.yaml \
  --values sealed-secrets/extra-values.yaml \
  --set podLabels.label1=mylabel
