# Developer's Guide


## Repository content and structure

This repository contains all charts published by Kamu. In general
they could be classified into two categories:

* **Product charts** manage different components of Kamu platform. They
  can be installed independently and should be considered production ready.
* **Service charts** are used to either perform different service operations,
  running tests or to manage dependencies of Kamu in local or demo environments.
  These charts are opinionated and shall not be used in production.

Each chart is stored in its corresponding directory in `charts`. The repository
contains only the sources of the charts. Packages are built and published
automatically within the CI/CD pipeline.


## Introducing changes to charts.

The `master` branch is the source of truth for all released versions of each chart.
For that reason contributors must stick to the following rules:

* Every change requires an approved pull request before being merged.
* Changes to charts should be done along with the version bump.
* **TODO**: Linting tests must pass before a change can be merged.


## Versioning charts

`Chart.yaml` files contain two versions:
- `version` - version of the chart itself
- `appVersion` - version of the application being deployed (an image tag)

When making updates we try to keep chart `version` in sync with `appVersion`. This
what MAJOR and MINOR application update will result in MAJOR and MINOR updates of
the chart.

In situations where we need to release an updated chart without updating the
application's `appVersion` - it's OK to increment the PATCH part of the chart's
`version` separately.


## Releasing charts

Charts are released automatically after every merge to master by a
[GitHub workflow][1]. The workflow uses [Chart Releaser action][2] to manage
the GitHub Pages and to create GitHub releases in the repository. It
automatically updates the `index.yaml` file, creates tags, builds charts
and uploads binaries together with the changelog.


## Publishing charts and making the repository available

The repository index is published along with the landing page as a GitHub
Pages website. GitHub's embedded workflow automatically generates the website
every time the release workflow pushes new changes to the `gh-pages` branch.
The `README.md` file is the source for the landing page.

The [index file][4] references chart packages that are published as GitHub releases.
[ArtifactHub][3] scans the index file periodically to publish all charts'
metadata and living documentation to users.

The `gh-pages` branch also contains a special `artifacthub-repo.yml` file that
instructs ArtifactHub to ignore some non-production charts such as `minio-devel`.


[1]: https://github.com/kamu-data/helm-charts/blob/master/.github/workflows/release.yml
[2]: https://helm.sh/docs/howto/chart_releaser_action/
[3]: https://artifacthub.io/packages/search?repo=kamu&sort=relevance&page=1
[4]: https://kamu-data.github.io/helm-charts/index.yaml