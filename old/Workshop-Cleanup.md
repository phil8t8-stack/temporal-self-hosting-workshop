Thanks for partipating in the workshop!

Before you leave feel free to run the following to clean out the deployments that may be lingering:

```bash
helm uninstall kube-state-metrics;
kubectl delete deployment/benchmark-workers;
kubectl delete deployment/benchmark-soak-test;
helm uninstall my-temporal;
helm uninstall active-temporal --namespace=active;
helm uninstall passive-temporal --namespace=passive;
helm uninstall persistence-temporal --namespace=persistence;
```
