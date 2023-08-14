#!/usr/bin/env bash
set -e

# export SDKMAN_DIR=/usr/local/sdkman

# . /usr/local/sdkman/bin/sdkman-init.sh

# # export GRAALVM_HOME=/usr/local/sdkman/candidates/java/17.0.7-graal

# # export PATH=${GRAALVM_HOME}/bin:$PATH

# export DB_PASSWORD="$(cat ${DB_PASSWORD_FILE})"

# export CLT_SECRET="$(cat ${CLT_SECRET_FILE})"

set +e
exec "$@"
