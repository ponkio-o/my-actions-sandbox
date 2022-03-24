#!/bin/bash

if git ls-remote --exit-code --heads origin "$GITHUB_REF_NAME"; then
  LATEST_SHA1_IN_CURRENT_REMOTE_BRANCH=$(git rev-parse "origin/$GITHUB_REF_NAME")
  if [[ "${COMMIT_HASH}" == "${LATEST_SHA1_IN_CURRENT_REMOTE_BRANCH}" ]]; then
    echo "Found current branch $GITHUB_REF_NAME is update to date, ready to run terraform."
  else
    echo "Skip to run terraform on old commit ${COMMIT_HASH} in current branch $GITHUB_REF_NAME."
    exit 1
  fi
else
  echo "Remote branch $GITHUB_REF_NAME is not existed, skip to run terraform."
  exit 1
fi
