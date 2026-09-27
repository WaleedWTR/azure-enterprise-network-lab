#!/usr/bin/env bash
set -euo pipefail

# Example wrapper around Azure Network Watcher connection troubleshoot.
# Usage:
# ./scripts/test-connectivity.sh <source-resource-id> <destination-ip> <destination-port>

SOURCE_ID="${1:?source resource ID required}"
DESTINATION="${2:?destination IP required}"
PORT="${3:?destination port required}"

az network watcher test-connectivity   --source-resource "$SOURCE_ID"   --dest-address "$DESTINATION"   --dest-port "$PORT"   --protocol TCP   --output table
