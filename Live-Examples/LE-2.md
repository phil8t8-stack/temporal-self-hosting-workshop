# Begin by stopping the current service

```bash
helm uninstall my-temporal
```

# Downsize the shard count to 1

```bash
helm upgrade \
    --install \
    my-temporal temporalio/temporal \
    --set server.replicaCount=1 \
    --set cassandra.config.cluster_size=1 \
    --set elasticsearch.replicas=1 \
    --set prometheus.enabled=true \
    --set grafana.enabled=true \
    --set server.config.numHistoryShards=1 \
    --timeout 15m
```

- Explain what we are doing

# Ask the audience
READ THE FOLLOWING:
- In the previous example we had a single worker handle 100 state transitions per second easily. It was only when we increased our volume to 500 that a backlog started to build. 
- Additionally we had 512 shards, the default value set when we started the cluster.
- We've now decreased the shards to 1, so 1 persistence layer operation can be taken by the history service at any given time

QUESTION
- Of course, we expect slow down, that's a given, but do we think that the worker will be able to handle the 100 state transitions per second so easily?
- What about 10?

# Ensure the worker is started
```bash
go run ./cmd run-worker --scenario state_transitions_steady --run-id state_transitions_steady_test --language go
```

# Start with 100
```bash
go run ./cmd run-scenario --scenario state_transitions_steady --duration 2m --option state-transitions-per-second=100 --run-id state_transitions_steady_test &>> ../logs/state_transitions_steady.log
```

- Nope, it can no longer handle the test that before it was easily handling

# Next do with 10
```bash
go run ./cmd run-scenario --scenario state_transitions_steady --duration 2m --option state-transitions-per-second=10 --run-id state_transitions_steady_test &>> ../logs/state_transitions_steady.log
```


- As we can see 10 seems fine, but that is a massive decrease in capabilities.

# Open Grafana
- Coming up in the next session we'll explore these metrics but for the sake of showing you what this looks like in the observability layer

localhost:3000


```bash
kubectl get secret my-temporal-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```

```bash
curl -X POST "localhost:3000/api/dashboards/db" \
  -H "Authorization: Bearer <bearer-token>" \
  -H "Content-Type: application/json" \
  -d @bitovi-expanded-dashboard.json
```


1. Open up the Bitovi's Expanded Dashboard
2. Look at the History Cache Lock Latency
    - (X) milliseconds for our History cache is really bad.. If we had others shards this would be mucher lower as the additional load would be spread across the concurrent persistence events taking place.
3. Look at the 95th percentile graph
    - Look at the PollWorkflowTaskQueue operation.. in the single digit minute.. this again is awful and it's because there is only a single shard and that single shard's entire workload is updating the event history. 
4. Open the History Service dashboard
5. Take a look at the Latency panel
    - As expected the latency of our History operations is atrocious, and again this is because there is simply no free bandwidth for the history service to work

