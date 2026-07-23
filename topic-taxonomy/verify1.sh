#!/bin/bash

EXPECTED="acme/sales/order/created/v1/>"

RESULT=$(curl -s -u admin:admin \
  "http://localhost:8080/SEMP/v2/config/msgVpns/default/queues/orderQueue/subscriptions" \
  | jq -r '.data[].subscriptionTopic')

if echo "$RESULT" | grep -q "$EXPECTED"; then
  echo "Taxonomy correctly configured."
  exit 0
else
  echo "Subscription topic does not match expected taxonomy pattern."
  exit 1
fi