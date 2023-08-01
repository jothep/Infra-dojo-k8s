#!/usr/bin/env bash

#source abc-config
echo "show env"

if [[ -z "${AC_ALBAN}" ]]; then
  MY_SCRIPT_VARIABLE="Some default value because DEPLOY_ENV is undefined"
else
  MY_SCRIPT_VARIABLE="${AC_ALBAN}"
fi
echo $MY_SCRIPT_VARIABLE
sleep 10000
