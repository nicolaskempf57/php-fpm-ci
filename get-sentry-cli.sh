#!/bin/ash
set -eu

SENTRY_DOWNLOAD_Linux_i686="https://downloads.sentry-cdn.com/sentry-cli/1.47.2/sentry-cli-Linux-i686"
SENTRY_DOWNLOAD_Linux_x86_64="https://downloads.sentry-cdn.com/sentry-cli/1.47.2/sentry-cli-Linux-x86_64"
VERSION="1.47.2"
PLATFORM=`uname -s`
ARCH=`uname -m`

INSTALL_DIR=/usr/local/bin
INSTALL_PATH="${INSTALL_DIR}/sentry-cli"

DOWNLOAD_URL_LOOKUP="SENTRY_DOWNLOAD_${PLATFORM}_${ARCH}"
DOWNLOAD_URL="${!DOWNLOAD_URL_LOOKUP:-}"

echo "This script will automatically install sentry-cli ${VERSION} for you."
echo "Installation path: ${INSTALL_PATH}"

if [ -f "$INSTALL_PATH" ]; then
  echo "error: sentry-cli is already installed."
  exit 1
fi

if [ x$DOWNLOAD_URL == x ]; then
  echo "error: your platform and architecture (${PLATFORM}-${ARCH}) is unsupported."
  exit 1
fi

if ! hash curl 2> /dev/null; then
  echo "error: you do not have 'curl' installed which is required for this script."
  exit 1
fi

TEMP_FILE=`mktemp "${TMPDIR:-/tmp}/.sentrycli.XXXXXXXX"`

cleanup() {
  rm -f "$TEMP_FILE"
}

trap cleanup EXIT
curl -SL --progress-bar "$DOWNLOAD_URL" > "$TEMP_FILE"
chmod 0755 "$TEMP_FILE"
if ! mv "$TEMP_FILE" "$INSTALL_PATH" 2> /dev/null; then
  sudo -k mv "$TEMP_FILE" "$INSTALL_PATH"
fi

echo 'Done!'
