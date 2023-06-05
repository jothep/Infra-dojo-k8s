#!/bin/bash
helm upgrade vault ./vault --install --values vault/values.yaml --values vault/custom-values.yaml