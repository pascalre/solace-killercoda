## Welcome to ACME Retail

ACME Retail is rolling out Event-Driven Architecture for the first time. Before the first event hits production, someone needs to sign off on the topic design — and that someone is you.

A junior architect put together a first draft of the topic taxonomy and pre-configured a handful of queues to demo it. It looked fine in the design review. It does not look fine anymore.

Your job: review the architecture, find what's broken, and fix it before this goes live.

## ACME Retail's Topic Taxonomy
```
acme/<domain>/<noun>/<verb>/<version>/<properties>
```

The rules, non-negotiable:

| Rule | Requirement |
|---|---|
| Casing | Everything lowercase |
| Verb tense | Past tense (`created`, not `create`) |
| Wildcards | Subscribers use a trailing multi-level wildcard (`>`) to stay compatible with future dynamic properties |
| Versioning | ACME is early in its EDA journey — every event is currently `v1` |

Four rules. One broker. A handful of queues that don't follow them.

Let's find out which ones.