#!/bin/bash

# Put your Github key in the
# .github.key file
if [ -f .github-token ]; then
    export CODACY_PROJECT_TOKEN="$(cat .codacy-token)"
    export CODACY_RUN_LOCAL=true
fi
