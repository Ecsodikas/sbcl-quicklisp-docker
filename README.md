# sbcl-quicklisp-docker
A docker image running [SBCL](https://www.sbcl.org) with quicklisp preinstalled and a swank server listening on port 4005.

Currently the image only loads the current version of SBCL, which is currently 2.4.9.

## Setup

You can just clone the repo and `docker build -t <name> .` afterwards you can `docker run -it -p <host-port>:4005 <name>`. You can connect to the swank server via a swank client of your choice.

For example with the [swank-client](https://github.com/brown/swank-client) system from quicklisp.

```
CL-USER> (ql:quickload :swank-client)

CL-USER> (swank-client:with-slime-connection (connection "localhost" 12345) (swank-client:slime-eval '(+ 1 2) connection))
```
