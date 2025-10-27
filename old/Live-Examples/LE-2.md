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


# Open Grafana
- Coming up in the next session we'll explore these metrics but for the sake of showing you what this looks like in the observability layer

```
localhost:3000
```

```bash
kubectl get secret my-temporal-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```

```bash
curl -X POST "localhost:3000/api/dashboards/db" \
  -H "Authorization: Bearer <bearer-token>" \
  -H "Content-Type: application/json" \
  -d @bitovi-expanded-dashboard.json
```


- Open up the Bitovi's Expanded Dashboard
