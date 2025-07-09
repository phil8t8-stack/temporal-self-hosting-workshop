5. Benchmarking and Load Simulation

In the previous section, we developed a deep understanding of the out-of-the-box Grafana dashboards that Temporal suggests for self-hosted usage. We created an enhanced dashboard with even more metrics, incorporating best practices from Bitovi’s work with their customers. Most importantly, we simulated failures across loosely and tightly coupled services, observing how Temporal reacted in various failure scenarios.

Depending on which service is interrupted, we can expect slightly different types of failures. For example, if the frontend service is disrupted, failures involving external services, such as the UI or workers, will appear, since the frontend acts as the gateway for external communication with the Temporal server. Alternatively, if the history service is interrupted, we can expect persistence-related failures, as the history node manages state tracking.

Critical services, such as the persistence datastore, which maintains state across all other Temporal services, mean that a failure at this layer can cause widespread outages and major disruptions.

Simulating failures is valuable for uncovering real-world issues and learning to diagnose problems. However, it primarily helps us react to issues (put out fires), rather than proactively prevent them (fire-proof the building). This is where benchmarking and load simulation come in.

Benchmarking allows us to systematically measure Temporal’s performance, discover bottlenecks, and make informed decisions about system tuning. Load simulation provides insight into how the system behaves under varying amounts of traffic and stress. Together, they enable us to anticipate and prepare for scaling challenges, optimize reliability, and ensure Temporal delivers the performance our applications require before issues arise in production.

Let's get started by reviewing the [benchmarking tool](./5.1.Benchmarking.md).