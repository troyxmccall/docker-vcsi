#!/bin/sh

# Modify vcsi user and group IDs to match the host user and group IDs if the arguments are passed and not macOS
if [ -n "$HOST_USER_UID" ] && [ -n "$HOST_USER_GID" ] && [ "$(uname)" != "Darwin" ] && [ "$HOST_USER_GID" != "20" ]; then
    deluser vcsi
    addgroup -g $HOST_USER_GID vcsi
    adduser -u $HOST_USER_UID -G vcsi -D -H vcsi
else
    echo "Skipping usermod and groupmod due to macOS or GID 20"
fi

# Determine the command to execute
COMMAND="exec"
if [ -n "$HOST_USER_UID" ] && [ -n "$HOST_USER_GID" ]; then
    COMMAND="su-exec vcsi"
fi

# run as root
if [ "$EXEC_AS_ROOT" = "true" ] || [ "$EXEC_AS_ROOT" = "1" ]; then
    COMMAND="exec"
fi

# Execute the passed command with the correct user
$COMMAND "$@"
