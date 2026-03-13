cat << 'EOF' > run.sh
#!/bin/bash

PROJECT_ID=$(gcloud config get-value project)
SERVICE_NAME="stsnoload"
# 👇 CHANGE THE REGION ON THE NEXT LINE 👇
REGION="YOUR_LAB_REGION" 

echo "🔨 Deploying $SERVICE_NAME to $REGION..."

gcloud run deploy $SERVICE_NAME \
  --image gcr.io/$PROJECT_ID/$SERVICE_NAME \
  --region $REGION \
  --platform managed \
  --allow-unauthenticated \
  --use-http2

echo "✅ Success! Your URL is below:"
gcloud run services describe $SERVICE_NAME --region $REGION --format 'value(status.url)'
EOF

chmod +x run.sh
