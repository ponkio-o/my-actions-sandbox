#!/bin/bash

if git ls-remote --exit-code --heads origin "$GITHUB_REF_NAME"; then
  DEFAULT_BRANCH_LATEST_SHA1=$(git rev-parse "origin/$GITHUB_REF_NAME")
  FEATURE_BRANCH_LATEST_SHA1=$(git rev-parse "origin/$FEATURE_BRANCH_NAME")
  echo "DEFAULT_BRANCH_LATEST_SHA1: ${DEFAULT_BRANCH_LATEST_SHA1}"
  echo "FEATURE_BRANCH_LATEST_SHA1: ${FEATURE_BRANCH_LATEST_SHA1}"
  echo "GITHUB_REF_NAME           : ${GITHUB_REF_NAME}"
  if [[ "${DEFAULT_BRANCH_LATEST_SHA1}" == "${FEATURE_BRANCH_LATEST_SHA1}" ]]; then
    echo "Found current branch $GITHUB_REF_NAME is update to date, ready to run terraform."
  else
    echo "Skip to run terraform on old commit ${COMMIT_HASH} in current branch $GITHUB_REF_NAME."
    exit 1
  fi
else
  echo "Remote branch $GITHUB_REF_NAME is not existed, skip to run terraform."
  exit 1
fi
