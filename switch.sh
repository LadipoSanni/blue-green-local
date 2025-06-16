#!/bin/bash
# Usage: ./switch.sh blue OR ./switch.sh green

TARGET=$1

if [[ "$TARGET" != "blue" && "$TARGET" != "green" ]]; then
  echo "❌ Invalid target. Use: ./switch.sh blue or ./switch.sh green"
  exit 1
fi

# Check if target container is running
if ! docker ps --format '{{.Names}}' | grep -q "^$TARGET$"; then
  echo "❌ $TARGET container is not running. Please deploy it first using ./deploy.sh $TARGET"
  exit 1
fi

echo "🔁 Switching traffic to $TARGET..."

# Generate updated nginx config
sed "s/proxy_pass http:\/\/.*:5000;/proxy_pass http:\/\/$TARGET:5000;/" nginx/default.conf.template > nginx/default.conf

# Restart nginx container
docker rm -f nginx &>/dev/null
docker run -d --name nginx \
  --network bluegreen
  -v $(pwd)/nginx/default.conf:/etc/nginx/conf.d/default.conf:ro \
  -v $(pwd)/nginx/.htpasswd:/etc/nginx/.htpasswd:ro \
  -p 80:80 nginx


echo "✅ Traffic successfully switched to $TARGET. Access via: http://localhost"

