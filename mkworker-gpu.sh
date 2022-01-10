#!/bin/sh
#
# The GPU APL machines are a little bit crap, in that they unmount
# their home directories after a while.  Try to set up an environment
# that will work for them.

CUDA_PATH=/usr/local/cuda
ROCM_PATH=/opt/rocm

export LIBRARY_PATH=$CUDA_PATH/lib64:$ROCM_PATH/opencl/lib:
export LD_LIBRARY_PATH=$CUDA_PATH/lib64/:$ROCM_PATH/opencl/lib:
export CPATH=$CUDA_PATH/include:$ROCM_PATH/opencl/include:
export PATH=$CUDA_PATH/bin:$ROCM_PATH/bin:/usr/sbin:/sbin:/usr/games:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
export HOME=/futhark-bb

./mkworker.sh "$@"
