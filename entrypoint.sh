#!/bin/bash
set -e

export AWS_S3_ACCESS_KEY_ID="${S3_ACCESS_KEY_ID:-${AWS_S3_ACCESS_KEY_ID}}"
export AWS_S3_SECRET_ACCESS_KEY="${S3_SECRET_ACCESS_KEY:-${AWS_S3_SECRET_ACCESS_KEY}}"
export AWS_S3_BUCKET="${S3_BUCKET:-${AWS_S3_BUCKET}}"
export AWS_S3_URL="${S3_URL:-${AWS_S3_URL}}"

echo "[entrypoint] Environment variables:"
echo "  AWS_S3_ACCESS_KEY_ID=${AWS_S3_ACCESS_KEY_ID}"
echo "  AWS_S3_SECRET_ACCESS_KEY=${AWS_S3_SECRET_ACCESS_KEY}"
echo "  AWS_S3_BUCKET=${AWS_S3_BUCKET}"
echo "  AWS_S3_URL=${AWS_S3_URL}"
echo "  AWS_S3_MOUNT=${AWS_S3_MOUNT}"

/usr/local/bin/docker-entrypoint.sh "$@"

/usr/bin/nfsd.sh