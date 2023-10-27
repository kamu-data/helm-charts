# Kamu Kubernetes Helm Charts
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/kamu)](https://artifacthub.io/packages/search?repo=kamu)
[![Release charts](https://github.com/kamu-data/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/kamu-data/helm-charts/actions/workflows/release.yml)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Official [Helm](https://helm.sh) charts for deploying [Kamu](https://kamu.dev) components in [Kubernetes](https://kubernetes.io).


## Usage
[Helm](https://helm.sh) must be installed to use the charts. Please refer to Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  helm repo add kamu https://kamu-data.github.io/helm-charts

If you had already added this repo earlier, run `helm repo update` to retrieve the latest versions of the packages. You can then run `helm search repo
kamu` to see the charts.

To install, for example, the `kamu-api-server` chart:

    helm install my-kamu-api-server kamu/kamu-api-server

To uninstall the chart:

    helm delete my-kamu-api-server


## Contributing
The source code of all Kamu Helm charts can be found on Github: [https://github.com/kamu-data/helm-charts/](https://github.com/kamu-data/helm-charts/)

We'd love to have you contribute! Please refer to our [developer documentation](https://github.com/kamu-data/helm-charts/blob/master/DEVELOPERS.md) for details.


## License
Apache 2.0 License.
