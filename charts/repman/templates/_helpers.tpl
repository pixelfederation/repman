{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "ingressname" -}}
{{- if .Values.ingress.enabled -}}
{{- include "fullname" . }}
{{- else -}}
{{- include "fullname" . }}-{{ .type }}
{{- end -}}
{{- end -}}

{{/*
*/}}
{{- define "chart" -}}
{{- $version := .Chart.Version | replace "+" "_" -}}
{{- printf "%s-%s" .Chart.Name $version -}}
{{- end -}}

/* {{/*
Create the name of the service account to use
*/}}
{{- define "serviceAccountName" -}}
{{- if .Values.rbac.serviceAccountName -}}
    {{ default (include "fullname" .) .Values.rbac.serviceAccountName }}
{{- else -}}
    {{ default "default" .Values.rbac.serviceAccountName }}
{{- end -}}
{{- end -}} */

{{/*
   * XXX: Because go template variables are defined only inside scope (until next {{ end }}) we have to print variable
   *      on multiple places.
   */}}
{{- define "hostname" -}}
  {{- if index .Values.ingress.external.annotations "external-dns.alpha.kubernetes.io/hostname" }}
    {{- $hostname := index .Values.ingress.external.annotations "external-dns.alpha.kubernetes.io/hostname" | trimSuffix "."}}
    {{- printf "%s" $hostname -}}
  {{- else if index .Values.ingress.internal.annotations "external-dns.alpha.kubernetes.io/hostname" }}
    {{- $hostname := index .Values.ingress.internal.annotations "external-dns.alpha.kubernetes.io/hostname" | trimSuffix "."}}
    {{- printf "%s" $hostname -}}
  {{- else if index .Values.service.annotations "external-dns.alpha.kubernetes.io/hostname" }}
    {{- $hostname := index .Values.service.annotations "external-dns.alpha.kubernetes.io/hostname" | trimSuffix "."}}
    {{- printf "%s" $hostname -}}
  {{- else }}
    {{- printf "" -}}
  {{- end }}
{{- end -}}

{{/*
   * XXX: This is alternative to toYaml template wchich currently removes quotes around any values
   *      https://github.com/helm/helm/issues/4262
   */}}
{{- define "toYamlQuote" -}}
  {{- range $key, $value := . -}}
    {{- $map := kindIs "map" $value -}}
    {{- if $map }}
{{ $key }}:
  {{- include "toYamlQuote" $value | indent 2 }}
    {{- else }}
{{ $key }}: {{ $value | quote}}
    {{- end }}
  {{- end -}}
{{- end -}}

{{/*
   * toYaml without extra space
   */}}
{{- define "toYaml" -}}
  {{- range $key, $value := . -}}
    {{- $map := kindIs "map" $value -}}
    {{- if $map }}
{{ $key }}:
  {{- include "toYaml" $value | indent 2 }}
    {{- else }}
{{ $key }}: {{ $value }}
    {{- end }}
  {{- end -}}
{{- end -}}

{{/*
   * convert map of env entries to list
   */}}
{{- define "envToList" -}}
  {{- range $key, $val := . }}
- name: {{ $key }}
  value: {{ $val | quote }}
  {{- end}}
{{- end -}}
