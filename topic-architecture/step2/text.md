## Time to Investigate

The broker is up. Somewhere in there are queues that were configured before anyone checked them against the standard. Let's find out how bad it is.

Drop into the Solace CLI:

```
docker exec -it solace cli
```{{exec}}

See what's actually on the broker:

```
show queue *
```{{exec}}

Now the real work starts. Pick a queue and check what it's actually subscribed to:

```
show queue <QUEUE_NAME> subscriptions
```

Go through each one and hold it up against the four rules from the intro — casing, verb tense, wildcard, version. Anything that doesn't match, doesn't belong.

## Fixing What You Find

Once you know what's wrong, drop into configuration mode:

```
enable
configure
message-spool message-vpn default
```{{exec}}

From here, each broken subscription gets removed and replaced with one that actually follows the taxonomy:

```
queue <QUEUE_NAME>
```

remove the subscription that violates the standard
```
no subscription topic <TOPIC_NAME>
```

replace it with one that follows acme/<domain>/<noun>/<verb>/<version>/<properties>

```
subscription topic <TOPIC_NAME>
```

Work through every queue. This lab isn't done until all of them comply.