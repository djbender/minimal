#!/bin/bash
set -euo pipefail

echo "Testing Ruby version..."
docker run --rm "$IMAGE" -e "puts RUBY_VERSION"

echo "Testing TLS/SSL..."
docker run --rm "$IMAGE" -e "require 'openssl'; puts 'TLS OK: ' + OpenSSL::OPENSSL_VERSION"

echo "Testing stdlib modules..."
docker run --rm "$IMAGE" -e "require 'json'; puts JSON.generate({ok: true})"

echo "Verifying no shell..."
docker run --rm --entrypoint /bin/sh "$IMAGE" -c "echo fail" 2>/dev/null \
  && echo "::error::Shell found in image!" && exit 1 \
  || echo "No shell confirmed"
