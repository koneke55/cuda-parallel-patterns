#!/usr/bin/env bash
set -euo pipefail
# Usage: ./create_remote_repo.sh --name NAME [--public|--private] [--gh-user USER]

NAME="cuda-parallel-patterns"
VISIBILITY="public"
while [[ $# -gt 0 ]]; do
  case $1 in
    --name) NAME="$2"; shift 2;;
    --public) VISIBILITY="public"; shift;;
    --private) VISIBILITY="private"; shift;;
    --gh-user) GH_USER="$2"; shift 2;;
    *) echo "Unknown arg $1"; exit 1;;
  esac
done

if command -v gh >/dev/null 2>&1; then
  echo "Using GitHub CLI to create repo $NAME ($VISIBILITY)"
  gh repo create "$NAME" --$VISIBILITY --source . --remote origin --push
  echo "Repo created and pushed via gh"
else
  echo "gh CLI not found. Initializing local git repo and showing commands to push."
  git init
  git add .
  git commit -m "Initial import: cuda-parallel-patterns"
  echo "Run the following to create a repo on GitHub and push:"
  echo "  gh repo create $NAME --$VISIBILITY --source . --remote origin --push"
  echo "Or create a repo on github.com and run:"
  echo "  git remote add origin git@github.com:<your-user>/$NAME.git"
  echo "  git branch -M main"
  echo "  git push -u origin main"
fi
