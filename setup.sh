#!/bin/bash

# ============================================================
# S3 Sync Script — Multi-Directory, Throttled & Server-Friendly
# ============================================================

# --- CONFIG ---
BASE_DIR="/var/www/html"
S3_BUCKET="s3://icsportal-documents/backups"
LOG_FILE="/var/log/s3_sync.log"
LOCK_FILE="/tmp/s3_sync.lock"
AWS_PROFILE="default"

# --- DIRECTORIES TO SYNC ---
DIRS=(
    "$BASE_DIR/uploads"
    "$BASE_DIR/outsourcehr-admin/documents"
    "$BASE_DIR/outsourcehr-admin/upload"
    "$BASE_DIR/outsourcehr-admin/document"
    "$BASE_DIR/outsourcehr-admin/downloads"
    "$BASE_DIR/outsourcehr-admin/verified_document"
    "$BASE_DIR/onboarding/admin/pages/uploads_credentials"
)

# --- THROTTLE CONFIG ---
MAX_BANDWIDTH="2MB/s"        # Tune to ~50% of your upload speed
MAX_CONCURRENT="3"          # Keep low to avoid CPU/memory spikes
MULTIPART_THRESHOLD="64MB"
MULTIPART_CHUNKSIZE="16MB"
NICE_LEVEL=19               # Lowest CPU priority
IONICE_CLASS=3              # Idle I/O priority

# --- LOGGING ---
