#!/bin/bash

STATUS=$(curl -s -o /dev/null -w "%{http_code}" \
  -u admin:admin \
  http://localhost:8080/SEMP/v2/config/about)

if [ "$STATUS" -eq 200 ]; then
  echo "Setup is done. You can now proceed to the next step."
  exit 0
else
  echo "Setup is still in progress."
  exit 1
fi
