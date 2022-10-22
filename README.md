# Hello, Python!

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/hello-python-helm)](https://artifacthub.io/packages/search?repo=hello-python-helm)

Tiny Containerized Hello App in Python for Kubernetes testing on Arm or Intel architectures.

## Requirements

Working Kubernetes installation and optionally LoadBalancer

## Usage as a Helm Chart

```shell
> helm repo add irakli-py https://raw.githubusercontent.com/inadarei/hello-python-helm/main/charts/
> helm repo update irakli-py
> helm install irakli-hello-py irakli-py/ms-hello-python
```
