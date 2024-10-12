#! /bin/bash

nmcli -f GENERAL.STATE con show ${1} | grep -q -E '\bactiv' \
  && echo '{"text":"Connected","class":"connected","percentage":100}' \
  || echo '{"text":"Disconnected","class":"disconnected","percentage":0}'
