
- Prereqs
    - Github account
    - [Temporal CLI](https://docs.temporal.io/cli)
    - [gh cli](https://github.com/cli/cli)


1. Create the Github Codespace
2. (Once complete) Run `./.devcontainer/start-ports.sh`
3. Open the WebUI via the ports tab
4. Start the port forwarding on your local machine;
```bash
gh codespace list
gh codespace ports forward 7233:7233
```
5. On the local machine run: `temporal operator namespace list`
```bash
temporal operator namespace list
  NamespaceInfo.Name                    temporal-system
  NamespaceInfo.Id                      32049b68-7872-4094-8e63-d0dd59896a83
  NamespaceInfo.Description             Temporal internal system namespace
  NamespaceInfo.OwnerEmail              temporal-core@temporal.io
  NamespaceInfo.State                   Registered
  NamespaceInfo.Data                    map[]
  Config.WorkflowExecutionRetentionTtl  168h0m0s
  ReplicationConfig.ActiveClusterName   active
  ReplicationConfig.Clusters            [{"clusterName":"active"}]
  Config.HistoryArchivalState           Disabled
  Config.VisibilityArchivalState        Disabled
  IsGlobalNamespace                     false
  FailoverVersion                       0
  FailoverHistory                       []
  Config.HistoryArchivalUri
  Config.VisibilityArchivalUri
  Config.CustomSearchAttributeAliases   map[]
```
