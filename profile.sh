
export SDKMAN_DIR=/usr/local/sdkman

[ -f /usr/local/sdkman/bin/sdkman-init.sh ] && . /usr/local/sdkman/bin/sdkman-init.sh

# export GRAALVM_HOME=/usr/local/sdkman/candidates/java/17.0.7-graal

# export PATH=${GRAALVM_HOME}/bin:$PATH

export NVM_DIR=/usr/local/share/nvm

[ -f $NVM_DIR/nvm.sh ] && umask 0002 && . $NVM_DIR/nvm.sh
