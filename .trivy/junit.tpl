<?xml version="1.0" encoding="utf-8"?>
<testsuites>
{{- range . -}}
  {{- $failures := len .Vulnerabilities }}
  {{- $tests := $failures }}
  {{- if eq $failures 0 }}
    {{ $tests = 1 }}
  {{- end -}}
  <testsuite package="Vulnerabilities" hostname="localhost" timestamp="{{ now | date "2006-01-02T15:04:05" }}" id="0" tests="{{- $tests -}}" failures="{{ $failures }}" name="{{ .Target }}" errors="0" skipped="0" time="0">
    {{- if not (eq .Type "") }}
    <properties>
      <property name="type" value="{{ .Type }}"></property>
    </properties>
    {{- end -}}
    {{- if .Vulnerabilities}}
      {{- range .Vulnerabilities }}
    <testcase classname="{{ .PkgName }}-{{ .InstalledVersion }}" name="[{{ .Vulnerability.Severity }}] {{ .VulnerabilityID }}" time="0">
      <failure message="{{ escapeXML .Title }}" type="description">{{ escapeXML .Description }}</failure>
    </testcase>
      {{- end }}
    {{- else }}
    <testcase classname="{{ .Target }}" name="{{ .Target }}" time="0"/>
    {{- end }}
    <system-out/>
    <system-err/>
  </testsuite>
{{- end }}
{{- range . -}}
  {{- $failures := len .Misconfigurations }}
  {{- $tests := $failures }}
  {{- if eq $failures 0 }}
    {{ $tests = 1 }}
  {{- end -}}
  <testsuite package="Misconfigurations" hostname="localhost" timestamp="{{ now | date "2006-01-02T15:04:05" }}" id="0" tests="{{- $tests -}}" failures="{{ $failures }}" name="{{  .Target }}" errors="0" skipped="0" time="0">
  {{- if not (eq .Type "") }}
    <properties>
      <property name="type" value="{{ .Type }}"></property>
    </properties>
  {{- end -}}
  {{- if .Misconfigurations}}
    {{ range .Misconfigurations }}
    <testcase classname="{{ .Type }}" name="[{{ .Severity }}] {{ .ID }}" time="0">
      <failure message="{{ escapeXML .Title }}" type="description">{{ escapeXML .Description }}</failure>
    </testcase>
    {{- end }}
  {{- else }}
  <testcase classname="{{ .Target }}" name="{{ .Target }}" time="0"/>
  {{- end }}
    <system-out/>
    <system-err/>
  </testsuite>
{{- end }}
{{- range . -}}
  {{- $failures := len .Licenses }}
  {{- $tests := $failures }}
  {{- if eq $failures 0 }}
    {{ $tests = 1 }}
  {{- end -}}
  <testsuite package="Licenses" hostname="localhost" timestamp="{{ now | date "2006-01-02T15:04:05" }}" id="0" tests="{{- $tests -}}" failures="{{ $failures }}" name="{{  .Target }}" errors="0" skipped="0" time="0">
  {{- if not (eq .Type "") }}
    <properties>
      <property name="type" value="{{ .Type }}"></property>
    </properties>
  {{- end -}}
  {{- if .Licenses}}
    {{ range .Licenses }}
    <testcase classname="{{ .PkgName }}" name="[{{ .Severity }}] {{ .Name }}" time="0">
      <failure message="{{ .Name }}" type="description">{{ .Name }} not allowed</failure>
    </testcase>
    {{- end }}
  {{- else }}
  <testcase classname="{{ .Target }}" name="{{ .Target }}" time="0"/>
  {{- end }}
    <system-out/>
    <system-err/>
  </testsuite>
{{- end }}
</testsuites>
