Access the broker using the cli:
```
docker exec -it solace cli
```{{exec}}

List all available Queues
```
show queue *
```{{exec}}

Check the preconfigured Queues and their subscriptions:
```
show queue <QUEUE_NAME> subscriptions
```

Think about what's wrong with the subscriptions and remove subscriptions if they do not match the convention.

Enter the configution mode with
```
exit
enable
configure
message-spool message-vpn default
```{{exec}}

```
queue <QUEUE_NAME>
# remove subscriptions with
no subscription topic <TOPIC_NAME>
# add subscription with
subscription topic <TOPIC_NAME>
```