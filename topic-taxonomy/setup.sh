#!/bin/bash
docker run -d -p 8080:8080 -p 55555:55555 -p '1943:1943' --shm-size=2g --name solace \
  --ulimit core=-1 \
  --ulimit nofile=2448:1048576 \
  --env username_admin_globalaccesslevel=admin \
  --env username_admin_password=admin \
  solace/solace-pubsub-standard

#Warten bis SEMP verfügbar ist
until curl -s -o /dev/null http://localhost:8080/SEMP/v2/config/about; do sleep 2; done

# Fehlerhafte Ausgangskonfiguration einspielen (kollidierende ACLs, falsche Wildcards)
curl -X PATCH -u admin:admin \
  -H "Content-Type: application/json" \
  -d @assets/broken-config.json \
  http://localhost:8080/SEMP/v2/config/msgVpns/default