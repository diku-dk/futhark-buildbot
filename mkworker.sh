#!/bin/sh
#
# Utility script for creating the folder structure necessary for a
# Futhark buildbot worker.  Does not install stack and the like, only
# the buildbot worker stuff, using a Python virtualenv.  You can use
# this to start up the worker after the machine has rebooted.
#
# Assumes that we have write-permission to /futhark-bb.  Use
# mkworker-dir.sh to take care of this.

if [ $# -lt 2 ]; then
    echo "Usage: <workername> <password>"
    exit 1
fi

master=buildbot.futhark-lang.org

worker=$1
password=$2

set -e # Die on error
set -x # Show commands as they are executed

ulimit -u 100000 # We may need tons of threads!

cp worker-data/* /futhark-bb
cd /

virtualenv-3.6 --no-site-packages futhark-bb

cd futhark-bb

source bin/activate

pip install "buildbot-worker==2.2.0"

pip install numpy
pip install pyopencl
pip install jsonschema

# rm -rf "$worker"

buildbot-worker create-worker "$worker" "$master" "$worker" "$password"

buildbot-worker start "$worker"
