#! /usr/bin/env sh

# Where are we going to mount the remote bucket resource in our container.
DEST=${MOUNT:-/opt/s3fs/bucket}

# Check variables and defaults
if [ -z "${ACCESS_KEY_ID}" -a -z "${SECRET_ACCESS_KEY}" -a -z "${SECRET_ACCESS_KEY_FILE}" -a -z "${AUTHFILE}" ]; then
    echo "You need to provide some credentials!!"
    exit
fi
if [ -z "${BUCKET}" ]; then
    echo "No bucket name provided!"
    exit
fi
if [ -z "${URL}" ]; then
    URL="https://s3.amazonaws.com"
fi

if [ -n "${SECRET_ACCESS_KEY_FILE}" ]; then
    SECRET_ACCESS_KEY=$(read ${SECRET_ACCESS_KEY_FILE})
fi

# Create or use authorisation file
if [ -z "${AUTHFILE}" ]; then
    AUTHFILE=/opt/s3fs/passwd-s3fs
    echo "${ACCESS_KEY_ID}:${SECRET_ACCESS_KEY}" > ${AUTHFILE}
    chmod 600 ${AUTHFILE}
fi

# forget about the password once done (this will have proper effects when the
# PASSWORD_FILE-version of the setting is used)
if [ -n "${SECRET_ACCESS_KEY}" ]; then
    unset SECRET_ACCESS_KEY
fi

# Create destination directory if it does not exist.
if [ ! -d $DEST ]; then
    mkdir -p $DEST
fi

GROUP_NAME=$(getent group "${GID}" | cut -d":" -f1)

# Add a group
if [ $GID -gt 0 -a -z "${GROUP_NAME}" ]; then
    addgroup -g $GID -S $GID
    GROUP_NAME=$GID
fi

# Add a user
if [ $UID -gt 0 ]; then
    adduser -u $UID -D -G $GROUP_NAME $UID
    RUN_AS=$UID
    chown $UID:$GID $MOUNT
    chown $UID:$GID ${AUTHFILE}
    chown $UID:$GID /opt/s3fs
fi

# Debug options
DEBUG_OPTS=
if [ $S3FS_DEBUG = "1" ]; then
    DEBUG_OPTS="-d -d"
fi

# Additional S3FS options
if [ -n "$S3FS_ARGS" ]; then
    S3FS_ARGS="-o $S3FS_ARGS"
fi

# Mount and verify that something is present. davfs2 always creates a lost+found
# sub-directory, so we can use the presence of some file/dir as a marker to
# detect that mounting was a success. Execute the command on success.

su - $RUN_AS -c "s3fs $DEBUG_OPTS ${S3FS_ARGS} \
    -o passwd_file=${AUTHFILE} \
    -o url=${URL} \
    -o uid=$UID \
    -o gid=$GID \
    ${BUCKET} ${MOUNT}"

# s3fs can claim to have a mount even though it didn't succeed.
# Doing an operation actually forces it to detect that and remove the mount.
ls "${MOUNT}"

mounted=$(mount | grep fuse.s3fs | grep "${MOUNT}")
if [ -n "${mounted}" ]; then
    echo "Mounted bucket ${BUCKET} onto ${MOUNT}"
    exec "$@"
else
    echo "Mount failure"
fi