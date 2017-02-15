#!/bin/sh
#
# The GPU APL machines are a little bit crap, in that they unmount
# their home directories after a while.  Try to set up an environment
# that will work for them.

export LIBRARY_PATH=/usr/local/cuda/lib64
export LD_LIBRARY_PATH=/usr/local/cuda/lib64/
export CPATH=/usr/local/cuda/include:
export PATH=/usr/local/cuda/bin:/usr/sbin:/sbin:/usr/games:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin

./mkworker.sh "$@"
