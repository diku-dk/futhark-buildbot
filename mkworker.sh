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

cp worker-data/* /futhark-bb
cd /

virtualenv-2.7 --no-site-packages futhark-bb

cd futhark-bb

source bin/activate

easy_install "buildbot-worker==0.9.3"

pip install numpy
pip install pyopencl

rm -rf "$worker"

buildbot-worker create-worker "$worker" "$master" "$worker" "$password"

buildbot-worker start "$worker"
