FROM amazonlinux:latest

ADD features /tmp/features
ADD my_init.sh /usr/local/share/my_init.sh
ADD profile.sh /etc/profile.d/profile.sh

EXPOSE 8888

VOLUME [ "/var/lib/docker" ]

ENV DOCKER_BUILDKIT=1

RUN dnf install --allowerasing -y findutils unzip \
    && chmod +x /usr/local/share/my_init.sh \
    && chmod +x /etc/profile.d/profile.sh \
    && find /tmp/features -type f -exec chmod +x \{\} \; \
    && for x in {0..9}; do for d in /tmp/features/$x-*; do if [ -d "$d" ]; then cd "$d" ; ./install.sh ; fi ; done ; done \
    && curl -k -L https://github.com/jgm/pandoc/releases/latest | tr '\n' '\t' | sed -E -e 's#^.+https://github.com/jgm/pandoc/releases/tag/([0-9\.]*).+$#\1#' | ( read ver ; curl -k -L "https://github.com/jgm/pandoc/releases/download/$ver/pandoc-$ver-linux-amd64.tar.gz" ) | tar xvzf - --strip-components 1 -C /usr/local/ \
    && curl -k -L https://wkhtmltopdf.org/downloads.html | tr '\n' '\t' | sed -E -e 's#^.+https://github.com/wkhtmltopdf/packaging/releases/download/([0-9\.\-]+)/wkhtmltox\-[0-9\.\-]+\.amazonlinux2\.x86_64\.rpm.+$#\1#' | ( read ver ; curl -k -L -o /tmp/wkhtmltox.rpm "https://github.com/wkhtmltopdf/packaging/releases/download/$ver/wkhtmltox-$ver.amazonlinux2.x86_64.rpm" ) \
    && dnf install --allowerasing -y /tmp/wkhtmltox.rpm \
    && cd /tmp && rm -rf /tmp/*

USER codespace

SHELL [ "/bin/bash", "-c" ]
ENV SDKMAN_DIR=/usr/local/sdkman
ENV NVM_DIR=/usr/local/share/nvm

# RUN curl -s "https://get.sdkman.io" | bash \
#     && source "/home/codespace/.sdkman/bin/sdkman-init.sh" \
#     && sdk install java 17.0.8-amzn \
#     && sdk install maven \
RUN . $SDKMAN_DIR/bin/sdkman-init.sh \
    && umask 0002 && . $NVM_DIR/nvm.sh \
    && sdk install quarkus \
    && npm install -g yarn aws-cdk \
    && curl -o /tmp/kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl \
    && chmod +x /tmp/kubectl \
    && mkdir -p /home/codespace/bin && mv /tmp/kubectl /home/codespace/bin/kubectl && export PATH="$PATH:/home/codespace/bin" \
    && echo 'export PATH="$PATH:$HOME/bin"' >> ~/.bashrc

USER root

ENTRYPOINT [ "/usr/local/share/my_init.sh", "/usr/local/share/docker-init.sh", "/usr/local/share/ssh-init.sh"]
CMD [ "/bin/sh", "-c", "echo \"Container started\"; trap \"exit 0\" 15; while sleep 1 & wait $!; do :; done" ]
