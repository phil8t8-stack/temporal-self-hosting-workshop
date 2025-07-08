# 5. Simulating Load
In the previous section we built up an understanding of the out-of-the-box Grafana dashboards that Temporal suggests for self-hosting usage. We created a dashboard with even more metrics based on the work Bitovi has done for their customers. Most importantly we simulated failures across loosely and tightly coupled services and watched how Temporal reacted.

Loosely coupled services such as frontend, history, matching and worker mean that a failure will cause minor error and service event disruption, but the system will continue to work, waiting until such a time that the failed service is available once again.

Tightly coupled services such as the persistence datastore which manage state across all other Temporal services means that a failure causes outage and major disruptions.

Though this does illustrate potential real work issues and how to begin diagnosing them, it doesn't do much in the ways of performance tuning. Sure we can put out fires with this knowledge, but how can we fire-proof the building, so to speak? Well, that's where load simulation comes in. 

Let's get started by [reviewing the Omes load simulation tool](./5.1.Using-Omes-For-Load-Simulation.md)
