#!/bin/bash
docker run -d -p 8080:8080 -p 55555:55555 --shm-size=1g --env username_admin_globalaccesslevel=admin --env username_admin_password=admin --name=solace --ulimit nofile=2448:1048576 solace/solace-pubsub-standard

#Warten bis SEMP verfügbar ist
until curl -s -o /dev/null http://localhost:8080/SEMP/v2/config/about; do sleep 2; done

# orders queue
curl -X POST -u admin:admin \
  -H "Content-Type: application/json" \
  -d '{"queueName":"orders"}' \
  http://localhost:8080/SEMP/v2/config/msgVpns/default/queues

curl -X POST -u admin:admin \
  -H "Content-Type: application/json" \
  -d '{"subscriptionTopic":"ACME/retail/Orders/Create/v1/*"}' \
  http://localhost:8080/SEMP/v2/config/msgVpns/default/queues/orders/subscriptions

# shipment queue
curl -X POST -u admin:admin \
  -H "Content-Type: application/json" \
  -d '{"queueName":"shipment"}' \
  http://localhost:8080/SEMP/v2/config/msgVpns/default/queues

curl -X POST -u admin:admin \
  -H "Content-Type: application/json" \
  -d '{"subscriptionTopic":"acme/logistics/shipment/shipped/v1"}' \
  http://localhost:8080/SEMP/v2/config/msgVpns/default/queues/shipment/subscriptions

# inventory queue
curl -X POST -u admin:admin \
  -H "Content-Type: application/json" \
  -d '{"queueName":"inventory"}' \
  http://localhost:8080/SEMP/v2/config/msgVpns/default/queues

curl -X POST -u admin:admin \
  -H "Content-Type: application/json" \
  -d '{"subscriptionTopic":"acme/inventory/stock/update/v1/>"}' \
  http://localhost:8080/SEMP/v2/config/msgVpns/default/queues/shipment/subscriptions

# customer queue
curl -X POST -u admin:admin \
  -H "Content-Type: application/json" \
  -d '{"queueName":"customer"}' \
  http://localhost:8080/SEMP/v2/config/msgVpns/default/queues

curl -X POST -u admin:admin \
  -H "Content-Type: application/json" \
  -d '{"subscriptionTopic":"acme/crm/customer/created/12345/>"}' \
  http://localhost:8080/SEMP/v2/config/msgVpns/default/queues/shipment/subscriptions


#
#Q:
#  ACME/sales/US-order/created/v1 -> acme/sales/order/created/v1/eu
#  ACME/sales/EU-order/created/v1 -> acme/sales/order/created/v1/us
#
#Q:
#  ACME/sales/*-order/created -> acme/sales/order/created/*
#
#Q:
#  ACME/sales/order/returns -> acme/sales/order/returned/*
#
#Q:
#  ACME/
#
#subscription:
#  acme/sales/created/order/* -> will not receive messages with more properties (will already break on version and country)
#  acme/sales/created/order/v1/US> -> will not receive messages with more properties (will already break on version)
#  acme/sales/returning/order/