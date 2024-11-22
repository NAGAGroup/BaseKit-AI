#!/bin/bash

set -e

pip install --pre --upgrade ipex-llm[xpu] --extra-index-url https://pytorch-extension.intel.com/release-whl/stable/xpu/us/

pip install --pre --upgrade ipex-llm[cpp]
init-ollama

cp ollama "$CONDA_PREFIX/bin"
