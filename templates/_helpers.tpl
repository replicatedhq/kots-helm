{{/*
Expand the name of the chart.
*/}}
{{- define "admin-console.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "admin-console.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "admin-console.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "admin-console.labels" -}}
helm.sh/chart: {{ include "admin-console.chart" . }}
{{ include "admin-console.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
kots.io/backup: velero
kots.io/kotsadm: "true"
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Labels for immutable resources
*/}}
{{- define "admin-console.immutableLabels" -}}
kots.io/backup: velero
kots.io/kotsadm: "true"
{{- end }}

{{/*
Selector labels
*/}}
{{- define "admin-console.selectorLabels" -}}
app.kubernetes.io/name: {{ include "admin-console.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "admin-console.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "admin-console.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
