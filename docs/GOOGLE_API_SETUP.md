# Google API Integration Guide

## Step 1: Create Google Cloud Project
1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Click "New Project" in the top-right dropdown
3. Name it "security-testing-lab"
4. Click "Create"

## Step 2: Enable Required APIs
1. Go to "APIs & Services" > "Library"
2. Search for and enable these APIs:
   - Security Command Center API
   - Cloud Asset API
   - Cloud Resource Manager API

## Step 3: Create Service Account
1. Go to "IAM & Admin" > "Service Accounts"
2. Click "Create Service Account"
3. Name: "security-scanner"
4. Click "Create"
5. Add these roles:
   - Security Center Admin Viewer
   - Security Center Findings Viewer
6. Click "Done"

## Step 4: Get Credentials
1. Click on your new service account
2. Go to "Keys" tab
3. Click "Add Key" > "Create New Key"
4. Choose JSON format
5. Download the key file

## Step 5: Add to Lab Environment
1. Save the JSON file as `google-credentials.json` in the `config` folder
2. Add to docker-compose:
   ```bash
   export GOOGLE_CREDENTIALS_FILE=/path/to/google-credentials.json
   ```

## Step 6: Test Integration
1. Go to n8n (http://localhost:5678)
2. Create new workflow
3. Add "Google Cloud" node
4. Use credentials from file
5. Test connection

## Common Issues
1. "API not enabled" - Go back to Step 2
2. "Permission denied" - Check roles in Step 3
3. "Invalid credentials" - Verify file path in Step 5
