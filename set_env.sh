#!/bin/bash

# Check if gcloud is authenticated
if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q "@"; then
    echo "Error: No active gcloud account found."
    echo "Please run 'gcloud auth login' and try again."
fi

# Get current project


# Looker Config
LOOKER_BASE_URL=$(cat "$HOME/looker_url.txt" 2>/dev/null)
LOOKER_CLIENT_ID=$(cat "$HOME/looker_id.txt" 2>/dev/null)
LOOKER_CLIENT_SECRET=$(cat "$HOME/looker_secret.txt" 2>/dev/null)

cat <<EOF > .env
GOOGLE_GENAI_USE_VERTEXAI=True
GOOGLE_CLOUD_PROJECT=$PROJECT_ID
GOOGLE_CLOUD_LOCATION=us-central1
GENAI_MODEL="gemini-2.5-flash"
LOOKER_BASE_URL=$LOOKER_BASE_URL
LOOKER_CLIENT_ID=$LOOKER_CLIENT_ID
LOOKER_CLIENT_SECRET=$LOOKER_CLIENT_SECRET
EOF

source .env

echo "Current Environment"
cat .env

echo "Cloud Login"
gcloud auth list

CATION=us-central1
GENAI_MODEL="gemini-2.5-flash"
LOOKER_BASE_URL=$LOOKER_BASE_URL
LOOKER_CLIENT_ID=$LOOKER_CLIENT_ID
LOOKER_CLIENT_SECRET=$LOOKER_CLIENT_SECRET
EOF

export PROJECT_ID
export PROJECT_NUMBER
export GOOGLE_CLOUD_PROJECT=$PROJECT_ID
export SERVICE_ACCOUNT

echo "Current Environment"
cat .env

echo "Cloud Login"
gcloud auth list

D=$LOOKER_CLIENT_ID
LOOKER_CLIENT_SECRET=$LOOKER_CLIENT_SECRET
EOF

source .env

echo "Current Environment"
cat .env

echo "Cloud Login"
gcloud auth list

