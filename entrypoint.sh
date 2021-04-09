#!/bin/bash
set -e
# remove a potentially pre-existing server.pid for Rails
rm -f /myapp/tmp/pids/server.pid
# then exec the container's main process
exec "$@"