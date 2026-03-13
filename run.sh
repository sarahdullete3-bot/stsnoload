cat << 'EOF' > run.sh
#!/bin/bash

# 1. Set the Project ID
PROJECT_ID=$(gcloud config get-value project)
SERVICE_NAME="stsnoload"
REGION="us-central1"

echo "🔨 Building and Deploying $SERVICE_NAME..."

# 2. Build and Push 
gcloud builds submit --tag gcr.io/$PROJECT_ID/$SERVICE_NAME .

# 3. Deploy to Cloud Run
gcloud run deploy $SERVICE_NAME \
  --image gcr.io/$PROJECT_ID/$SERVICE_NAME \
  --region $REGION \
  --platform managed \
  --allow-unauthenticated \
  --use-http2

echo "✅ Success! Your URL is below:"
gcloud run services describe $SERVICE_NAME --region $REGION --format 'value(status.url)'
EOF
