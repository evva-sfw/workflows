# audit.sh

This script would normally run on ubuntu CI

```bash
#/!bin/bash
set -e

TRIVY_VERSION=0.61.0

npm i

if ! [ -x "$(command -v trivy)" ]; then
  echo 'Installing trivy...'
  wget -q "https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.deb"
  apt install ./*.deb
fi

mkdir -p test-reports
trivy fs . --config .trivy/trivy.yaml --license-full

trivy fs ./package-lock.json --config .trivy/trivy.yaml --format template --template "@.trivy/html.tpl" -o security-report.html --license-full

echo y | npx auditjs ossi --whitelist  .trivy/whitelist-auditjs.json -xml > test-reports/auditjs.xml || true
```

The outputs are junit xmls inside the test-reports folder. Those can be use on most CI pipelines.

HTML output is for easier view for humans: `security-report.html`