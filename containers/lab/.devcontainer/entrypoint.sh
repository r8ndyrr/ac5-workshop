#!/usr/bin/env bash

set +e

if [ -z "${CODE_SERVER_BIND_ADDR}" ]; then
    CODE_SERVER_BIND_ADDR="0.0.0.0:5000"
fi
code-server --bind-addr ${CODE_SERVER_BIND_ADDR} --auth password --disable-telemetry --disable-update-check --disable-workspace-trust "${CONTAINERWSF}" &

# run magic moby script for D-in-D
/usr/local/share/docker-init.sh

# check if ceos-lab image already present
if [ -z "$(${CONTAINER_ENGINE} image ls | grep 'arista/ceos')" ]; then
    docker load < ceos_lab.tar.gz
    echo "WARNING: cEOS-lab image was successfully loaded."
fi

# start the lab
make start

# on Codespaces this will not work correctly
if ! ${CODESPACES:-false}; then
    # Execute command from docker cli if any.
    if [ ${@+True} ]; then
        exec "$@"
    # Otherwise just enter sh or zsh.
    else
        if [ -f "/bin/zsh" ]; then
            exec zsh
        else
            exec sh
        fi
    fi
fi