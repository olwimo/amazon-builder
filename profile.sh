
export SDKMAN_DIR=/usr/local/sdkman

[ -f $SDKMAN_DIR/bin/sdkman-init.sh ] && . $SDKMAN_DIR/bin/sdkman-init.sh

# export GRAALVM_HOME=/usr/local/sdkman/candidates/java/17.0.7-graal

# export PATH=${GRAALVM_HOME}/bin:$PATH

[ -f "${DB_PASSWORD_FILE}" ] && export DB_PASSWORD="$(cat ${DB_PASSWORD_FILE})"

[ -f "${CLT_SECRET_FILE}" ] && export CLT_SECRET="$(cat ${CLT_SECRET_FILE})"

export NVM_DIR=/usr/local/share/nvm

[ -f $NVM_DIR/nvm.sh ] && umask 0002 && . $NVM_DIR/nvm.sh
