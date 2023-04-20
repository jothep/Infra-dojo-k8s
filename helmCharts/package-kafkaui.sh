#!/bin/bash

#helm package
#package a chart directory into a chart archive

#./package-kafkaui.sh
#Successfully packaged chart and saved it to: /Users/zhuxiang/try/Infra-dojo-k8s/helmCharts/kafkaui-0.0.9.tgz

helm package --app-version "0.0.8" --version "0.0.9" ./kafkaui

