Access the broker using the cli:
```cmd
docker exec -it solace cli
```

List all available Queues
```
show queue *
```

Check the preconfigured Queues and subscriptions:
```
show queue demo subscriptions
```

The recommended topic taxonomy for ACME Retail is
```
acme/<domain>/<noun>/<verb>/<version>/<properties>
```

They defined that everything in their topic strings must be lowercase. Verbs must be written in past tense. Subscribers must use trailing multi level wild cards, to match future dynamic properties.
