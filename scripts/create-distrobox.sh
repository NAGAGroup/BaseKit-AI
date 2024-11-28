#!/bin/bash

distrobox rm -f ollama

# t="cat /etc/apt.host/apt.conf >> /etc/apt/apt.conf"
t="echo 'Acquire::http::Proxy \\\""${http_proxy}"\\\";' > /etc/apt/apt.conf.d/proxy.conf; echo 'Acquire::https::Proxy \\\""${http_proxy}"\\\";' >> /etc/apt/apt.conf.d/proxy.conf;"
export no_proxy=
export NO_PROXY=
distrobox create --name ollama --image docker.io/intelanalytics/ipex-llm-inference-cpp-xpu:latest --pre-init-hooks "${t}" --volume /etc/apt:/etc/apt.host
