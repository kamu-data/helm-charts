{{/*
Expand the name of the chart.
*/}}
{{- define "minio-devel.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "minio-devel.fullname" -}}
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
Selector labels
*/}}
{{- define "minio-devel.selectorLabels" -}}
app.kubernetes.io/name: {{ include "minio-devel.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "minio-devel.secretName" -}}
{{- if .Values.auth.existingSecret }}
  {{- .Values.auth.existingSecret }}
{{- else }}
  {{- printf "%s-creds" (include "minio-devel.fullname" .) }}
{{- end }}
{{- end }}

{{- define "minio-devel.generateRootPassword" -}}
{{- if .Values.auth.rootPassword }}
  {{- .Values.auth.rootPassword }}
{{- else }}
  {{- $secret := (lookup "v1" "Secret" .Release.Namespace (include "minio-devel.secretName" .)).data }}
  {{- if $secret }}
    {{- get $secret "root_password" | b64dec }}
  {{- else }}
    {{- randAlphaNum 16 }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "minio-devel.image" -}}
{{- $sep := ":" -}}
{{- $tag :=  default .Values.image.tag .Chart.AppVersion -}}
{{- if .Values.image.digest -}}
  {{- $sep = "@" -}}
  {{- $tag = .Values.image.digest -}}
{{- end -}}
{{- printf "%s%s%s" .Values.image.repository $sep $tag -}}
{{- end -}}
