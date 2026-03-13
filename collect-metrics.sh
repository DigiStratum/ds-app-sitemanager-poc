#!/bin/bash

# POC Metrics Collection Script for Self-hosted Runner
# Issue #1345 - Collect performance metrics for 1 week comparison

REPO="DigiStratum/ds-app-sitemanager-poc"
METRICS_FILE="~/.openclaw/workspace/ds-app-sitemanager-poc/metrics.json"
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Ensure GitHub credentials are available
source ~/.openclaw/workspace/github-credentials.env

echo "Collecting metrics at $DATE..."

# Get recent workflow runs
RECENT_RUNS=$(gh run list -R "$REPO" --limit 10 --json status,conclusion,startedAt,updatedAt,url,workflowName,number)

# Get runner status if available (requires admin permissions)
RUNNERS=$(gh api repos/"$REPO"/actions/runners 2>/dev/null || echo '{"runners":[]}')

# Create metrics entry
METRICS_ENTRY=$(cat <<EOF
{
  "timestamp": "$DATE",
  "workflow_runs": $RECENT_RUNS,
  "runners": $RUNNERS,
  "system_info": {
    "hostname": "$(hostname)",
    "platform": "$(uname -a)",
    "uptime": "$(uptime)"
  }
}
EOF
)

# Append to metrics file
echo "$METRICS_ENTRY" >> "$METRICS_FILE"

echo "Metrics collected and saved to $METRICS_FILE"

# Display summary
echo ""
echo "=== RECENT RUNS SUMMARY ==="
gh run list -R "$REPO" --limit 5

echo ""
echo "=== RUNNER STATUS ==="
if [[ $(echo "$RUNNERS" | jq '.runners | length') -gt 0 ]]; then
    echo "$RUNNERS" | jq '.runners[] | {name: .name, status: .status, labels: .labels}'
else
    echo "Runner status not available (requires admin permissions)"
fi