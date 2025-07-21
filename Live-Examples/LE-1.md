```bash
helm upgrade \
    --install \
    my-temporal temporalio/temporal \
    --set server.replicaCount=1 \
    --set cassandra.config.cluster_size=1 \
    --set elasticsearch.replicas=1 \
    --set prometheus.enabled=true \
    --set grafana.enabled=true \
    --timeout 15m
```
# Begin by ensuring the we are port-forwarding the Temporal Frontend service and webUI

```bash
kubectl port-forward deployment/my-temporal-frontend 7233 7233
```

```bash
kubectl port-forward deployment/my-temporal-web 8080 8080
```

# From the root of this project ensure you run
```bash
git clone https://github.com/temporalio/omes.git
```

# Next start a worker
```bash
go run ./cmd run-worker --scenario state_transitions_steady --run-id state_transitions_steady_test --language go
```

# Start the activity generator
```bash
go run ./cmd run-scenario --scenario state_transitions_steady --duration 2m --option state-transitions-per-second=100 --run-id state_transitions_steady_test &>> ../logs/state_transitions_steady.log
```

# Head to the UI and look at the load generated
localhost:8080

# Increase the activity generator
```bash
go run ./cmd run-scenario --scenario state_transitions_steady --duration 2m --option state-transitions-per-second=500 --run-id state_transitions_steady_test &>> ../logs/state_transitions_steady.log
```

# Head to the UI
- Look at how a backlog is being created slowly 
- The worker is strained and can't work through the backlog quick enough, we can fix this by horizontal scaling

# Next start a worker
```bash
go run ./cmd run-worker --scenario state_transitions_steady --run-id state_transitions_steady_test --language go
```

# Head to the UI
- Give the worker a minute to catch up then look at the backlog again, the number will be falling
