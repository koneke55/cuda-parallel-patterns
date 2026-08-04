#!/usr/bin/env bash
set -euo pipefail
# Automate 100 commits and pushes in this repository
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd -P)"
cd "$REPO_DIR"

for i in $(seq 1 100); do
  echo "Automated push $i on $(date -u)" >> pushes_log.txt
  git add pushes_log.txt
  git commit -m "Automated push $i/100"
  git push origin main
  sleep 0.1
done


echo "Completed 100 pushes"



