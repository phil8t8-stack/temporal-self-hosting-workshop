
```bash
helm uninstall kube-state-metrics;
kubectl delete deployment/benchmark-workers;
kubectl delete deployment/benchmark-soak-test;
helm uninstall my-temporal;
helm uninstall active-temporal --namespace=active;
helm uninstall passive-temporal --namespace=passive;
```