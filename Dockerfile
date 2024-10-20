FROM alpine:latest

RUN apk add --no-cache curl gcc sbcl make libc-dev linux-headers

RUN cd /tmp && curl -O http://tenet.dl.sourceforge.net/project/sbcl/sbcl/2.4.9/sbcl-2.4.9-source.tar.bz2 && tar jxvf sbcl-2.4.9-source.tar.bz2 && cd /tmp/sbcl-2.4.9 && sh ./make.sh  && sh ./install.sh && rm -rf /tmp/sbcl* && \
    apk del sbcl && \
    cd /tmp && curl -O https://beta.quicklisp.org/quicklisp.lisp && echo "(load \"quicklisp.lisp\") (quicklisp-quickstart:install :path \"/opt/quicklisp\") (ql::without-prompting (ql:add-to-init-file))" | sbcl && cp $HOME/.sbclrc /etc/sbclrc && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT sbcl --eval "(ql:quickload :swank)" \
    --eval "(setf swank::*loopback-interface* \"0.0.0.0\")" \
    --eval "(swank:create-server :dont-close t)"

EXPOSE 4005
