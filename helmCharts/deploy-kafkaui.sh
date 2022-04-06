#!/bin/bash

helm upgrade kafkaui ./kafkaui \
     --install \
     --create-namespace \
     --namespace kafkaui \
     --values kafkaui/values.yaml \
     --values kafkaui/values-env.yaml