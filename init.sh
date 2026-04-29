#!/bin/bash

# --- Function for error handling ---
handle_error() {
  echo "Error: $1"
  exit 1
}

# --- Part 1: Set Google Cloud Project ID ---



PROJECT_FILE="$HOME/project_id.txt"
LOOKER_URL_FILE="$HOME/looker_url.txt"
LOOKER_ID_FILE="$HOME/looker_id.txt"
LOOKER_SECRET_FILE="$HOME/looker_secret.txt"

echo "--- Setting Google Cloud Project ID File ---"

if [[ -f "$PROJECT_FILE" ]]; then
  user_project_id=$(cat "$PROJECT_FILE")
  echo "Using existing project ID from $PROJECT_FILE: $user_project_id"
else
  read -p "Please enter your Google Cloud project ID: " user_project_id

  if [[ -z "$user_project_id" ]]; then
    handle_error "No project ID was entered."
  fi

  echo "You entered: $user_project_id"
  echo "$user_project_id" > "$PROJECT_FILE"

  if [[ $? -ne 0 ]]; then
    handle_error "Failed saving your project ID: $user_project_id."
  fi
fi

echo "--- Setting Looker Credentials ---"

if [[ -f "$LOOKER_URL_FILE" ]]; then
  user_looker_url=$(cat "$LOOKER_URL_FILE")
  echo "Using existing Looker URL from $LOOKER_URL_FILE: $user_looker_url"
else
  read -p "Please enter your Looker URL: " user_looker_url
  if [[ -z "$user_looker_url" ]]; then
    handle_error "No Looker URL was entered."
  fi
  echo "You entered: $user_looker_url"
  echo "$user_looker_url" > "$LOOKER_URL_FILE"
  if [[ $? -ne 0 ]]; then
    handle_error "Failed saving your Looker URL."
  fi
fi

if [[ -f "$LOOKER_ID_FILE" ]]; then
  user_looker_id=$(cat "$LOOKER_ID_FILE")
  echo "Using existing Looker Client ID from $LOOKER_ID_FILE: $user_looker_id"
else
  read -p "Please enter your Looker Client ID: " user_looker_id
  if [[ -z "$user_looker_id" ]]; then
    handle_error "No Looker Client ID was entered."
  fi
  echo "You entered: $user_looker_id"
  echo "$user_looker_id" > "$LOOKER_ID_FILE"
  if [[ $? -ne 0 ]]; then
    handle_error "Failed saving your Looker Client ID."
  fi
fi

if [[ -f "$LOOKER_SECRET_FILE" ]]; then
  echo "Using existing Looker Client Secret from $LOOKER_SECRET_FILE"
else
  read -sp "Please enter your Looker Client Secret: " user_looker_secret
  echo
  if [[ -z "$user_looker_secret" ]]; then
    handle_error "No Looker Client Secret was entered."
  fi
  echo "$user_looker_secret" > "$LOOKER_SECRET_FILE"
  if [[ $? -ne 0 ]]; then
    handle_error "Failed saving your Looker Client Secret."
  fi
fi




#echo "Enabling Services"
#gcloud services enable \
#    run.googleapis.com \
#    artifactregistry.googleapis.com \
#    cloudbuild.googleapis.com \
#    aiplatform.googleapis.com \
#    compute.googleapis.com 


#echo "Adding IAM Roles"
#gcloud projects add-iam-policy-binding $PROJECT_ID \
#  --member="serviceAccount:$SERVICE_ACCOUNT" \
#  --role="roles/run.invoker" \
#    --quiet \
#    --condition=None
    
echo "Installing MCP Toolbox"
if [ ! -f "./toolbox" ]; then
  export VERSION=1.1.0
  curl -L -o toolbox https://storage.googleapis.com/mcp-toolbox-for-databases/v$VERSION/linux/amd64/toolbox
  chmod +x toolbox
else
  echo "MCP Toolbox already exists. Skipping download."
fi

#echo "Creating Firestore DB"
#gcloud firestore databases create     --database="(default)"  --location=us-central1 --type=firestore-native


  if  [[ -z "$CLOUD_SHELL" ]] && curl -s -i metadata.google.internal | grep -q "Metadata-Flavor: Google"; then
     echo "This VM is running on GCP Defaults to Service Account."
  fi 

if [ "$CLOUD_SHELL" = "true" ]; then
  echo "Running in Google Cloud Shell."
else
  if curl -s -i metadata.google.internal | grep -q "Metadata-Flavor: Google"; then
     echo "This VM is running on Google Cloud."
  else
    echo "Not running in Google Cloud VM or Shell."
    # Check if application_default_credentials.json exists
    if [ -f "$HOME/.config/gcloud/application_default_credentials.json" ]; then
      echo "ADC Credentials already set up. Skipping login."
    else
      echo "Setting ADC Credentials"
      gcloud auth application-default login
    fi
  fi
fi

if [ -n "$FIREBASE_DEPLOY_AGENT" ]; then
echo "Running in Firebase Studio terminal"
else
echo "Not running in Firebase Studio terminal"
fi

if [ -d "/mnt/chromeos" ] ; then
     echo "Running on ChromeOS"
else
      echo "Not running on ChromeOS"
fi

export ID_TOKEN=$(gcloud auth print-identity-token)

echo "--- Initial Setup complete ---"

