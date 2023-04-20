#!/bin/bash

#helm template
#locally render templates

#./template-kafkaui.sh
#---
## Source: kafkaui/templates/serviceaccount.yaml
#apiVersion: v1
#kind: ServiceAccount
#metadata:
#  name: kafkaui
#  labels:
#    helm.sh/chart: kafkaui-0.0.3
#    app.kubernetes.io/name: kafkaui
#    app.kubernetes.io/instance: kafkaui
#    app.kubernetes.io/version: "0.0.3"
#    app.kubernetes.io/managed-by: Helm
#---
#...


helm template kafkaui ./kafkaui \
      -f kafkaui/values.yaml \
      --namespace kafkaui \
      --set image.repository="provectuslabs/kafka-ui" \
      --set image.tag="0.3.3"