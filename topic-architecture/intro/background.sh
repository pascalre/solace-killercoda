#!/bin/bash
docker run -d -p 8080:8080 -p 55555:55555 --shm-size=1g --env username_admin_globalaccesslevel=admin --env username_admin_password=admin --name=solace --ulimit nofile=2448:1048576 solace/solace-pubsub-standard

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