#!/bin/bash

set -e

wget -qO - https://repositories.intel.com/gpu/intel-graphics.key |
  sudo gpg --yes --dearmor --output /usr/share/keyrings/intel-graphics.gpg

sudo apt install -y gpg-agent

. /etc/os-release
if [[ ! " jammy " =~ " ${VERSION_CODENAME} " ]]; then
  echo "Ubuntu version ${VERSION_CODENAME} not supported"
else
  wget -qO - https://repositories.intel.com/gpu/intel-graphics.key |
    sudo gpg --yes --dearmor --output /usr/share/keyrings/intel-graphics.gpg
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/gpu/ubuntu ${VERSION_CODENAME}/lts/2350 unified" |
    sudo tee /etc/apt/sources.list.d/intel-gpu-${VERSION_CODENAME}.list
  sudo apt update
fi

sudo apt install -y \
  linux-headers-$(uname -r) \
  linux-modules-extra-$(uname -r) \
  flex bison \
  intel-fw-gpu intel-i915-dkms xpu-smi

sudo apt install -y \
  intel-opencl-icd intel-level-zero-gpu level-zero \
  intel-media-va-driver-non-free libmfx1 libmfxgen1 libvpl2 \
  libegl-mesa0 libegl1-mesa libegl1-mesa-dev libgbm1 libgl1-mesa-dev libgl1-mesa-dri \
  libglapi-mesa libgles2-mesa-dev libglx-mesa0 libigdgmm12 libxatracker2 mesa-va-drivers \
  mesa-vdpau-drivers mesa-vulkan-drivers va-driver-all vainfo hwinfo clinfo

sudo apt install -y \
  libigc-dev intel-igc-cm libigdfcl-dev libigfxcmrt-dev level-zero-dev

wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | sudo tee /usr/share/keyrings/oneapi-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list
sudo apt update

sudo apt install -y intel-oneapi-common-vars=2023.2.0-49462 \
  intel-oneapi-compiler-cpp-eclipse-cfg=2023.2.0-49495 intel-oneapi-compiler-dpcpp-eclipse-cfg=2023.2.0-49495 \
  intel-oneapi-diagnostics-utility=2022.4.0-49091 \
  intel-oneapi-compiler-dpcpp-cpp=2023.2.0-49495 \
  intel-oneapi-mkl=2023.2.0-49495 intel-oneapi-mkl-devel=2023.2.0-49495 \
  intel-oneapi-mpi=2021.10.0-49371 intel-oneapi-mpi-devel=2021.10.0-49371 \
  intel-oneapi-tbb=2021.10.0-49541 intel-oneapi-tbb-devel=2021.10.0-49541 \
  intel-oneapi-ccl=2021.10.0-49084 intel-oneapi-ccl-devel=2021.10.0-49084 \
  intel-oneapi-dnnl-devel=2023.2.0-49516 intel-oneapi-dnnl=2023.2.0-49516

# sudo reboot
