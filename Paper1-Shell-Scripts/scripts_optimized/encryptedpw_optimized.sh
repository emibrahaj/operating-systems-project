#!/bin/bash
# Optimized encryptedpw.sh
# Safer modern version using sftp instead of ftp.
# Password should not be hardcoded. Use SSH keys or an SSH agent.

E_BADARGS=85
E_NOFILE=86

if [ $# -ne 1 ]; then
    echo "Usage: $(basename "$0") filename"
    exit $E_BADARGS
fi

if [ ! -f "$1" ]; then
    echo "File \"$1\" does not exist."
    exit $E_NOFILE
fi

USERNAME="${SFTP_USER:-bozo}"
SERVER="${SFTP_SERVER:-example.com}"
DIRECTORY="${SFTP_DIR:-/upload}"
FILENAME=$(basename "$1")

sftp "${USERNAME}@${SERVER}" <<EOF
cd "$DIRECTORY"
put "$1" "$FILENAME"
bye
EOF

exit $?
