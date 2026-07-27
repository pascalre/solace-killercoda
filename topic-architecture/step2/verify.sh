#!/bin/bash
RESULT=$(curl -s -u admin:admin \
  "http://localhost:8080/SEMP/v2/config/msgVpns/default/queues/orders/subscriptions" \
  | jq -r '.data[].subscriptionTopic')

if echo "$RESULT" | grep -q "acme/retail/orders/created/v1/>"; then
  echo "Taxonomy correctly configured."
  exit 0
else
  echo "Subscription topic does not match expected taxonomy pattern."
  exit 1
fi

RESULT=$(curl -s -u admin:admin \
  "http://localhost:8080/SEMP/v2/config/msgVpns/default/queues/shipment/subscriptions" \
  | jq -r '.data[].subscriptionTopic')

if echo "$RESULT" | grep -q "acme/logistics/shipment/shipped/v1/>"; then
  echo "Taxonomy correctly configured."
  exit 0
else
  echo "Subscription topic does not match expected taxonomy pattern."
  exit 1
fi

RESULT=$(curl -s -u admin:admin \
  "http://localhost:8080/SEMP/v2/config/msgVpns/default/queues/inventory/subscriptions" \
  | jq -r '.data[].subscriptionTopic')

if echo "$RESULT" | grep -q "acme/inventory/stock/updated/v1/>"; then
  echo "Taxonomy correctly configured."
  exit 0
else
  echo "Subscription topic does not match expected taxonomy pattern."
  exit 1
fi

RESULT=$(curl -s -u admin:admin \
  "http://localhost:8080/SEMP/v2/config/msgVpns/default/queues/customer/subscriptions" \
  | jq -r '.data[].subscriptionTopic')

if echo "$RESULT" | grep -q "acme/crm/customer/created/v1/>"; then
  echo "Taxonomy correctly configured."
  exit 0
else
  echo "Subscription topic does not match expected taxonomy pattern."
  exit 1
fi