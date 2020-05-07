{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
This support both templating and submodule
*/}}
{{- define "..name" -}}
{{/* This probably is a submodule, so use release or nameOverride */}}
{{- if eq "chart" .Chart.Name }}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{/* Use name declared in Chart or nameOverride from values */}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Expand version of the application.
This support both templating and submodule
*/}}
{{- define "..version" -}}
{{- default .Values.image.tag .Chart.AppVersion }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "..fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := include "..name" . }}
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
{{- define "..chart" -}}
{{- .Release.Version -}}
{{- $name := include "..name" . -}}
{{- $version := include "..version" . -}}
{{- printf "%s-%s" (include "..name" .) .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "..labels" -}}
helm.sh/chart: {{ include "..chart" . }}
{{ include "..selectorLabels" . }}
app.kubernetes.io/component: {{ include "..name" . }}
app.kubernetes.io/version: {{ include "..version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "..selectorLabels" -}}
app: {{ include "..name" . }}
app.kubernetes.io/name: {{ include "..name" . }}
app.kubernetes.io/instance: {{ include "..name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "..serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "..fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the cluster role to use
*/}}
{{- define "..clusterRoleName" -}}
{{- if .Values.clusterRole.create }}
{{- default (include "..fullname" .) .Values.clusterRole.name }}
{{- else }}
{{- default "default" .Values.clusterRole.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the role to use
*/}}
{{- define "..roleName" -}}
{{- if .Values.role.create }}
{{- default (include "..fullname" .) .Values.role.name }}
{{- else }}
{{- default "default" .Values.role.name }}
{{- end }}
{{- end }}

{{/*
Expand annotations to support timestamp
*/}}
{{- define "..annotations" -}}
timestamp: {{ now }}
{{ toYaml .Values.podAnnotations }}
{{- end }}


