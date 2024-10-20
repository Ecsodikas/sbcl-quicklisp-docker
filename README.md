# sbcl-quicklisp-docker
A docker image running sbcl with quicklisp preinstalled and a swank server listening on port 4005.

## Setup

You can just clone the repo and `docker build -t <name> .` afterwards you can `docker run -it -p <host-port>:4005 <name>`. You can connect to the swank server with the swank client of your choice.

For example with the `swank-client` system from quicklisp.

```
CL-USER> (ql:quickload :swank-client)

CL-USER> (swank-client:with-slime-connection (connection "localhost" 12345) (swank-client:slime-eval '(+ 1 2) connection))
```
