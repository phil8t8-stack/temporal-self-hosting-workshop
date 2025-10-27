# Start some load then fail the history service

## Next start a worker
```bash
go run ./cmd run-worker --scenario state_transitions_steady --run-id state_transitions_steady_test --language go
```

## Start the activity generator
```bash
go run ./cmd run-scenario --scenario state_transitions_steady --duration 10m --option state-transitions-per-second=10 --run-id state_transitions_steady_test &>> ../logs/state_transitions_steady.log
```

## Stop the history service

```bash
kubectl scale deployment my-temporal-history --replicas=0
```

## Look at some of the errors produced in Grafana and the UI

## This will cause the test after 1m to stop so restart it
```bash
go run ./cmd run-scenario --scenario state_transitions_steady --duration 10m --option state-transitions-per-second=10 --run-id state_transitions_steady_test &>> ../logs/state_transitions_steady.log
```

## Restart the history service
```bash
kubectl scale deployment my-temporal-history --replicas=1
```

## UI
Head to the UI and verify that new workflows are being created as expected

## DONE

# Start some load than fail the persistence database


## Start the activity generator
```bash
go run ./cmd run-scenario --scenario state_transitions_steady --duration 10m --option state-transitions-per-second=10 --run-id state_transitions_steady_test &>> ../logs/state_transitions_steady.log
```

```bash
kubectl scale statefulset my-temporal-cassandra --replicas=0
```

## Look at some of the errors produced in Grafana and the UI

1. Persistence errors are seen
    - Bitovi Dashboard, Persistence Requests
    - Temporal Service dashboard
        - Persistence errors
        - Service errors
2. Reload the UI
    - 500


## DONE
This cannot be fixed quickly, so just delete the Temporal deployment and prepare for the next one

```bash
helm uninstall my-temporal;
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
