{{/*
Expand the name of the chart.
*/}}
{{- define "kamu-api-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kamu-api-server.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kamu-api-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kamu-api-server.labels" -}}
helm.sh/chart: {{ include "kamu-api-server.chart" . }}
{{ include "kamu-api-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kamu-api-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kamu-api-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kamu-api-server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kamu-api-server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Renders the content of the configmap
*/}}
{{- define "kamu-api-server.config.yaml" -}}
{{- $root := . -}}
config.yaml: | {{ .Values.app.config | toYaml | nindent 2 }}
{{- end -}}

{{/*
Computes a short hash of the configmap content to re-create it and trigger the re-deploy upon any change
*/}}
{{- define "kamu-api-server.config.sha" -}}
{{ include "kamu-api-server.config.yaml" . | toJson | sha256sum | trunc 10 }}
{{- end -}}

{{- define "kamu-api-server.awsCredentialsSecretName" -}}
{{- if .Values.app.awsCredentials.existingSecret }}
{{- .Values.app.awsCredentials.existingSecret }}
{{- else }}
{{- printf "%s-aws-credentials" (include "kamu-api-server.fullname" .) }}
{{- end }}
{{- end }}
