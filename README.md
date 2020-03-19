# mumble-k8s
Dockerfile + Helm Chart for running mumble on a Kubernetes cluster

## Docker Image

You can easily start a server by running:
`docker run -P kierranm/murmur:1.3.0`

This will expose Murmur on an ephemeral port on your machine, though
it is more likely that you will want to specify a port using `-p`.