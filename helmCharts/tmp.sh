#!/usr/bin/env bash

if [[ -z $AccountName || -z $AccountKey || -z $Container ]]; then
  echo 'one or more variables are undefined'
  exit 1
fi

echo "You are good to go"
