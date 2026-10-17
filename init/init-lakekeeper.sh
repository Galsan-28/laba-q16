#!/bin/sh
# Принимает Terms of Use и регистрирует 3 warehouse (по одному на слой медальона).
until curl -sf http://lakekeeper:8181/health >/dev/null; do echo "ждём lakekeeper..."; sleep 2; done

curl -s -o /dev/null -w "bootstrap: HTTP %{http_code} (204 = ок, 400/409 = уже сделан)\n" \
  -X POST http://lakekeeper:8181/management/v1/bootstrap \
  -H 'Content-Type: application/json' -d '{"accept-terms-of-use": true}'

for W in bronze silver gold; do
  curl -s -o /dev/null -w "warehouse $W: HTTP %{http_code} (201 = создан)\n" \
    -X POST http://lakekeeper:8181/management/v1/warehouse \
    -H 'Content-Type: application/json' -d "{
      \"warehouse-name\": \"$W\",
      \"project-id\": \"00000000-0000-0000-0000-000000000000\",
      \"storage-profile\": {
        \"type\": \"s3\", \"bucket\": \"$W\", \"key-prefix\": \"\",
        \"endpoint\": \"http://minio:9000\", \"region\": \"us-east-1\",
        \"path-style-access\": true, \"flavor\": \"s3-compat\", \"sts-enabled\": false },
      \"storage-credential\": {
        \"type\": \"s3\", \"credential-type\": \"access-key\",
        \"access-key-id\": \"minioadmin\", \"secret-access-key\": \"minioadmin\" }
    }"
done
