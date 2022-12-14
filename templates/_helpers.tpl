{{- define "eth-node.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "eth-node.fullname" -}}
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

{{- define "eth-node.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "eth-node.labels" -}}
helm.sh/chart: {{ include "eth-node.chart" . }}
{{ include "eth-node.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "eth-node.selectorLabels" -}}
app.kubernetes.io/name: {{ include "eth-node.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "eth-node.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "eth-node.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
    Returns given number of random Hex characters.

    In practice, it generates up to 100 randAlphaNum strings
    that are filtered from non-hex characters and augmented
    to the resulting string that is finally trimmed down.
*/}}
{{- define "eth-node.randHex" -}}
    {{- $result := "" }}
    {{- range $i := until 100 }}
        {{- if lt (len $result) . }}
            {{- $rand_list := randAlphaNum . | splitList "" -}}
            {{- $reduced_list := without $rand_list "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" }}
            {{- $rand_string := join "" $reduced_list }}
            {{- $result = print $result $rand_string -}}
        {{- end }}
    {{- end }}
    {{- $result | trunc . }}
{{- end }}
