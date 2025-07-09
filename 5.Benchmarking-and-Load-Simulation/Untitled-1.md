
```
sum by(taskqueue) (
  rate(workflow_success{taskqueue=~"state_transitions_steady_.*"}[5m])
)
```




