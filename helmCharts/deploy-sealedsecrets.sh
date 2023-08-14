#!/bin/bash -eu

#this version of sealed secret are out of date, cannot run
#Just for the format to generate SA an by check exist
helm upgrade sealedsecrets ./sealed-secrets \
  --install \
  --create-namespace \
  --namespace kube-system \
  --values sealed-secrets/values.yaml \
  --values sealed-secrets/extra-values.yaml \
  --set podLabels.label1=mylabel
