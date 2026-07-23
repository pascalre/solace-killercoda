#!/bin/bash

EXPECTED="200"

RESULT=$(curl -s -u admin:admin \
  "http://localhost:8080/SEMP/v2/config/msgVpns/default/queues/orderQueue/subscriptions" \
  | jq -r '.responseCode":200')

if echo "$RESULT" | grep -q "$EXPECTED"; then
  echo "Setup is done. You can now proceed to the next step."
  exit 0
else
  echo "Setup is still in progress."
  exit 1
fi