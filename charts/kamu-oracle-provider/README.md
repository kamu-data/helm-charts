# kamu-oracle-provider Helm Chart
Installs the [kamu-oracle-provider](https://github.com/kamu-data/kamu-node) component of the [Kamu Node](https://docs.kamu.dev/node/).

## Getting Started
For most up-to-date deployment instructions please refer to  [Kamu Node documentation](https://docs.kamu.dev/node/).

## Common Helm Commands
### Get Repository Info
<!-- textlint-disable -->
```console
helm repo add kamu https://kamu-data.github.io/helm-charts
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._
<!-- textlint-enable -->

### Install Chart
```console
helm install [RELEASE_NAME] kamu/kamu-oracle-provider [flags]
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

### Uninstall Chart
```console
helm uninstall [RELEASE_NAME]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

### Upgrade Chart
```console
helm upgrade [RELEASE_NAME] kamu/kamu-oracle-provider [flags]
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

### Configuration
See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments:

```console
helm show values kamu/kamu-oracle-provider
```
