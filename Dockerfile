FROM alpine:latest

ARG SBCL_VERSION="2.5.0"

RUN apk add --no-cache curl gcc sbcl make libc-dev linux-headers

RUN cd /tmp && curl -O http://tenet.dl.sourceforge.net/project/sbcl/sbcl/${SBCL_VERSION}/sbcl-${SBCL_VERSION}-source.tar.bz2 && tar jxvf sbcl-${SBCL_VERSION}-source.tar.bz2 && cd /tmp/sbcl-${SBCL_VERSION} && sh ./make.sh  && sh ./install.sh && rm -rf /tmp/sbcl* && \
    apk del sbcl && \
    cd /tmp && curl -O https://beta.quicklisp.org/quicklisp.lisp && echo "(load \"quicklisp.lisp\") (quicklisp-quickstart:install :path \"/opt/quicklisp\") (ql::without-prompting (ql:add-to-init-file))" | sbcl && cp $HOME/.sbclrc /etc/sbclrc && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT sbcl --eval "(ql:quickload :swank)" \
    --eval "(setf swank::*loopback-interface* \"0.0.0.0\")" \
    --eval "(swank:create-server :dont-close t :port 4005)"

EXPOSE 4005
