{{- define "ingress_template" -}}
{{- $appVersion := .Values.appVersion }}
{{- $appVersionUrl := .ingress.appVersionUrl}}

{{- $serviceName := include "fullname" . }}
{{- $servicePort := .Values.service.port }}
{{- if .ingress.enabled -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ template "ingressname" . }}
  labels:
    app: {{ template "name" . }}
    appVersion: "{{ .Values.appVersion }}"
    chart: {{ template "chart" .  }}
    heritage: "{{ .Release.Service }}"
    release: "{{ .Release.Name }}"
    {{- include "toYamlQuote" .Values.labels | indent 4 }}
    {{- include "toYamlQuote" .Values.orgLabels | indent 4 }}
    {{- include "toYamlQuote" .Values.buildLabels | indent 4 }}
    {{- include "toYamlQuote" .ingress.labels | indent 4 }}
  {{- if .ingress.annotations }}
  annotations:
    {{- toYaml .ingress.annotations | nindent 4 }}
  {{- end }}
spec:
  rules:
    {{- range $host := .ingress.hosts }}
    - host: {{ $host.host }}
      http:
        paths:
        {{- if $host.paths }}
          {{- range $path := $host.paths }}
          - backend:
              service:
                name: {{ $path.serviceName | default $serviceName }}
                port:
                  number: {{ $path.servicePort | default $servicePort }}
            path: {{ $path.path | default "/" }}
            pathType: {{ $path.pathType | default "ImplementationSpecific" }}
          {{- end }}
        {{- else }}
          - backend:
              service:
                name: {{ $serviceName }}
                port:
                  number: {{ $servicePort }}
            path: /
            pathType: ImplementationSpecific
      {{- end }}
  {{- end }}
  {{- if .ingress.tls }}
  tls:
    {{- toYaml .ingress.tls | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}
