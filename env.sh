export LD_LIBRARY_PATH="$CONDA_PREFIX/lib:$LD_LIBRARY_PATH"
export PATH="$CONDA_PREFIX/go/bin:$PATH"
export GOBIN="$GOROOT/bin"
if ! command -v local-ai 2>&1 >/dev/null; then
  export LD_PRELOAD=$CONDA_PREFIX/lib/libmkl_core.so:$CONDA_PREFIX/lib/libmkl_sequential.so
fi

echo "--sysroot=$CONDA_BUILD_SYSROOT --gcc-toolchain=$CONDA_PREFIX --target=$HOST $CXXFLAGS" >"$CONDA_PREFIX/bin/icpx.cfg"
echo "--sysroot=$CONDA_BUILD_SYSROOT --gcc-toolchain=$CONDA_PREFIX --target=$HOST $CFLAGS" >"$CONDA_PREFIX/bin/icx.cfg"
