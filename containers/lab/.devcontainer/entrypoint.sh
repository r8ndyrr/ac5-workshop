#!/usr/bin/env bash

set +e

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

if [ -z "${CODE_SERVER_BIND_ADDR}" ]; then
    CODE_SERVER_BIND_ADDR="0.0.0.0:5000"
fi
code-server --bind-addr ${CODE_SERVER_BIND_ADDR} --auth password --disable-telemetry --disable-update-check --disable-workspace-trust "${CONTAINERWSF}" &