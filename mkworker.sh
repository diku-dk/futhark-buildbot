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

master=futhark-lang.org
port=9989

worker=$1
password=$2

set -e # Die on error
set -x # Show commands as they are executed

ulimit -u 100000 # We may need tons of threads!

virtualenv-3.6 --no-site-packages /futhark-bb
source /futhark-bb/bin/activate

pip install -r requirements-worker.txt

# rm -rf "$worker"

cd /futhark-bb

buildbot-worker create-worker "$worker" "$master:$port" "$worker" "$password"

buildbot-worker start "$worker"
