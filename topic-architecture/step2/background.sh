until curl -s -o /dev/null http://localhost:8080/SEMP/v2/config/about; do
  sleep 2;
done

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
  http://localhost:8080/SEMP/v2/config/msgVpns/default/queues/inventory/subscriptions

# customer queue
curl -X POST -u admin:admin \
  -H "Content-Type: application/json" \
  -d '{"queueName":"customer"}' \
  http://localhost:8080/SEMP/v2/config/msgVpns/default/queues

curl -X POST -u admin:admin \
  -H "Content-Type: application/json" \
  -d '{"subscriptionTopic":"acme/crm/customer/created/12345/>"}' \
  http://localhost:8080/SEMP/v2/config/msgVpns/default/queues/customer/subscriptions
